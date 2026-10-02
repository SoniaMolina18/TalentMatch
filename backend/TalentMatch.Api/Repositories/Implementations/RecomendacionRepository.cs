using Microsoft.EntityFrameworkCore;
using TalentMatch.Api.Data;
using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Repositories.Interfaces;

namespace TalentMatch.Api.Repositories.Implementations;

public class RecomendacionRepository : IRecomendacionRepository
{
    private readonly TalentMatchDbContext _context;

    public RecomendacionRepository(TalentMatchDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<Recomendacion>> GetByProyectoIdAsync(int proyectoId)
    {
        return await _context.Recomendaciones
            .Where(r => r.ProyectoId == proyectoId)
            .OrderByDescending(r => r.PorcentajeCompatibilidad)
            .ToListAsync();
    }

    public async Task AddAsync(Recomendacion recomendacion)
    {
        await _context.Recomendaciones.AddAsync(recomendacion);
        await _context.SaveChangesAsync();
    }

    public async Task SaveRangeAsync(IEnumerable<Recomendacion> recomendaciones)
    {
        await _context.Recomendaciones.AddRangeAsync(recomendaciones);
        await _context.SaveChangesAsync();
    }
}
