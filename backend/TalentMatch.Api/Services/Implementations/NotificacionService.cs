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

    public async Task<IEnumerable<Notificacion>> GetByUsuarioIdAsync(int usuarioId, int currentUserId, string currentUserRole)
    {
        EnsureAccess(usuarioId, currentUserId, currentUserRole);
        return await _notificacionRepository.GetByUsuarioIdAsync(usuarioId);
    }

    public async Task<Notificacion> MarkAsReadAsync(int id, int currentUserId, string currentUserRole)
    {
        var notificacion = await _notificacionRepository.GetByIdAsync(id)
            ?? throw new TalentMatchException("Notificación no encontrada.", 404);

        EnsureAccess(notificacion.UsuarioId, currentUserId, currentUserRole);

        notificacion.Leida = true;
        await _notificacionRepository.UpdateAsync(notificacion);
        return notificacion;
    }

    private static void EnsureAccess(int usuarioId, int currentUserId, string currentUserRole)
    {
        if (usuarioId != currentUserId && currentUserRole != "Administrador")
            throw new TalentMatchException("No tienes permisos sobre estas notificaciones.", 403);
    }
}
