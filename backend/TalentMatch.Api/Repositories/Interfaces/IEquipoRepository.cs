using TalentMatch.Api.Domain.Entities;

namespace TalentMatch.Api.Repositories.Interfaces;

public interface IEquipoRepository
{
    Task<Equipo?> GetByIdAsync(int id);
    Task AddAsync(Equipo equipo);
    Task UpdateAsync(Equipo equipo);
    Task<MiembroEquipo?> GetMiembroAsync(int equipoId, int estudianteId);
    Task AddMiembroAsync(MiembroEquipo miembroEquipo);
    Task<IEnumerable<Equipo>> GetByProyectoIdAsync(int proyectoId);
}
