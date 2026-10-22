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

    public async Task<IEnumerable<RecomendacionResponseDto>> GetRecomendacionesPorProyectoAsync(int proyectoId, int currentUserId, string currentUserRole)
    {
        var proyecto = await _proyectoRepository.GetByIdAsync(proyectoId)
            ?? throw new TalentMatchException("Proyecto no encontrado.", 404);

        if (proyecto.Tipo == Domain.Enums.TipoProyecto.ColaborativoEstudiante && proyecto.CreadorEstudiante?.UsuarioId != currentUserId)
            throw new TalentMatchException("Solo el creador puede consultar el match de este proyecto.", 403);
        if (proyecto.Tipo == Domain.Enums.TipoProyecto.AcademicoProfesor && currentUserRole != "Administrador" && proyecto.Profesor?.UsuarioId != currentUserId)
            throw new TalentMatchException("No tienes permisos para consultar el match de este proyecto.", 403);

        var miembros = proyecto.Equipos.SelectMany(e => e.Miembros).Select(m => m.EstudianteId).ToHashSet();
        if (proyecto.CreadorEstudianteId is not null) miembros.Add(proyecto.CreadorEstudianteId.Value);
        var estudiantes = await _usuarioRepository.GetAllAsync();
        var estudiantesCompatibles = new List<RecomendacionResponseDto>();

        foreach (var usuario in estudiantes.Where(u => u.Rol == Domain.Enums.RolUsuario.Estudiante && u.Estudiante is not null && !miembros.Contains(u.Estudiante.Id)))
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

            var habilidadesCoincidentes = usuario.Estudiante.EstudianteHabilidades
                .Where(x => proyectoSkills.Contains(x.HabilidadId))
                .Select(x => x.Habilidad.Nombre)
                .Distinct()
                .ToArray();

            var interesesCoincidentes = usuario.Estudiante.EstudianteIntereses
                .Where(x => proyectoIntereses.Contains(x.InteresId))
                .Select(x => x.Interes.Nombre)
                .Distinct()
                .ToArray();

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
                EstudianteId = usuario.Estudiante.Id,
                Nombre = $"{usuario.Nombre} {usuario.Apellido}",
                Carrera = usuario.Estudiante.Carrera,
                Semestre = usuario.Estudiante.Semestre,
                Disponibilidad = usuario.Perfil?.Disponibilidad,
                PorcentajeCompatibilidad = compatibilidadNormalizada,
                HabilidadesCoincidentes = habilidadesCoincidentes,
                InteresesCoincidentes = interesesCoincidentes
            });
        }

        return estudiantesCompatibles
            .OrderByDescending(x => x.PorcentajeCompatibilidad)
            .ToList();
    }
}
