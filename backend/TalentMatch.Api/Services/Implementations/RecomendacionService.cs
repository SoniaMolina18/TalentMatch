using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Exceptions;
using TalentMatch.Api.DTOs.Recomendaciones;
using TalentMatch.Api.Repositories.Interfaces;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Services.Implementations;

public class RecomendacionService : IRecomendacionService
{
    private readonly IProyectoRepository _proyectoRepository;
    private readonly IUsuarioRepository _usuarioRepository;
    private readonly IRecomendacionRepository _recomendacionRepository;

    public RecomendacionService(IProyectoRepository proyectoRepository, IUsuarioRepository usuarioRepository, IRecomendacionRepository recomendacionRepository)
    {
        _proyectoRepository = proyectoRepository;
        _usuarioRepository = usuarioRepository;
        _recomendacionRepository = recomendacionRepository;
    }

    public async Task<IEnumerable<RecomendacionResponseDto>> GetRecomendacionesPorProyectoAsync(int proyectoId)
    {
        var proyecto = await _proyectoRepository.GetByIdAsync(proyectoId)
            ?? throw new TalentMatchException("Proyecto no encontrado.", 404);

        var estudiantes = await _usuarioRepository.GetAllAsync();
        var estudiantesCompatibles = new List<RecomendacionResponseDto>();

        foreach (var usuario in estudiantes.Where(u => u.Rol == Domain.Enums.RolUsuario.Estudiante))
        {
            if (usuario.Estudiante is null)
                continue;

            var estudianteSkills = usuario.Estudiante.EstudianteHabilidades
                .Select(x => x.HabilidadId)
                .ToHashSet();

            var proyectoSkills = proyecto.ProyectoHabilidades
                .Select(x => x.HabilidadId)
                .ToHashSet();

            var estudianteIntereses = usuario.Estudiante.EstudianteIntereses
                .Select(x => x.InteresId)
                .ToHashSet();

            var proyectoIntereses = proyecto.ProyectoIntereses
                .Select(x => x.InteresId)
                .ToHashSet();

            var porcentajeHabilidades = proyectoSkills.Count == 0
                ? 0m
                : estudianteSkills.Intersect(proyectoSkills).Count() * 100m / proyectoSkills.Count;

            var porcentajeIntereses = proyectoIntereses.Count == 0
                ? 0m
                : estudianteIntereses.Intersect(proyectoIntereses).Count() * 100m / proyectoIntereses.Count;

            var compatibilidad = (porcentajeHabilidades * 0.70m) + (porcentajeIntereses * 0.30m);
            var compatibilidadNormalizada = Math.Clamp(compatibilidad, 0m, 100m);

            estudiantesCompatibles.Add(new RecomendacionResponseDto
            {
                EstudianteId = usuario.Id,
                Nombre = $"{usuario.Nombre} {usuario.Apellido}",
                PorcentajeCompatibilidad = compatibilidadNormalizada
            });
        }

        return estudiantesCompatibles
            .OrderByDescending(x => x.PorcentajeCompatibilidad)
            .ToList();
    }
}
