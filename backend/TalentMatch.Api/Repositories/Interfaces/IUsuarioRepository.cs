using TalentMatch.Api.Domain.Entities;

namespace TalentMatch.Api.Repositories.Interfaces;

public interface IUsuarioRepository
{
    Task<IEnumerable<Usuario>> GetAllAsync();
    Task<Usuario?> GetByIdAsync(int id);
    Task<Usuario?> GetByCorreoAsync(string correo);
    Task AddAsync(Usuario usuario);
    Task UpdateAsync(Usuario usuario);
    Task DeleteAsync(int id);
    Task<(IReadOnlyCollection<Usuario> Items, int Total)> SearchStudentsAsync(string? search, string? skill, string? interest, string? availability, int page, int pageSize);
}
