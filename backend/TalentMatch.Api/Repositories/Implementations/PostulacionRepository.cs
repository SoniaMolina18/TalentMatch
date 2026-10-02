using Microsoft.EntityFrameworkCore;
using TalentMatch.Api.Data;
using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Enums;
using TalentMatch.Api.Repositories.Interfaces;

namespace TalentMatch.Api.Repositories.Implementations;

public class PostulacionRepository : IPostulacionRepository
{
    private readonly TalentMatchDbContext _context;

    public PostulacionRepository(TalentMatchDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<Postulacion>> GetByProyectoIdAsync(int proyectoId)
    {
        return await _context.Postulaciones
            .Where(p => p.ProyectoId == proyectoId)
            .Include(p => p.Estudiante)
            .ThenInclude(e => e.Usuario)
            .OrderByDescending(p => p.FechaPostulacion)
            .ToListAsync();
    }

    public async Task<Postulacion?> GetByIdAsync(int id)
    {
        return await _context.Postulaciones
            .Include(p => p.Estudiante)
            .ThenInclude(e => e.Usuario)
            .Include(p => p.Proyecto)
            .FirstOrDefaultAsync(p => p.Id == id);
    }

    public async Task<Postulacion?> GetByEstudianteYProyectoAsync(int estudianteId, int proyectoId)
    {
        return await _context.Postulaciones
            .FirstOrDefaultAsync(p => p.EstudianteId == estudianteId && p.ProyectoId == proyectoId);
    }

    public async Task AddAsync(Postulacion postulacion)
    {
        await _context.Postulaciones.AddAsync(postulacion);
        await _context.SaveChangesAsync();
    }

    public async Task UpdateAsync(Postulacion postulacion)
    {
        _context.Postulaciones.Update(postulacion);
        await _context.SaveChangesAsync();
    }

    public async Task<IEnumerable<Postulacion>> GetByEstudianteIdAsync(int estudianteId)
    {
        return await _context.Postulaciones
            .Where(p => p.EstudianteId == estudianteId)
            .ToListAsync();
    }

    public async Task<int> CountAcceptedByProyectoAsync(int proyectoId)
    {
        return await _context.Postulaciones
            .CountAsync(p => p.ProyectoId == proyectoId && p.Estado == EstadoPostulacion.Aceptada);
    }

    public async Task<bool> AnyAsync(int proyectoId, int estudianteId)
    {
        return await _context.Postulaciones
            .AnyAsync(p => p.ProyectoId == proyectoId && p.EstudianteId == estudianteId);
    }

    public async Task<bool> ExistsAsync(int postulacionId)
    {
        return await _context.Postulaciones.AnyAsync(p => p.Id == postulacionId);
    }

    public async Task<IEnumerable<Postulacion>> GetAllAsync()
    {
        return await _context.Postulaciones.AsNoTracking().ToListAsync();
    }
}
