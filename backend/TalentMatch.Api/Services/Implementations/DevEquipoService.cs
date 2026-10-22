using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using System.Threading.Tasks;
using TalentMatch.Api.DTOs.Equipos;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Services.Implementations;

// Servicio de ejemplo para Development que devuelve datos ficticios sin usar DB.
public class DevEquipoService : IEquipoService
{
    private readonly IWebHostEnvironment _env;

    public DevEquipoService(IWebHostEnvironment env)
    {
        _env = env;
    }

    public Task<EquipoResponseDto?> GetByIdAsync(int id, int currentUserId, string currentUserRole)
    {
        if (!_env.IsDevelopment())
            return Task.FromResult<EquipoResponseDto?>(null);

        var ejemplo = new EquipoResponseDto
        {
            Id = id,
            Nombre = "Equipo de Desarrollo",
            ProyectoId = 0,
            Estado = TalentMatch.Api.Domain.Enums.EstadoEquipo.Activo,
            FechaCreacion = DateTime.UtcNow
        };

        return Task.FromResult<EquipoResponseDto?>(ejemplo);
    }

    public Task<IEnumerable<EquipoResponseDto>> GetByUsuarioAsync(int currentUserId, string currentUserRole)
    {
        if (!_env.IsDevelopment())
            return Task.FromResult<IEnumerable<EquipoResponseDto>>(Array.Empty<EquipoResponseDto>());

        return Task.FromResult<IEnumerable<EquipoResponseDto>>(new[]
        {
            new EquipoResponseDto
            {
                Id = currentUserId > 0 ? currentUserId : 1,
                Nombre = "Equipo de Desarrollo",
                ProyectoId = 0,
                Estado = TalentMatch.Api.Domain.Enums.EstadoEquipo.Activo,
                FechaCreacion = DateTime.UtcNow
            }
        });
    }

    public Task<EquipoResponseDto> CreateAsync(CrearEquipoDto dto, int currentUserId, string currentUserRole) =>
        throw new NotSupportedException("Solo disponible en Production");

    public Task<EquipoResponseDto> AddMiembroAsync(int equipoId, int estudianteId, int currentUserId, string currentUserRole) =>
        throw new NotSupportedException("Solo disponible en Production");

    public Task<EquipoResponseDto> AssignLeaderAsync(int equipoId, int estudianteId, int currentUserId, string currentUserRole) =>
        throw new NotSupportedException("Solo disponible en Production");
}
