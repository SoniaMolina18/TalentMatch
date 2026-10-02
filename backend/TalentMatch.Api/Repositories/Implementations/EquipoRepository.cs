using Microsoft.EntityFrameworkCore;
using TalentMatch.Api.Data;
using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Repositories.Interfaces;

namespace TalentMatch.Api.Repositories.Implementations;

public class EquipoRepository : IEquipoRepository
{
    private readonly TalentMatchDbContext _context;

    public EquipoRepository(TalentMatchDbContext context)
    {
        _context = context;
    }

    public async Task<Equipo?> GetByIdAsync(int id)
    {
        return await _context.Equipos
            .Include(e => e.Miembros)
            .ThenInclude(m => m.Estudiante)
            .ThenInclude(est => est.Usuario)
            .FirstOrDefaultAsync(e => e.Id == id);
    }

    public async Task AddAsync(Equipo equipo)
    {
        await _context.Equipos.AddAsync(equipo);
        await _context.SaveChangesAsync();
    }

    public async Task UpdateAsync(Equipo equipo)
    {
        _context.Equipos.Update(equipo);
        await _context.SaveChangesAsync();
    }

    public async Task<MiembroEquipo?> GetMiembroAsync(int equipoId, int estudianteId)
    {
        return await _context.MiembrosEquipo
            .FirstOrDefaultAsync(me => me.EquipoId == equipoId && me.EstudianteId == estudianteId);
    }

    public async Task AddMiembroAsync(MiembroEquipo miembroEquipo)
    {
        await _context.MiembrosEquipo.AddAsync(miembroEquipo);
        await _context.SaveChangesAsync();
    }

    public async Task<IEnumerable<Equipo>> GetByProyectoIdAsync(int proyectoId)
    {
        return await _context.Equipos
            .Where(e => e.ProyectoId == proyectoId)
            .AsNoTracking()
            .ToListAsync();
    }
}
