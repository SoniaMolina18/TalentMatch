using Microsoft.EntityFrameworkCore;
using TalentMatch.Api.Data;
using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Repositories.Interfaces;

namespace TalentMatch.Api.Repositories.Implementations;

public class HabilidadRepository : IHabilidadRepository
{
    private readonly TalentMatchDbContext _context;

    public HabilidadRepository(TalentMatchDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<Habilidad>> GetAllAsync()
    {
        return await _context.Habilidades.AsNoTracking().ToListAsync();
    }

    public async Task<Habilidad?> GetByIdAsync(int id)
    {
        return await _context.Habilidades.FindAsync(id).AsTask();
    }

    public async Task<Habilidad?> GetByNombreAsync(string nombre)
    {
        return await _context.Habilidades
            .FirstOrDefaultAsync(h => h.Nombre.ToLower() == nombre.Trim().ToLower());
    }

    public async Task AddAsync(Habilidad habilidad)
    {
        await _context.Habilidades.AddAsync(habilidad);
        await _context.SaveChangesAsync();
    }
}
