using TalentMatch.Api.Domain.Entities;

namespace TalentMatch.Api.Repositories.Interfaces;

public interface IMensajeRepository
{
    Task<IReadOnlyCollection<Conversacion>> GetConversacionesAsync(int usuarioId);
    Task<Conversacion?> GetConversacionAsync(int id, int usuarioId);
    Task<Conversacion?> GetConversacionEntreUsuariosAsync(int usuarioAId, int usuarioBId);
    Task AddConversacionAsync(Conversacion conversacion);
    Task AddMensajeAsync(Mensaje mensaje);
    Task MarcarLeidosAsync(int conversacionId, int usuarioId);
}