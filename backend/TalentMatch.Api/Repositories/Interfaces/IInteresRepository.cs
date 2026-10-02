using TalentMatch.Api.Domain.Entities;

namespace TalentMatch.Api.Repositories.Interfaces;

public interface IInteresRepository
{
    Task<IEnumerable<Interes>> GetAllAsync();
    Task<Interes?> GetByIdAsync(int id);
    Task<Interes?> GetByNombreAsync(string nombre);
    Task AddAsync(Interes interes);
}
