using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Enums;
using TalentMatch.Api.Domain.Exceptions;
using TalentMatch.Api.DTOs.Proyectos;
using TalentMatch.Api.DTOs.Equipos;
using Microsoft.EntityFrameworkCore;
using TalentMatch.Api.Repositories.Interfaces;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Services.Implementations;

public class ProyectoService : IProyectoService
{
    private readonly IProyectoRepository _proyectoRepository;
    private readonly IUsuarioRepository _usuarioRepository;
    private readonly TalentMatch.Api.Data.TalentMatchDbContext _context;

    public ProyectoService(IProyectoRepository proyectoRepository, IUsuarioRepository usuarioRepository, TalentMatch.Api.Data.TalentMatchDbContext context)
    {
        _proyectoRepository = proyectoRepository;
        _usuarioRepository = usuarioRepository;
        _context = context;
    }

    public async Task<IEnumerable<ProyectoResponseDto>> GetAllAsync()
    {
        var proyectos = await _proyectoRepository.GetAllAsync();
        return proyectos.Select(MapToResponseDto);
    }

    public async Task<ProyectoColaborativoResponseDto> CreateCollaborativeAsync(CrearProyectoColaborativoDto dto, int currentUserId, string currentUserRole)
    {
        if (currentUserRole != "Estudiante")
            throw new TalentMatchException("Solo un Estudiante puede crear proyectos colaborativos.", 403);
        if (string.IsNullOrWhiteSpace(dto.Titulo) || string.IsNullOrWhiteSpace(dto.Descripcion))
            throw new TalentMatchException("El título y la descripción son obligatorios.", 400);
        if (dto.CuposDisponibles <= 0)
            throw new TalentMatchException("Los cupos deben ser mayores que cero.", 400);
        if (dto.FechaLimite is not null && dto.FechaLimite.Value.Date < DateTime.UtcNow.Date)
            throw new TalentMatchException("La fecha límite no puede ser anterior a la fecha actual.", 400);

        var usuario = await _context.Usuarios.Include(u => u.Estudiante).FirstOrDefaultAsync(u => u.Id == currentUserId)
            ?? throw new TalentMatchException("Usuario no encontrado.", 404);
        if (usuario.Rol != RolUsuario.Estudiante || usuario.Estudiante is null)
            throw new TalentMatchException("El usuario autenticado no tiene perfil de Estudiante.", 403);

        var habilidadIds = dto.HabilidadesIds.Distinct().ToArray();
        var interesIds = dto.InteresesIds.Distinct().ToArray();
        if (await _context.Habilidades.CountAsync(h => habilidadIds.Contains(h.Id)) != habilidadIds.Length ||
            await _context.Intereses.CountAsync(i => interesIds.Contains(i.Id)) != interesIds.Length)
            throw new TalentMatchException("Una o más habilidades o intereses no existen.", 400);

        await using var transaction = await _context.Database.BeginTransactionAsync();
        var proyecto = new Proyecto
        {
            Titulo = dto.Titulo.Trim(), Descripcion = dto.Descripcion.Trim(),
            Objetivo = string.IsNullOrWhiteSpace(dto.Objetivo) ? null : dto.Objetivo.Trim(),
            FechaLimite = dto.FechaLimite, CuposDisponibles = dto.CuposDisponibles,
            Tipo = TipoProyecto.ColaborativoEstudiante, CreadorEstudianteId = usuario.Estudiante.Id,
            Estado = EstadoProyecto.Abierto, FechaCreacion = DateTime.UtcNow
        };
        _context.Proyectos.Add(proyecto);
        await _context.SaveChangesAsync();
        _context.ProyectoHabilidades.AddRange(habilidadIds.Select(id => new ProyectoHabilidad { ProyectoId = proyecto.Id, HabilidadId = id }));
        _context.ProyectoIntereses.AddRange(interesIds.Select(id => new ProyectoInteres { ProyectoId = proyecto.Id, InteresId = id }));
        var equipo = new Equipo
        {
            Nombre = proyecto.Titulo, ProyectoId = proyecto.Id, LiderEstudianteId = usuario.Estudiante.Id,
            Estado = EstadoEquipo.Activo, FechaCreacion = DateTime.UtcNow
        };
        _context.Equipos.Add(equipo);
        await _context.SaveChangesAsync();
        _context.MiembrosEquipo.Add(new MiembroEquipo { EquipoId = equipo.Id, EstudianteId = usuario.Estudiante.Id, FechaIngreso = DateTime.UtcNow });
        await _context.SaveChangesAsync();
        await transaction.CommitAsync();

        var persisted = await _context.Equipos
            .Include(e => e.Proyecto).ThenInclude(p => p!.Profesor).ThenInclude(p => p!.Usuario)
            .Include(e => e.LiderEstudiante).ThenInclude(e => e!.Usuario)
            .Include(e => e.Miembros).ThenInclude(m => m.Estudiante).ThenInclude(e => e.Usuario)
            .FirstAsync(e => e.Id == equipo.Id);
        return new ProyectoColaborativoResponseDto
        {
            Id = proyecto.Id, Titulo = proyecto.Titulo, Descripcion = proyecto.Descripcion,
            Objetivo = proyecto.Objetivo, Tipo = proyecto.Tipo, Estado = proyecto.Estado,
            FechaCreacion = proyecto.FechaCreacion, FechaLimite = proyecto.FechaLimite,
            CuposDisponibles = proyecto.CuposDisponibles, CreadorEstudianteId = usuario.Estudiante.Id,
            LiderUsuarioId = currentUserId, HabilidadesIds = habilidadIds, InteresesIds = interesIds,
            Equipo = MapTeam(persisted)
        };
    }

