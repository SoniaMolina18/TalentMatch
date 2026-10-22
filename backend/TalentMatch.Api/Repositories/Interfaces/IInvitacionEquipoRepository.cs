using TalentMatch.Api.Domain.Entities;

namespace TalentMatch.Api.Repositories.Interfaces;

public interface IInvitacionEquipoRepository
{
    Task<InvitacionEquipo?> GetByIdAsync(int id);
    Task<IEnumerable<InvitacionEquipo>> GetReceivedAsync(int usuarioId);
    Task<IEnumerable<InvitacionEquipo>> GetSentAsync(int usuarioId);
    Task<InvitacionEquipo?> GetPendingAsync(int equipoId, int destinatarioUsuarioId);
    Task AddAsync(InvitacionEquipo invitacion);
    Task UpdateAsync(InvitacionEquipo invitacion);
}