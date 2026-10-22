using TalentMatch.Api.DTOs.Proyectos;

namespace TalentMatch.Api.Services.Interfaces;

public interface IProyectoService
{
    Task<IEnumerable<ProyectoResponseDto>> GetAllAsync();
    Task<ProyectoResponseDto?> GetByIdAsync(int id);
    Task<ProyectoResponseDto> CreateAsync(CrearProyectoDto dto, int currentUserId, string currentUserRole);
    Task<ProyectoResponseDto> UpdateAsync(int id, ActualizarProyectoDto dto, int currentUserId, string currentUserRole);
    Task DeleteAsync(int id, int currentUserId, string currentUserRole);
    Task<IEnumerable<ProyectoResponseDto>> SearchAsync(string? titulo, string? descripcion);
    Task<ProyectoColaborativoResponseDto> CreateCollaborativeAsync(CrearProyectoColaborativoDto dto, int currentUserId, string currentUserRole);
    Task<IEnumerable<ProyectoColaborativoResponseDto>> GetMyCollaborativeAsync(int currentUserId, string currentUserRole);
}
