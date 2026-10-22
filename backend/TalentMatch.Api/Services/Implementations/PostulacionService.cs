using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Enums;
using TalentMatch.Api.Domain.Exceptions;
using TalentMatch.Api.DTOs.Postulaciones;
using TalentMatch.Api.Repositories.Interfaces;
using TalentMatch.Api.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using TalentMatch.Api.Data;

namespace TalentMatch.Api.Services.Implementations;

public class PostulacionService : IPostulacionService
{
    private readonly IPostulacionRepository _postulacionRepository;
    private readonly IProyectoRepository _proyectoRepository;
    private readonly IUsuarioRepository _usuarioRepository;
    private readonly INotificacionRepository _notificacionRepository;
    private readonly TalentMatchDbContext _context;

    public PostulacionService(IPostulacionRepository postulacionRepository, IProyectoRepository proyectoRepository, IUsuarioRepository usuarioRepository, INotificacionRepository notificacionRepository, TalentMatchDbContext context)
    {
        _postulacionRepository = postulacionRepository;
        _proyectoRepository = proyectoRepository;
        _usuarioRepository = usuarioRepository;
        _notificacionRepository = notificacionRepository;
        _context = context;
    }

    public async Task<IEnumerable<PostulacionResponseDto>> GetByProyectoIdAsync(int proyectoId, int currentUserId, string currentUserRole)
    {
        var proyecto = await _proyectoRepository.GetByIdAsync(proyectoId)
            ?? throw new TalentMatchException("Proyecto no encontrado.", 404);
        EnsureProjectOwner(proyecto, currentUserId, currentUserRole);
        var postulaciones = await _postulacionRepository.GetByProyectoIdAsync(proyectoId);
        return postulaciones.Select(Map);
    }

    public async Task<IEnumerable<PostulacionResponseDto>> GetMineAsync(int currentUserId, string currentUserRole)
    {
        if (currentUserRole != "Estudiante")
            throw new TalentMatchException("Solo un Estudiante puede consultar sus postulaciones.", 403);

        var usuario = await _usuarioRepository.GetByIdAsync(currentUserId)
            ?? throw new TalentMatchException("Usuario no encontrado.", 404);
        var estudiante = usuario.Estudiante
            ?? throw new TalentMatchException("El usuario no tiene perfil de estudiante asociado.", 404);

        var postulaciones = await _postulacionRepository.GetByEstudianteIdAsync(estudiante.Id);
        return postulaciones.Select(Map);
    }

