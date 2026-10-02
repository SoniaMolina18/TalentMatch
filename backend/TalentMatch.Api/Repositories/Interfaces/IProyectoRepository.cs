using TalentMatch.Api.Domain.Entities;

namespace TalentMatch.Api.Repositories.Interfaces;

public interface IProyectoRepository
{
    Task<IEnumerable<Proyecto>> GetAllAsync();
    Task<Proyecto?> GetByIdAsync(int id);
    Task AddAsync(Proyecto proyecto);
    Task UpdateAsync(Proyecto proyecto);
    Task DeleteAsync(int id);
    Task<IEnumerable<Proyecto>> SearchAsync(string? titulo, string? descripcion);
}
