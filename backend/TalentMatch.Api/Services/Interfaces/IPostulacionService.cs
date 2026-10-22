using TalentMatch.Api.DTOs.Postulaciones;

namespace TalentMatch.Api.Services.Interfaces;

public interface IPostulacionService
{
    Task<IEnumerable<PostulacionResponseDto>> GetByProyectoIdAsync(int proyectoId, int currentUserId, string currentUserRole);
    Task<IEnumerable<PostulacionResponseDto>> GetMineAsync(int currentUserId, string currentUserRole);
    Task<PostulacionResponseDto> CreateAsync(CrearPostulacionDto dto, int currentUserId, string currentUserRole);
    Task<PostulacionResponseDto> AcceptAsync(int postulacionId, int currentUserId, string currentUserRole);
    Task<PostulacionResponseDto> RejectAsync(int postulacionId, int currentUserId, string currentUserRole);
}
