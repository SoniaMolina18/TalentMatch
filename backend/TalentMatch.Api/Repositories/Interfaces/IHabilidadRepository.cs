using TalentMatch.Api.Domain.Entities;

namespace TalentMatch.Api.Repositories.Interfaces;

public interface IHabilidadRepository
{
    Task<IEnumerable<Habilidad>> GetAllAsync();
    Task<Habilidad?> GetByIdAsync(int id);
    Task<Habilidad?> GetByNombreAsync(string nombre);
    Task AddAsync(Habilidad habilidad);
}