    public async Task<IEnumerable<ProyectoColaborativoResponseDto>> GetMyCollaborativeAsync(int currentUserId, string currentUserRole)
    {
        if (currentUserRole != "Estudiante")
            throw new TalentMatchException("Solo un Estudiante puede consultar sus proyectos colaborativos.", 403);
        var proyectos = await _context.Proyectos
            .Where(p => p.Tipo == TipoProyecto.ColaborativoEstudiante && p.CreadorEstudiante != null && p.CreadorEstudiante.UsuarioId == currentUserId)
            .Include(p => p.ProyectoHabilidades).Include(p => p.ProyectoIntereses)
            .Include(p => p.Equipos).ThenInclude(e => e.LiderEstudiante).ThenInclude(e => e!.Usuario)
            .Include(p => p.Equipos).ThenInclude(e => e.Miembros).ThenInclude(m => m.Estudiante).ThenInclude(e => e.Usuario)
            .ToListAsync();
        return proyectos.Select(p => new ProyectoColaborativoResponseDto
        {
            Id = p.Id, Titulo = p.Titulo, Descripcion = p.Descripcion, Objetivo = p.Objetivo,
            Tipo = p.Tipo, Estado = p.Estado, FechaCreacion = p.FechaCreacion, FechaLimite = p.FechaLimite,
            CuposDisponibles = p.CuposDisponibles, CreadorEstudianteId = p.CreadorEstudianteId!.Value,
            LiderUsuarioId = p.CreadorEstudiante!.UsuarioId, HabilidadesIds = p.ProyectoHabilidades.Select(x => x.HabilidadId).ToArray(),
            InteresesIds = p.ProyectoIntereses.Select(x => x.InteresId).ToArray(),
            Equipo = p.Equipos.Select(MapTeam).First()
        });
    }

    public async Task<ProyectoResponseDto?> GetByIdAsync(int id)
    {
        var proyecto = await _proyectoRepository.GetByIdAsync(id);
        return proyecto is null ? null : MapToResponseDto(proyecto);
    }

    public async Task<ProyectoResponseDto> CreateAsync(CrearProyectoDto dto, int currentUserId, string currentUserRole)
    {
        if (currentUserRole != "Profesor")
            throw new TalentMatchException("Solo un Profesor puede crear proyectos.", 403);

        ValidateProyecto(dto.Titulo, dto.Descripcion, dto.FechaLimite, dto.CuposDisponibles);

        var usuario = await _usuarioRepository.GetByIdAsync(currentUserId)
            ?? throw new TalentMatchException("Usuario no encontrado.", 404);

        if (usuario.Rol != RolUsuario.Profesor)
            throw new TalentMatchException("El usuario autenticado no tiene rol de Profesor.", 403);

        var profesor = usuario.Profesor ?? new Profesor
        {
            UsuarioId = usuario.Id,
            CodigoProfesor = $"PRO-{usuario.Id:D6}",
            Facultad = "No especificada"
        };

        if (usuario.Profesor is null)
        {
            _context.Profesores.Add(profesor);
            await _context.SaveChangesAsync();
            usuario.Profesor = profesor;
        }

        var proyecto = new Proyecto
        {
            Titulo = dto.Titulo.Trim(),
            Descripcion = dto.Descripcion.Trim(),
            FechaLimite = dto.FechaLimite,
            CuposDisponibles = dto.CuposDisponibles,
            ProfesorId = profesor.Id,
            Estado = EstadoProyecto.Abierto,
            Profesor = profesor,
            FechaCreacion = DateTime.UtcNow
        };

        await _proyectoRepository.AddAsync(proyecto);
        return MapToResponseDto(proyecto);
    }

