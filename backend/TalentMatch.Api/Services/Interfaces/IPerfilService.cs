using TalentMatch.Api.DTOs.Perfiles;

namespace TalentMatch.Api.Services.Interfaces;

public interface IPerfilService
{
    Task<PerfilResponseDto?> GetByUsuarioIdAsync(int usuarioId, int currentUserId, string currentUserRole);
    Task<PerfilResponseDto> UpdateAsync(int usuarioId, ActualizarPerfilDto dto, int currentUserId, string currentUserRole);
}
