using Microsoft.EntityFrameworkCore;
using TalentMatch.Api.Data;
using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Repositories.Interfaces;

namespace TalentMatch.Api.Repositories.Implementations;

public class MensajeRepository : IMensajeRepository
{
    private readonly TalentMatchDbContext _context;
    public MensajeRepository(TalentMatchDbContext context) => _context = context;

    private IQueryable<Conversacion> IncludeGraph() => _context.Conversaciones
        .Include(c => c.UsuarioA).Include(c => c.UsuarioB)
        .Include(c => c.Mensajes).ThenInclude(m => m.Remitente);

    public async Task<IReadOnlyCollection<Conversacion>> GetConversacionesAsync(int usuarioId) =>
        await IncludeGraph().Where(c => c.UsuarioAId == usuarioId || c.UsuarioBId == usuarioId)
            .OrderByDescending(c => c.Mensajes.Max(m => (DateTime?)m.FechaEnvio) ?? c.FechaCreacion).ToListAsync();

    public Task<Conversacion?> GetConversacionAsync(int id, int usuarioId) =>
        IncludeGraph().FirstOrDefaultAsync(c => c.Id == id && (c.UsuarioAId == usuarioId || c.UsuarioBId == usuarioId));

    public Task<Conversacion?> GetConversacionEntreUsuariosAsync(int usuarioAId, int usuarioBId) =>
        IncludeGraph().FirstOrDefaultAsync(c => (c.UsuarioAId == usuarioAId && c.UsuarioBId == usuarioBId) || (c.UsuarioAId == usuarioBId && c.UsuarioBId == usuarioAId));

    public async Task AddConversacionAsync(Conversacion conversacion) { await _context.Conversaciones.AddAsync(conversacion); await _context.SaveChangesAsync(); }
    public async Task AddMensajeAsync(Mensaje mensaje) { await _context.Mensajes.AddAsync(mensaje); await _context.SaveChangesAsync(); }
    public async Task MarcarLeidosAsync(int conversacionId, int usuarioId)
    {
        await _context.Mensajes.Where(m => m.ConversacionId == conversacionId && m.RemitenteId != usuarioId && !m.Leido).ExecuteUpdateAsync(s => s.SetProperty(m => m.Leido, true));
    }
}