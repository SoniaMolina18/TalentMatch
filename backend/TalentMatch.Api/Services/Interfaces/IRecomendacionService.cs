using TalentMatch.Api.DTOs.Recomendaciones;

namespace TalentMatch.Api.Services.Interfaces;

public interface IRecomendacionService
{
    Task<IEnumerable<RecomendacionResponseDto>> GetRecomendacionesPorProyectoAsync(int proyectoId);
}
