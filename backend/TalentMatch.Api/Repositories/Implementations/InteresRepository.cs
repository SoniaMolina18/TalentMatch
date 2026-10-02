using Microsoft.EntityFrameworkCore;
using TalentMatch.Api.Data;
using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Repositories.Interfaces;

namespace TalentMatch.Api.Repositories.Implementations;

public class InteresRepository : IInteresRepository
{
    private readonly TalentMatchDbContext _context;

    public InteresRepository(TalentMatchDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<Interes>> GetAllAsync()
    {
        return await _context.Intereses.AsNoTracking().ToListAsync();
    }

    public async Task<Interes?> GetByIdAsync(int id)
    {
        return await _context.Intereses.FindAsync(id).AsTask();
    }

    public async Task<Interes?> GetByNombreAsync(string nombre)
    {
        return await _context.Intereses
            .FirstOrDefaultAsync(i => i.Nombre.ToLower() == nombre.Trim().ToLower());
    }

    public async Task AddAsync(Interes interes)
    {
        await _context.Intereses.AddAsync(interes);
        await _context.SaveChangesAsync();
    }
}
