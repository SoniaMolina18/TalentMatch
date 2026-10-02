using TalentMatch.Api.Domain.Entities;

namespace TalentMatch.Api.Repositories.Interfaces;

public interface IRecomendacionRepository
{
    Task<IEnumerable<Recomendacion>> GetByProyectoIdAsync(int proyectoId);
    Task AddAsync(Recomendacion recomendacion);
    Task SaveRangeAsync(IEnumerable<Recomendacion> recomendaciones);
}
