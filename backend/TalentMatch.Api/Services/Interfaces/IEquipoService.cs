using TalentMatch.Api.DTOs.Equipos;

namespace TalentMatch.Api.Services.Interfaces;

public interface IEquipoService
{
    Task<EquipoResponseDto?> GetByIdAsync(int id);
    Task<EquipoResponseDto> CreateAsync(CrearEquipoDto dto);
    Task<EquipoResponseDto> AddMiembroAsync(int equipoId, int estudianteId);
}
