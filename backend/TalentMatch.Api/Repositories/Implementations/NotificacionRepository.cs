using Microsoft.EntityFrameworkCore;
using TalentMatch.Api.Data;
using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Repositories.Interfaces;

namespace TalentMatch.Api.Repositories.Implementations;

public class NotificacionRepository : INotificacionRepository
{
    private readonly TalentMatchDbContext _context;

    public NotificacionRepository(TalentMatchDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<Notificacion>> GetByUsuarioIdAsync(int usuarioId)
    {
        return await _context.Notificaciones
            .Where(n => n.UsuarioId == usuarioId)
            .OrderByDescending(n => n.FechaCreacion)
            .ToListAsync();
    }

    public async Task<Notificacion?> GetByIdAsync(int id)
    {
        return await _context.Notificaciones.FirstOrDefaultAsync(n => n.Id == id);
    }

    public async Task AddAsync(Notificacion notificacion)
    {
        await _context.Notificaciones.AddAsync(notificacion);
        await _context.SaveChangesAsync();
    }

    public async Task UpdateAsync(Notificacion notificacion)
    {
        _context.Notificaciones.Update(notificacion);
        await _context.SaveChangesAsync();
    }
}
