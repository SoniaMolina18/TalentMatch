using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using System.Threading.Tasks;
using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Enums;
using TalentMatch.Api.Services.Interfaces;
using TalentMatch.Api.DTOs.Usuarios;

namespace TalentMatch.Api.Services.Implementations;

// Servicio de autenticación exclusivo para Development. No toca la DB.
public class DevUsuarioService : IUsuarioService
{
    private readonly IConfiguration _configuration;
    private readonly IWebHostEnvironment _env;

    public DevUsuarioService(IConfiguration configuration, IWebHostEnvironment env)
    {
        _configuration = configuration;
        _env = env;
    }

    public Task<IEnumerable<UsuarioResponseDto>> GetAllAsync() =>
        throw new NotSupportedException("Solo disponible en Production");

    public Task<UsuarioResponseDto?> GetByIdAsync(int id) =>
        throw new NotSupportedException("Solo disponible en Production");

    public Task<UsuarioResponseDto> CreateAsync(CrearUsuarioDto dto) =>
        throw new NotSupportedException("Solo disponible en Production");

    public Task<UsuarioResponseDto> CreateAdministrativeAsync(CrearUsuarioAdministrativoDto dto) =>
        throw new NotSupportedException("Solo disponible en Production");

    public Task<UsuarioResponseDto> AssignProfessorAsync(int usuarioId) =>
        throw new NotSupportedException("Solo disponible en Production");

    public Task<UsuarioResponseDto> UpdateAsync(int id, ActualizarUsuarioDto dto, int currentUserId, string currentUserRole) =>
        throw new NotSupportedException("Solo disponible en Production");

    // Autenticación en Development: compara con user-secrets / ENV y devuelve un Usuario en memoria.
    public Task<Usuario?> AuthenticateAsync(string correo, string password)
    {
        if (!_env.IsDevelopment())
            return Task.FromResult<Usuario?>(null);

        var devEmail = _configuration["DevAuth:Email"];
        var devPassword = _configuration["DevAuth:Password"];
        var devName = _configuration["DevAuth:Name"] ?? "Dev";
        var devRole = _configuration["DevAuth:Role"] ?? "Administrador";

        if (string.IsNullOrWhiteSpace(devEmail) || string.IsNullOrWhiteSpace(devPassword))
            return Task.FromResult<Usuario?>(null);

        if (string.Equals(correo?.Trim(), devEmail, StringComparison.OrdinalIgnoreCase) && password == devPassword)
        {
            var usuario = new Usuario
            {
                Id = 1,
                Nombre = devName,
                Apellido = "Dev",
                Correo = devEmail,
                Rol = Enum.Parse<RolUsuario>(devRole),
                Activo = true
            };
            return Task.FromResult<Usuario?>(usuario);
        }

        return Task.FromResult<Usuario?>(null);
    }

    public Task<UsuarioResponseDto> RegisterAsync(CrearUsuarioDto dto) =>
        throw new NotSupportedException("Solo disponible en Production");

    public Task<BusquedaEstudiantesDto> SearchStudentsAsync(string? search, string? skill, string? interest, string? availability, int page, int pageSize)
    {
        page = Math.Max(1, page);
        pageSize = Math.Clamp(pageSize, 1, 50);

        if (!_env.IsDevelopment())
        {
            return Task.FromResult(new BusquedaEstudiantesDto
            {
                Page = page,
                PageSize = pageSize,
                Total = 0,
                Items = Array.Empty<EstudianteTalentoDto>()
            });
        }

        // El servicio Dev solo mantiene en memoria el usuario de autenticación y no tiene estudiantes indexados.
        // Una búsqueda sin registros es el resultado real de ese almacén, no una operación simulada.
        return Task.FromResult(new BusquedaEstudiantesDto
        {
            Page = page,
            PageSize = pageSize,
            Total = 0,
            Items = Array.Empty<EstudianteTalentoDto>()
        });
    }
}
