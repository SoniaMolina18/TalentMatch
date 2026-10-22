using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Exceptions;
using TalentMatch.Api.DTOs.Mensajes;
using TalentMatch.Api.Repositories.Interfaces;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Services.Implementations;

public class MensajeService : IMensajeService
{
    private readonly IMensajeRepository _repository;
    private readonly IUsuarioRepository _usuarios;
    public MensajeService(IMensajeRepository repository, IUsuarioRepository usuarios) { _repository = repository; _usuarios = usuarios; }

    public async Task<IReadOnlyCollection<ConversacionDto>> GetConversacionesAsync(int usuarioId) =>
        (await _repository.GetConversacionesAsync(usuarioId)).Select(c => MapConversation(c, usuarioId)).ToArray();

    public async Task<ConversacionDto> CreateConversacionAsync(int usuarioId, int otroUsuarioId)
    {
        if (usuarioId == otroUsuarioId) throw new TalentMatchException("No puedes crear una conversación contigo mismo.", 400);
        if (await _usuarios.GetByIdAsync(otroUsuarioId) is null) throw new TalentMatchException("Usuario destinatario no encontrado.", 404);
        var existing = await _repository.GetConversacionEntreUsuariosAsync(usuarioId, otroUsuarioId);
        if (existing is not null) return MapConversation(existing, usuarioId);
        var conversation = usuarioId < otroUsuarioId
            ? new Conversacion { UsuarioAId = usuarioId, UsuarioBId = otroUsuarioId }
            : new Conversacion { UsuarioAId = otroUsuarioId, UsuarioBId = usuarioId };
        await _repository.AddConversacionAsync(conversation);
        var stored = await _repository.GetConversacionAsync(conversation.Id, usuarioId) ?? conversation;
        return MapConversation(stored, usuarioId);
    }

    public async Task<MensajeDto> AddMensajeAsync(int conversacionId, string contenido, int usuarioId)
    {
        if (string.IsNullOrWhiteSpace(contenido) || contenido.Trim().Length > 2000) throw new TalentMatchException("El mensaje es obligatorio y no puede superar 2000 caracteres.", 400);
        var conversation = await _repository.GetConversacionAsync(conversacionId, usuarioId) ?? throw new TalentMatchException("Conversación no encontrada.", 404);
        var message = new Mensaje { ConversacionId = conversation.Id, RemitenteId = usuarioId, Contenido = contenido.Trim() };
        await _repository.AddMensajeAsync(message);
        var sender = await _usuarios.GetByIdAsync(usuarioId);
        return new MensajeDto { Id = message.Id, RemitenteId = usuarioId, RemitenteNombre = sender is null ? string.Empty : $"{sender.Nombre} {sender.Apellido}".Trim(), Contenido = message.Contenido, FechaEnvio = message.FechaEnvio, Leido = message.Leido };
    }

    public async Task MarkReadAsync(int conversacionId, int usuarioId)
    {
        if (await _repository.GetConversacionAsync(conversacionId, usuarioId) is null) throw new TalentMatchException("Conversación no encontrada.", 404);
        await _repository.MarcarLeidosAsync(conversacionId, usuarioId);
    }

    private static ConversacionDto MapConversation(Conversacion c, int userId)
    {
        var other = c.UsuarioAId == userId ? c.UsuarioB : c.UsuarioA;
        return new ConversacionDto { Id = c.Id, OtroUsuarioId = other.Id, OtroNombre = other.Nombre, OtroApellido = other.Apellido, FechaCreacion = c.FechaCreacion, Mensajes = c.Mensajes.OrderBy(m => m.FechaEnvio).Select(m => new MensajeDto { Id = m.Id, RemitenteId = m.RemitenteId, RemitenteNombre = m.Remitente.Nombre, Contenido = m.Contenido, FechaEnvio = m.FechaEnvio, Leido = m.Leido }).ToArray() };
    }
}