using Microsoft.EntityFrameworkCore;
using TalentMatch.Api.Data;
using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Repositories.Interfaces;

namespace TalentMatch.Api.Repositories.Implementations;

public class UsuarioRepository : IUsuarioRepository
{
    private readonly TalentMatchDbContext _context;

    public UsuarioRepository(TalentMatchDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<Usuario>> GetAllAsync()
    {
        return await _context.Usuarios
            .AsNoTracking()
            .Include(u => u.Perfil)
            .Include(u => u.Estudiante)
            .ThenInclude(e => e!.EstudianteHabilidades)
            .ThenInclude(eh => eh.Habilidad)
            .Include(u => u.Estudiante)
            .ThenInclude(e => e!.EstudianteIntereses)
            .ThenInclude(ei => ei.Interes)
            .Include(u => u.Profesor)
            .OrderBy(u => u.Id)
            .ToListAsync();
    }

    public async Task<Usuario?> GetByIdAsync(int id)
    {
        return await _context.Usuarios
            .Include(u => u.Perfil)
            .Include(u => u.Estudiante)
            .Include(u => u.Profesor)
            .FirstOrDefaultAsync(u => u.Id == id);
    }

    public async Task<Usuario?> GetByCorreoAsync(string correo)
    {
        return await _context.Usuarios
            .FirstOrDefaultAsync(u => u.Correo == correo);
    }

    public async Task AddAsync(Usuario usuario)
    {
        await _context.Usuarios.AddAsync(usuario);
        await _context.SaveChangesAsync();
    }

    public async Task UpdateAsync(Usuario usuario)
    {
        _context.Usuarios.Update(usuario);
        await _context.SaveChangesAsync();
    }

    public async Task DeleteAsync(int id)
    {
        var usuario = await _context.Usuarios.FindAsync(id);
        if (usuario is not null)
        {
            _context.Usuarios.Remove(usuario);
            await _context.SaveChangesAsync();
        }
    }

    public async Task<(IReadOnlyCollection<Usuario> Items, int Total)> SearchStudentsAsync(string? search, string? skill, string? interest, string? availability, int page, int pageSize)
    {
        IQueryable<Usuario> query = _context.Usuarios.AsNoTracking().Where(u => u.Activo && u.Estudiante != null)
            .Include(u => u.Perfil)
            .Include(u => u.Estudiante!).ThenInclude(e => e.EstudianteHabilidades).ThenInclude(eh => eh.Habilidad)
            .Include(u => u.Estudiante!).ThenInclude(e => e.EstudianteIntereses).ThenInclude(ei => ei.Interes);

        if (!string.IsNullOrWhiteSpace(search))
        {
            var value = search.Trim();
            query = query.Where(u => u.Nombre.Contains(value) || u.Apellido.Contains(value) || u.Estudiante!.Carrera.Contains(value));
        }
        if (!string.IsNullOrWhiteSpace(skill))
            query = query.Where(u => u.Estudiante!.EstudianteHabilidades.Any(eh => eh.Habilidad.Nombre.Contains(skill.Trim())));
        if (!string.IsNullOrWhiteSpace(interest))
            query = query.Where(u => u.Estudiante!.EstudianteIntereses.Any(ei => ei.Interes.Nombre.Contains(interest.Trim())));
        if (!string.IsNullOrWhiteSpace(availability))
            query = query.Where(u => u.Perfil != null && u.Perfil.Disponibilidad != null && u.Perfil.Disponibilidad.Contains(availability.Trim()));

        var total = await query.CountAsync();
        var items = await query.OrderBy(u => u.Apellido).ThenBy(u => u.Nombre).Skip((page - 1) * pageSize).Take(pageSize).ToListAsync();
        return (items, total);
    }
}
