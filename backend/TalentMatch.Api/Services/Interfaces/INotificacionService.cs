using TalentMatch.Api.Domain.Entities;

namespace TalentMatch.Api.Services.Interfaces;

public interface INotificacionService
{
    Task<IEnumerable<Notificacion>> GetByUsuarioIdAsync(int usuarioId);
    Task<Notificacion> MarkAsReadAsync(int id);
}
