using Microsoft.EntityFrameworkCore;
using TalentMatch.Api.Data;
using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Repositories.Interfaces;

namespace TalentMatch.Api.Repositories.Implementations;

public class ProyectoRepository : IProyectoRepository
{
    private readonly TalentMatchDbContext _context;

    public ProyectoRepository(TalentMatchDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<Proyecto>> GetAllAsync()
    {
        return await _context.Proyectos
            .AsNoTracking()
            .Include(p => p.Profesor)
            .OrderByDescending(p => p.FechaCreacion)
            .ToListAsync();
    }

    public async Task<Proyecto?> GetByIdAsync(int id)
    {
        return await _context.Proyectos
            .Include(p => p.Profesor)
            .Include(p => p.ProyectoHabilidades)
            .ThenInclude(ph => ph.Habilidad)
            .Include(p => p.ProyectoIntereses)
            .ThenInclude(pi => pi.Interes)
            .FirstOrDefaultAsync(p => p.Id == id);
    }

    public async Task AddAsync(Proyecto proyecto)
    {
        await _context.Proyectos.AddAsync(proyecto);
        await _context.SaveChangesAsync();
    }

    public async Task UpdateAsync(Proyecto proyecto)
    {
        _context.Proyectos.Update(proyecto);
        await _context.SaveChangesAsync();
    }

    public async Task DeleteAsync(int id)
    {
        var proyecto = await _context.Proyectos.FindAsync(id);
        if (proyecto is not null)
        {
            _context.Proyectos.Remove(proyecto);
            await _context.SaveChangesAsync();
        }
    }

    public async Task<IEnumerable<Proyecto>> SearchAsync(string? titulo, string? descripcion)
    {
        var query = _context.Proyectos.AsQueryable();

        if (!string.IsNullOrWhiteSpace(titulo))
            query = query.Where(p => p.Titulo.Contains(titulo));

        if (!string.IsNullOrWhiteSpace(descripcion))
            query = query.Where(p => p.Descripcion.Contains(descripcion));

        return await query.AsNoTracking().ToListAsync();
    }
}
