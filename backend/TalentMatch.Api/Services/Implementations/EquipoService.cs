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

    public async Task<EquipoResponseDto?> GetByIdAsync(int id)
    {
        var equipo = await _equipoRepository.GetByIdAsync(id);
        if (equipo is null) return null;

        return new EquipoResponseDto
        {
            Id = equipo.Id,
            Nombre = equipo.Nombre,
            ProyectoId = equipo.ProyectoId,
            Estado = equipo.Estado,
            FechaCreacion = equipo.FechaCreacion
        };
    }

    public async Task<EquipoResponseDto> CreateAsync(CrearEquipoDto dto)
    {
        var proyecto = await _proyectoRepository.GetByIdAsync(dto.ProyectoId)
            ?? throw new TalentMatchException("Proyecto no encontrado.", 404);

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
            Estado = equipo.Estado,
            FechaCreacion = equipo.FechaCreacion
        };
    }

    public async Task<EquipoResponseDto> AddMiembroAsync(int equipoId, int estudianteId)
    {
        var equipo = await _equipoRepository.GetByIdAsync(equipoId)
            ?? throw new TalentMatchException("Equipo no encontrado.", 404);

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
            Estado = equipo.Estado,
            FechaCreacion = equipo.FechaCreacion
        };
    }
}
