using Microsoft.EntityFrameworkCore;
using TalentMatch.Api.Data;
using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Enums;
using TalentMatch.Api.Repositories.Interfaces;

namespace TalentMatch.Api.Repositories.Implementations;

public class InvitacionEquipoRepository : IInvitacionEquipoRepository
{
    private readonly TalentMatchDbContext _context;

    public InvitacionEquipoRepository(TalentMatchDbContext context)
    {
        _context = context;
    }

    public async Task<InvitacionEquipo?> GetByIdAsync(int id)
    {
        return await Query()
            .FirstOrDefaultAsync(i => i.Id == id);
    }

    public async Task<IEnumerable<InvitacionEquipo>> GetReceivedAsync(int usuarioId)
    {
        return await Query()
            .Where(i => i.DestinatarioUsuarioId == usuarioId)
            .OrderByDescending(i => i.FechaCreacion)
            .ToListAsync();
    }

    public async Task<IEnumerable<InvitacionEquipo>> GetSentAsync(int usuarioId)
    {
        return await Query()
            .Where(i => i.RemitenteUsuarioId == usuarioId)
            .OrderByDescending(i => i.FechaCreacion)
            .ToListAsync();
    }

    public async Task<InvitacionEquipo?> GetPendingAsync(int equipoId, int destinatarioUsuarioId)
    {
        return await Query()
            .FirstOrDefaultAsync(i => i.EquipoId == equipoId
                && i.DestinatarioUsuarioId == destinatarioUsuarioId
                && i.Estado == EstadoInvitacionEquipo.Pendiente);
    }

    public async Task AddAsync(InvitacionEquipo invitacion)
    {
        await _context.InvitacionesEquipo.AddAsync(invitacion);
        await _context.SaveChangesAsync();
    }

    public async Task UpdateAsync(InvitacionEquipo invitacion)
    {
        _context.InvitacionesEquipo.Update(invitacion);
        await _context.SaveChangesAsync();
    }

    private IQueryable<InvitacionEquipo> Query()
    {
        return _context.InvitacionesEquipo
            .Include(i => i.Equipo)
                .ThenInclude(e => e.Proyecto)
            .Include(i => i.Equipo)
                .ThenInclude(e => e.LiderEstudiante)
            .Include(i => i.Equipo)
                .ThenInclude(e => e.Miembros)
            .Include(i => i.RemitenteUsuario)
                .ThenInclude(u => u.Estudiante)
            .Include(i => i.DestinatarioUsuario)
                .ThenInclude(u => u.Estudiante);
    }
}
