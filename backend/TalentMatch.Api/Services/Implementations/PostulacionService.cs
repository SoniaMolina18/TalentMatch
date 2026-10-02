using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Enums;
using TalentMatch.Api.Domain.Exceptions;
using TalentMatch.Api.DTOs.Postulaciones;
using TalentMatch.Api.Repositories.Interfaces;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Services.Implementations;

public class PostulacionService : IPostulacionService
{
    private readonly IPostulacionRepository _postulacionRepository;
    private readonly IProyectoRepository _proyectoRepository;
    private readonly IUsuarioRepository _usuarioRepository;
    private readonly INotificacionRepository _notificacionRepository;

    public PostulacionService(IPostulacionRepository postulacionRepository, IProyectoRepository proyectoRepository, IUsuarioRepository usuarioRepository, INotificacionRepository notificacionRepository)
    {
        _postulacionRepository = postulacionRepository;
        _proyectoRepository = proyectoRepository;
        _usuarioRepository = usuarioRepository;
        _notificacionRepository = notificacionRepository;
    }

    public async Task<IEnumerable<PostulacionResponseDto>> GetByProyectoIdAsync(int proyectoId)
    {
        var postulaciones = await _postulacionRepository.GetByProyectoIdAsync(proyectoId);
        return postulaciones.Select(p => new PostulacionResponseDto
        {
            Id = p.Id,
            EstudianteId = p.EstudianteId,
            ProyectoId = p.ProyectoId,
            Estado = p.Estado,
            Mensaje = p.Mensaje,
            FechaPostulacion = p.FechaPostulacion
        });
    }

    public async Task<PostulacionResponseDto> CreateAsync(CrearPostulacionDto dto)
    {
        var proyecto = await _proyectoRepository.GetByIdAsync(dto.ProyectoId)
            ?? throw new TalentMatchException("Proyecto no encontrado.", 404);

        if (proyecto.Estado == EstadoProyecto.Cerrado)
            throw new TalentMatchException("Un proyecto cerrado no admite postulaciones.", 409);

        var estudiante = await _usuarioRepository.GetByIdAsync(dto.EstudianteId)
            ?? throw new TalentMatchException("Estudiante no encontrado.", 404);

        if (estudiante.Rol != RolUsuario.Estudiante)
            throw new TalentMatchException("El usuario no es un estudiante.", 400);

        var estudianteRecord = estudiante.Estudiante ?? throw new TalentMatchException("El usuario no tiene perfil de estudiante asociado.", 404);

        var exists = await _postulacionRepository.GetByEstudianteYProyectoAsync(estudianteRecord.Id, dto.ProyectoId);
        if (exists is not null)
            throw new TalentMatchException("El estudiante ya está postulado a este proyecto.", 409);

        if (proyecto.CuposDisponibles <= 0)
            throw new TalentMatchException("El proyecto ya no tiene cupos disponibles.", 409);

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
            UsuarioId = proyecto.Profesor.UsuarioId,
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
            ProyectoId = postulacion.ProyectoId,
            Estado = postulacion.Estado,
            Mensaje = postulacion.Mensaje,
            FechaPostulacion = postulacion.FechaPostulacion
        };
    }

    public async Task<PostulacionResponseDto> AcceptAsync(int postulacionId)
    {
        var postulacion = await _postulacionRepository.GetByIdAsync(postulacionId)
            ?? throw new TalentMatchException("Postulación no encontrada.", 404);

        var proyecto = await _proyectoRepository.GetByIdAsync(postulacion.ProyectoId)
            ?? throw new TalentMatchException("Proyecto no encontrado.", 404);

        var aceptadas = await _postulacionRepository.CountAcceptedByProyectoAsync(postulacion.ProyectoId);
        if (aceptadas >= proyecto.CuposDisponibles)
            throw new TalentMatchException("No se puede aceptar una postulación si no hay cupos.", 409);

        postulacion.Estado = EstadoPostulacion.Aceptada;
        await _postulacionRepository.UpdateAsync(postulacion);

        return new PostulacionResponseDto
        {
            Id = postulacion.Id,
            EstudianteId = postulacion.EstudianteId,
            ProyectoId = postulacion.ProyectoId,
            Estado = postulacion.Estado,
            Mensaje = postulacion.Mensaje,
            FechaPostulacion = postulacion.FechaPostulacion
        };
    }

    public async Task<PostulacionResponseDto> RejectAsync(int postulacionId)
    {
        var postulacion = await _postulacionRepository.GetByIdAsync(postulacionId)
            ?? throw new TalentMatchException("Postulación no encontrada.", 404);

        postulacion.Estado = EstadoPostulacion.Rechazada;
        await _postulacionRepository.UpdateAsync(postulacion);

        return new PostulacionResponseDto
        {
            Id = postulacion.Id,
            EstudianteId = postulacion.EstudianteId,
            ProyectoId = postulacion.ProyectoId,
            Estado = postulacion.Estado,
            Mensaje = postulacion.Mensaje,
            FechaPostulacion = postulacion.FechaPostulacion
        };
    }
}
