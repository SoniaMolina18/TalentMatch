using TalentMatch.Api.Domain.Entities;

namespace TalentMatch.Api.Services.Interfaces;

public interface INotificacionService
{
    Task<IEnumerable<Notificacion>> GetByUsuarioIdAsync(int usuarioId, int currentUserId, string currentUserRole);
    Task<Notificacion> MarkAsReadAsync(int id, int currentUserId, string currentUserRole);
}
