using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Enums;
using TalentMatch.Api.Domain.Exceptions;
using TalentMatch.Api.DTOs.Equipos;
using TalentMatch.Api.Repositories.Interfaces;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Services.Implementations;

public class EquipoService : IEquipoService
{
    private readonly IEquipoRepository _equipoRepository;
    private readonly IPostulacionRepository _postulacionRepository;
    private readonly IProyectoRepository _proyectoRepository;
    private readonly IUsuarioRepository _usuarioRepository;

    public EquipoService(IEquipoRepository equipoRepository, IPostulacionRepository postulacionRepository, IProyectoRepository proyectoRepository, IUsuarioRepository usuarioRepository)
    {
        _equipoRepository = equipoRepository;
        _postulacionRepository = postulacionRepository;
        _proyectoRepository = proyectoRepository;
        _usuarioRepository = usuarioRepository;
    }

    public async Task<EquipoResponseDto?> GetByIdAsync(int id, int currentUserId, string currentUserRole)
    {
        var equipo = await _equipoRepository.GetByIdAsync(id);
        if (equipo is null) return null;
        EnsureProjectAccess(equipo, currentUserId, currentUserRole);

        return Map(equipo);
    }

    public async Task<IEnumerable<EquipoResponseDto>> GetByUsuarioAsync(int currentUserId, string currentUserRole)
    {
        var equipos = await _equipoRepository.GetByUsuarioIdAsync(currentUserId, currentUserRole);
        return equipos.Select(Map);
    }

    public async Task<EquipoResponseDto> CreateAsync(CrearEquipoDto dto, int currentUserId, string currentUserRole)
    {
        var proyecto = await _proyectoRepository.GetByIdAsync(dto.ProyectoId)
            ?? throw new TalentMatchException("Proyecto no encontrado.", 404);

        if (currentUserRole != "Administrador")
        {
            var usuario = await _usuarioRepository.GetByIdAsync(currentUserId)
                ?? throw new TalentMatchException("Usuario no encontrado.", 404);
            if (proyecto.Tipo != TipoProyecto.AcademicoProfesor || usuario.Profesor?.Id != proyecto.ProfesorId)
                throw new TalentMatchException("Solo el propietario del proyecto puede crear equipos.", 403);
        }

        var equipo = new Equipo
        {
            Nombre = dto.Nombre.Trim(),
            ProyectoId = dto.ProyectoId,
            Estado = EstadoEquipo.Activo,
            FechaCreacion = DateTime.UtcNow
        };

        await _equipoRepository.AddAsync(equipo);
        return new EquipoResponseDto
        {
            Id = equipo.Id,
            Nombre = equipo.Nombre,
            ProyectoId = equipo.ProyectoId,
            LiderUsuarioId = equipo.LiderEstudiante?.UsuarioId,
            Estado = equipo.Estado,
            FechaCreacion = equipo.FechaCreacion
        };
    }

    public async Task<EquipoResponseDto> AssignLeaderAsync(int equipoId, int estudianteId, int currentUserId, string currentUserRole)
    {
        if (currentUserRole != "Profesor")
            throw new TalentMatchException("Solo un Profesor puede asignar el líder del equipo.", 403);

        var equipo = await _equipoRepository.GetByIdAsync(equipoId)
            ?? throw new TalentMatchException("Equipo no encontrado.", 404);

        EnsureProjectAccess(equipo, currentUserId, currentUserRole);

        var miembro = await _equipoRepository.GetMiembroAsync(equipoId, estudianteId);
        if (miembro is null)
            throw new TalentMatchException("El estudiante debe pertenecer al equipo.", 400);

        equipo.LiderEstudianteId = estudianteId;
        await _equipoRepository.UpdateAsync(equipo);

        return Map(equipo);
    }

    public async Task<EquipoResponseDto> AddMiembroAsync(int equipoId, int estudianteId, int currentUserId, string currentUserRole)
    {
        var equipo = await _equipoRepository.GetByIdAsync(equipoId)
            ?? throw new TalentMatchException("Equipo no encontrado.", 404);
        EnsureProjectAccess(equipo, currentUserId, currentUserRole);

        var estudiante = await _usuarioRepository.GetByIdAsync(estudianteId)
            ?? throw new TalentMatchException("Estudiante no encontrado.", 404);

        if (estudiante.Rol != RolUsuario.Estudiante)
            throw new TalentMatchException("El usuario no es un estudiante.", 400);

        var miembroExistente = await _equipoRepository.GetMiembroAsync(equipoId, estudianteId);
        if (miembroExistente is not null)
            throw new TalentMatchException("El estudiante ya pertenece al equipo.", 409);

        var miembro = new MiembroEquipo
        {
            EquipoId = equipoId,
            EstudianteId = estudianteId,
            FechaIngreso = DateTime.UtcNow
        };

        await _equipoRepository.AddMiembroAsync(miembro);

        return new EquipoResponseDto
        {
            Id = equipo.Id,
            Nombre = equipo.Nombre,
            ProyectoId = equipo.ProyectoId,
        LiderUsuarioId = equipo.LiderEstudiante?.UsuarioId,
            Estado = equipo.Estado,
            FechaCreacion = equipo.FechaCreacion
        };
    }

    private static void EnsureProjectAccess(Equipo equipo, int currentUserId, string currentUserRole)
    {
        if (currentUserRole == "Administrador")
            return;

        var ownerId = equipo.Proyecto?.Profesor?.UsuarioId;
        if (ownerId != currentUserId)
            throw new TalentMatchException("No tienes permisos sobre este equipo.", 403);
    }

    private static EquipoResponseDto Map(Equipo equipo) => new()
    {
        Id = equipo.Id,
        Nombre = equipo.Nombre,
        ProyectoId = equipo.ProyectoId,
        LiderUsuarioId = equipo.LiderEstudiante?.UsuarioId,
        Estado = equipo.Estado,
        FechaCreacion = equipo.FechaCreacion,
        Proyecto = equipo.Proyecto is null ? null : new ProyectoEquipoDto
        {
            Id = equipo.Proyecto.Id,
            Titulo = equipo.Proyecto.Titulo,
            Descripcion = equipo.Proyecto.Descripcion,
            FechaLimite = equipo.Proyecto.FechaLimite,
            ProfesorId = equipo.Proyecto.Profesor?.UsuarioId,
            CuposDisponibles = equipo.Proyecto.CuposDisponibles
        },
        Miembros = equipo.Miembros.Select(m => new MiembroEquipoDto
        {
            EstudianteId = m.EstudianteId,
            UsuarioId = m.Estudiante.UsuarioId,
            Nombre = m.Estudiante.Usuario.Nombre,
            Apellido = m.Estudiante.Usuario.Apellido,
            FechaIngreso = m.FechaIngreso
        }).ToArray()
    };
}
