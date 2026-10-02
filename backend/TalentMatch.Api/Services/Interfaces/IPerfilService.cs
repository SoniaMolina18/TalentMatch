using TalentMatch.Api.DTOs.Perfiles;

namespace TalentMatch.Api.Services.Interfaces;

public interface IPerfilService
{
    Task<PerfilResponseDto?> GetByUsuarioIdAsync(int usuarioId);
    Task<PerfilResponseDto> UpdateAsync(int usuarioId, ActualizarPerfilDto dto, int currentUserId, string currentUserRole);
}
