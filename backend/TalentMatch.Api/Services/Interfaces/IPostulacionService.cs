using TalentMatch.Api.DTOs.Postulaciones;

namespace TalentMatch.Api.Services.Interfaces;

public interface IPostulacionService
{
    Task<IEnumerable<PostulacionResponseDto>> GetByProyectoIdAsync(int proyectoId);
    Task<PostulacionResponseDto> CreateAsync(CrearPostulacionDto dto);
    Task<PostulacionResponseDto> AcceptAsync(int postulacionId);
    Task<PostulacionResponseDto> RejectAsync(int postulacionId);
}
