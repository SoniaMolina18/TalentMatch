using TalentMatch.Api.DTOs.Equipos;

namespace TalentMatch.Api.Services.Interfaces;

public interface IEquipoService
{
    Task<EquipoResponseDto?> GetByIdAsync(int id, int currentUserId, string currentUserRole);
    Task<EquipoResponseDto> CreateAsync(CrearEquipoDto dto, int currentUserId, string currentUserRole);
    Task<EquipoResponseDto> AddMiembroAsync(int equipoId, int estudianteId, int currentUserId, string currentUserRole);
    Task<EquipoResponseDto> AssignLeaderAsync(int equipoId, int estudianteId, int currentUserId, string currentUserRole);
    Task<IEnumerable<EquipoResponseDto>> GetByUsuarioAsync(int currentUserId, string currentUserRole);
}
