using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Enums;

namespace TalentMatch.Api.Repositories.Interfaces;

public interface IPostulacionRepository
{
    Task<IEnumerable<Postulacion>> GetByProyectoIdAsync(int proyectoId);
    Task<Postulacion?> GetByIdAsync(int id);
    Task<Postulacion?> GetByEstudianteYProyectoAsync(int estudianteId, int proyectoId);
    Task AddAsync(Postulacion postulacion);
    Task UpdateAsync(Postulacion postulacion);
    Task<IEnumerable<Postulacion>> GetByEstudianteIdAsync(int estudianteId);
    Task<int> CountAcceptedByProyectoAsync(int proyectoId);
    Task<bool> AnyAsync(int proyectoId, int estudianteId);
    Task<bool> ExistsAsync(int postulacionId);
    Task<IEnumerable<Postulacion>> GetAllAsync();
}
