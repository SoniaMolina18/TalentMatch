using TalentMatch.Api.DTOs.Mensajes;

namespace TalentMatch.Api.Services.Interfaces;

public interface IMensajeService
{
    Task<IReadOnlyCollection<ConversacionDto>> GetConversacionesAsync(int usuarioId);
    Task<ConversacionDto> CreateConversacionAsync(int usuarioId, int otroUsuarioId);
    Task<MensajeDto> AddMensajeAsync(int conversacionId, string contenido, int usuarioId);
    Task MarkReadAsync(int conversacionId, int usuarioId);
}