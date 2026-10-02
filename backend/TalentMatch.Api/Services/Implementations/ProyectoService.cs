using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Enums;
using TalentMatch.Api.Domain.Exceptions;
using TalentMatch.Api.DTOs.Proyectos;
using TalentMatch.Api.Repositories.Interfaces;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Services.Implementations;

public class ProyectoService : IProyectoService
{
    private readonly IProyectoRepository _proyectoRepository;
    private readonly IUsuarioRepository _usuarioRepository;

    public ProyectoService(IProyectoRepository proyectoRepository, IUsuarioRepository usuarioRepository)
    {
        _proyectoRepository = proyectoRepository;
        _usuarioRepository = usuarioRepository;
    }

    public async Task<IEnumerable<ProyectoResponseDto>> GetAllAsync()
    {
        var proyectos = await _proyectoRepository.GetAllAsync();
        return proyectos.Select(MapToResponseDto);
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

        if (currentUserRole != "Administrador" && proyecto.ProfesorId != (usuario.Profesor?.Id ?? -1))
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

            if (proyecto.ProfesorId != (usuario.Profesor?.Id ?? -1))
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
            Estado = proyecto.Estado,
            FechaCreacion = proyecto.FechaCreacion,
            FechaLimite = proyecto.FechaLimite,
            CuposDisponibles = proyecto.CuposDisponibles,
            ProfesorId = proyecto.ProfesorId
        };
    }
}