    public async Task<PostulacionResponseDto> CreateAsync(CrearPostulacionDto dto, int currentUserId, string currentUserRole)
    {
        if (currentUserRole != "Estudiante")
            throw new TalentMatchException("Solo un Estudiante puede crear postulaciones.", 403);

        var currentUser = await _usuarioRepository.GetByIdAsync(currentUserId)
            ?? throw new TalentMatchException("Usuario no encontrado.", 404);
        if (currentUser.Id != dto.EstudianteId)
            throw new TalentMatchException("Solo puedes postularte con tu propio usuario.", 403);

        var proyecto = await _proyectoRepository.GetByIdAsync(dto.ProyectoId)
            ?? throw new TalentMatchException("Proyecto no encontrado.", 404);

        var estudianteRecord = currentUser.Estudiante
            ?? throw new TalentMatchException("El usuario no tiene perfil de estudiante asociado.", 404);

        if (proyecto.Tipo == TipoProyecto.ColaborativoEstudiante && proyecto.CreadorEstudianteId == estudianteRecord.Id)
            throw new TalentMatchException("El creador no puede postularse a su propio proyecto.", 409);

        if (proyecto.Estado == EstadoProyecto.Cerrado)
            throw new TalentMatchException("Un proyecto cerrado no admite postulaciones.", 409);

        var estudiante = currentUser;

        if (estudiante.Rol != RolUsuario.Estudiante)
            throw new TalentMatchException("El usuario no es un estudiante.", 400);

        var exists = await _postulacionRepository.GetByEstudianteYProyectoAsync(estudianteRecord.Id, dto.ProyectoId);
        if (exists is not null)
            throw new TalentMatchException("El estudiante ya está postulado a este proyecto.", 409);

        if (proyecto.CuposDisponibles <= 0)
            throw new TalentMatchException("El proyecto ya no tiene cupos disponibles.", 409);

        var propietarioUsuarioId = proyecto.Tipo == TipoProyecto.ColaborativoEstudiante
            ? proyecto.CreadorEstudiante?.UsuarioId
            : proyecto.Profesor?.UsuarioId;
        if (propietarioUsuarioId is null)
            throw new TalentMatchException("El proyecto no tiene un propietario válido.", 409);

        var postulacion = new Postulacion
        {
            EstudianteId = estudianteRecord.Id,
            ProyectoId = dto.ProyectoId,
            Estado = EstadoPostulacion.Pendiente,
            Mensaje = dto.Mensaje,
            FechaPostulacion = DateTime.UtcNow
        };

        await _postulacionRepository.AddAsync(postulacion);

        var notificacion = new Notificacion
        {
            UsuarioId = propietarioUsuarioId.Value,
            Titulo = "Nueva postulación",
            Mensaje = $"El estudiante {estudiante.Nombre} {estudiante.Apellido} se postuló a {proyecto.Titulo}.",
            Tipo = "Postulacion",
            Leida = false,
            FechaCreacion = DateTime.UtcNow
        };

        await _notificacionRepository.AddAsync(notificacion);

        return new PostulacionResponseDto
        {
            Id = postulacion.Id,
            EstudianteId = postulacion.EstudianteId,
            EstudianteNombre = estudiante.Nombre,
            EstudianteApellido = estudiante.Apellido,
            EstudianteCarrera = estudiante.Estudiante?.Carrera,
            EstudianteSemestre = estudiante.Estudiante?.Semestre,
            ProyectoId = postulacion.ProyectoId,
            Estado = postulacion.Estado,
            Mensaje = postulacion.Mensaje,
            FechaPostulacion = postulacion.FechaPostulacion
        };
    }

    public async Task<PostulacionResponseDto> AcceptAsync(int postulacionId, int currentUserId, string currentUserRole)
    {
        var postulacion = await _postulacionRepository.GetByIdAsync(postulacionId)
            ?? throw new TalentMatchException("Postulación no encontrada.", 404);

        var proyecto = await _proyectoRepository.GetByIdAsync(postulacion.ProyectoId)
            ?? throw new TalentMatchException("Proyecto no encontrado.", 404);
        EnsureProjectOwner(proyecto, currentUserId, currentUserRole);
        EnsurePending(postulacion);

        var aceptadas = await _postulacionRepository.CountAcceptedByProyectoAsync(postulacion.ProyectoId);
        if (aceptadas >= proyecto.CuposDisponibles)
            throw new TalentMatchException("No se puede aceptar una postulación si no hay cupos.", 409);

        await using var transaction = await _context.Database.BeginTransactionAsync();
        if (proyecto.Tipo == TipoProyecto.ColaborativoEstudiante)
        {
            var equipo = await _context.Equipos
                .Include(e => e.Miembros)
                .FirstOrDefaultAsync(e => e.ProyectoId == proyecto.Id)
                ?? throw new TalentMatchException("El proyecto colaborativo no tiene un equipo asociado.", 409);

            if (equipo.Miembros.Any(m => m.EstudianteId == postulacion.EstudianteId))
                throw new TalentMatchException("El estudiante ya pertenece al equipo.", 409);

            _context.MiembrosEquipo.Add(new MiembroEquipo
            {
                EquipoId = equipo.Id,
                EstudianteId = postulacion.EstudianteId,
                FechaIngreso = DateTime.UtcNow
            });
        }

        postulacion.Estado = EstadoPostulacion.Aceptada;
        await _context.SaveChangesAsync();
        await _notificacionRepository.AddAsync(new Notificacion
        {
            UsuarioId = postulacion.Estudiante.UsuarioId,
            Titulo = "Postulación aceptada",
            Mensaje = $"Tu postulación al proyecto {proyecto.Titulo} fue aceptada.",
            Tipo = "Postulacion",
            Leida = false,
            FechaCreacion = DateTime.UtcNow
        });
        await transaction.CommitAsync();

        return new PostulacionResponseDto
        {
            Id = postulacion.Id,
            EstudianteId = postulacion.EstudianteId,
        EstudianteNombre = postulacion.Estudiante.Usuario.Nombre,
        EstudianteApellido = postulacion.Estudiante.Usuario.Apellido,
        EstudianteCarrera = postulacion.Estudiante.Carrera,
        EstudianteSemestre = postulacion.Estudiante.Semestre,
            ProyectoId = postulacion.ProyectoId,
            Estado = postulacion.Estado,
            Mensaje = postulacion.Mensaje,
            FechaPostulacion = postulacion.FechaPostulacion
        };
    }

