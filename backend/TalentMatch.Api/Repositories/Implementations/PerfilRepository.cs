using Microsoft.EntityFrameworkCore;
using TalentMatch.Api.Data;
using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Repositories.Interfaces;

namespace TalentMatch.Api.Repositories.Implementations;

public class PerfilRepository : IPerfilRepository
{
    private readonly TalentMatchDbContext _context;

    public PerfilRepository(TalentMatchDbContext context)
    {
        _context = context;
    }

    public async Task<Perfil?> GetByUsuarioIdAsync(int usuarioId)
    {
        return await _context.Perfiles
            .FirstOrDefaultAsync(p => p.UsuarioId == usuarioId);
    }

    public async Task AddAsync(Perfil perfil)
    {
        await _context.Perfiles.AddAsync(perfil);
        await _context.SaveChangesAsync();
    }

    public async Task UpdateAsync(Perfil perfil)
    {
        _context.Perfiles.Update(perfil);
        await _context.SaveChangesAsync();
    }
}
