using TalentMatch.Api.Domain.Entities;

namespace TalentMatch.Api.Repositories.Interfaces;

public interface IPerfilRepository
{
    Task<Perfil?> GetByUsuarioIdAsync(int usuarioId);
    Task AddAsync(Perfil perfil);
    Task UpdateAsync(Perfil perfil);
}