    public async Task<ProyectoResponseDto> UpdateAsync(int id, ActualizarProyectoDto dto, int currentUserId, string currentUserRole)
    {
        var proyecto = await _proyectoRepository.GetByIdAsync(id)
            ?? throw new TalentMatchException("Proyecto no encontrado.", 404);

        var usuario = await _usuarioRepository.GetByIdAsync(currentUserId)
            ?? throw new TalentMatchException("Usuario no encontrado.", 404);

        if (proyecto.Tipo != TipoProyecto.AcademicoProfesor || (currentUserRole != "Administrador" && proyecto.ProfesorId != (usuario.Profesor?.Id ?? -1)))
            throw new TalentMatchException("No puedes modificar este proyecto.", 403);

        ValidateProyecto(dto.Titulo, dto.Descripcion, dto.FechaLimite, dto.CuposDisponibles);

        proyecto.Titulo = dto.Titulo.Trim();
        proyecto.Descripcion = dto.Descripcion.Trim();
        proyecto.FechaLimite = dto.FechaLimite;
        proyecto.CuposDisponibles = dto.CuposDisponibles;

        await _proyectoRepository.UpdateAsync(proyecto);
        return MapToResponseDto(proyecto);
    }

    public async Task DeleteAsync(int id, int currentUserId, string currentUserRole)
    {
        var proyecto = await _proyectoRepository.GetByIdAsync(id)
            ?? throw new TalentMatchException("Proyecto no encontrado.", 404);

        if (currentUserRole != "Administrador")
        {
            var usuario = await _usuarioRepository.GetByIdAsync(currentUserId)
                ?? throw new TalentMatchException("Usuario no encontrado.", 404);

            if (proyecto.Tipo != TipoProyecto.AcademicoProfesor || proyecto.ProfesorId != (usuario.Profesor?.Id ?? -1))
                throw new TalentMatchException("No puedes eliminar este proyecto.", 403);
        }

        await _proyectoRepository.DeleteAsync(id);
    }

    public async Task<IEnumerable<ProyectoResponseDto>> SearchAsync(string? titulo, string? descripcion)
    {
        var proyectos = await _proyectoRepository.SearchAsync(titulo, descripcion);
        return proyectos.Select(MapToResponseDto);
    }

    private static void ValidateProyecto(string titulo, string descripcion, DateTime fechaLimite, int cuposDisponibles)
    {
        if (string.IsNullOrWhiteSpace(titulo))
            throw new TalentMatchException("El título del proyecto es obligatorio.", 400);

        if (string.IsNullOrWhiteSpace(descripcion))
            throw new TalentMatchException("La descripción del proyecto es obligatoria.", 400);

        if (fechaLimite.Date < DateTime.UtcNow.Date)
            throw new TalentMatchException("La fecha límite no puede ser anterior a la fecha actual.", 400);

        if (cuposDisponibles <= 0)
            throw new TalentMatchException("Los cupos del proyecto deben ser mayores a cero.", 400);
    }

    private static ProyectoResponseDto MapToResponseDto(Proyecto proyecto)
    {
        return new ProyectoResponseDto
        {
            Id = proyecto.Id,
            Titulo = proyecto.Titulo,
            Descripcion = proyecto.Descripcion,
            Objetivo = proyecto.Objetivo,
            Tipo = proyecto.Tipo,
            CreadorEstudianteId = proyecto.CreadorEstudianteId,
            Estado = proyecto.Estado,
            FechaCreacion = proyecto.FechaCreacion,
            FechaLimite = proyecto.FechaLimite,
            CuposDisponibles = proyecto.CuposDisponibles,
            ProfesorId = proyecto.Profesor?.UsuarioId
        };
    }

    private static EquipoResponseDto MapTeam(Equipo equipo) => new()
    {
        Id = equipo.Id, Nombre = equipo.Nombre, ProyectoId = equipo.ProyectoId,
        LiderUsuarioId = equipo.LiderEstudiante?.UsuarioId, Estado = equipo.Estado, FechaCreacion = equipo.FechaCreacion,
        Proyecto = equipo.Proyecto is null ? null : new ProyectoEquipoDto
        {
            Id = equipo.Proyecto.Id, Titulo = equipo.Proyecto.Titulo, Descripcion = equipo.Proyecto.Descripcion,
            FechaLimite = equipo.Proyecto.FechaLimite, ProfesorId = equipo.Proyecto.Profesor?.UsuarioId,
            CuposDisponibles = equipo.Proyecto.CuposDisponibles
        },
        Miembros = equipo.Miembros.Select(m => new MiembroEquipoDto
        {
            EstudianteId = m.EstudianteId, UsuarioId = m.Estudiante.UsuarioId,
            Nombre = m.Estudiante.Usuario.Nombre, Apellido = m.Estudiante.Usuario.Apellido, FechaIngreso = m.FechaIngreso
        }).ToArray()
    };
}