    public async Task<PostulacionResponseDto> RejectAsync(int postulacionId, int currentUserId, string currentUserRole)
    {
        var postulacion = await _postulacionRepository.GetByIdAsync(postulacionId)
            ?? throw new TalentMatchException("Postulación no encontrada.", 404);
        var proyecto = await _proyectoRepository.GetByIdAsync(postulacion.ProyectoId)
            ?? throw new TalentMatchException("Proyecto no encontrado.", 404);
        EnsureProjectOwner(proyecto, currentUserId, currentUserRole);
        EnsurePending(postulacion);

        postulacion.Estado = EstadoPostulacion.Rechazada;
        await _postulacionRepository.UpdateAsync(postulacion);
        await _notificacionRepository.AddAsync(new Notificacion
        {
            UsuarioId = postulacion.Estudiante.UsuarioId,
            Titulo = "Postulación rechazada",
            Mensaje = $"Tu postulación al proyecto {proyecto.Titulo} fue rechazada.",
            Tipo = "Postulacion",
            Leida = false,
            FechaCreacion = DateTime.UtcNow
        });

        return new PostulacionResponseDto
        {
            Id = postulacion.Id,
            EstudianteId = postulacion.EstudianteId,
            EstudianteNombre = postulacion.Estudiante.Usuario.Nombre,
            EstudianteApellido = postulacion.Estudiante.Usuario.Apellido,
            EstudianteCarrera = postulacion.Estudiante.Carrera,
            EstudianteSemestre = postulacion.Estudiante.Semestre,
            ProyectoId = postulacion.ProyectoId,
            Estado = postulacion.Estado,
            Mensaje = postulacion.Mensaje,
            FechaPostulacion = postulacion.FechaPostulacion
        };
    }

    private static PostulacionResponseDto Map(Postulacion postulacion) => new()
    {
        Id = postulacion.Id,
        EstudianteId = postulacion.EstudianteId,
            EstudianteNombre = postulacion.Estudiante.Usuario.Nombre,
            EstudianteApellido = postulacion.Estudiante.Usuario.Apellido,
            EstudianteCarrera = postulacion.Estudiante.Carrera,
            EstudianteSemestre = postulacion.Estudiante.Semestre,
        ProyectoId = postulacion.ProyectoId,
        Estado = postulacion.Estado,
        Mensaje = postulacion.Mensaje,
        FechaPostulacion = postulacion.FechaPostulacion,
        Proyecto = postulacion.Proyecto is null ? null : new ProyectoPostulacionDto
        {
            Id = postulacion.Proyecto.Id,
            Titulo = postulacion.Proyecto.Titulo,
            Descripcion = postulacion.Proyecto.Descripcion,
            FechaLimite = postulacion.Proyecto.FechaLimite
        }
    };

    private static void EnsureProjectOwner(Proyecto proyecto, int currentUserId, string currentUserRole)
    {
        var isOwner = proyecto.Tipo == TipoProyecto.ColaborativoEstudiante
            ? currentUserRole == "Estudiante"
              && proyecto.CreadorEstudiante?.UsuarioId == currentUserId
              && proyecto.Equipos.Any(e => e.LiderEstudiante?.UsuarioId == currentUserId)
            : currentUserRole == "Profesor" && proyecto.Profesor?.UsuarioId == currentUserId;

        if (currentUserRole != "Administrador" && !isOwner)
            throw new TalentMatchException("No tienes permisos sobre las postulaciones de este proyecto.", 403);
    }

    private static void EnsurePending(Postulacion postulacion)
    {
        if (postulacion.Estado != EstadoPostulacion.Pendiente)
            throw new TalentMatchException("Solo se pueden resolver postulaciones pendientes.", 409);
    }
}
