using TalentMatch.Api.Domain.Entities;

namespace TalentMatch.Api.Repositories.Interfaces;

public interface INotificacionRepository
{
    Task<IEnumerable<Notificacion>> GetByUsuarioIdAsync(int usuarioId);
    Task<Notificacion?> GetByIdAsync(int id);
    Task AddAsync(Notificacion notificacion);
    Task UpdateAsync(Notificacion notificacion);
}
