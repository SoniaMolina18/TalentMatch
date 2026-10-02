using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Exceptions;
using TalentMatch.Api.Repositories.Interfaces;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Services.Implementations;

public class NotificacionService : INotificacionService
{
    private readonly INotificacionRepository _notificacionRepository;

    public NotificacionService(INotificacionRepository notificacionRepository)
    {
        _notificacionRepository = notificacionRepository;
    }

    public async Task<IEnumerable<Notificacion>> GetByUsuarioIdAsync(int usuarioId)
    {
        return await _notificacionRepository.GetByUsuarioIdAsync(usuarioId);
    }

    public async Task<Notificacion> MarkAsReadAsync(int id)
    {
        var notificacion = await _notificacionRepository.GetByIdAsync(id)
            ?? throw new TalentMatchException("Notificación no encontrada.", 404);

        notificacion.Leida = true;
        await _notificacionRepository.UpdateAsync(notificacion);
        return notificacion;
    }
}
