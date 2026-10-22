using TalentMatch.Api.DTOs.Usuarios;
using TalentMatch.Api.Domain.Entities;

namespace TalentMatch.Api.Services.Interfaces;

public interface IUsuarioService
{
    Task<IEnumerable<UsuarioResponseDto>> GetAllAsync();
    Task<UsuarioResponseDto?> GetByIdAsync(int id);
    Task<UsuarioResponseDto> CreateAsync(CrearUsuarioDto dto);
    Task<UsuarioResponseDto> CreateAdministrativeAsync(CrearUsuarioAdministrativoDto dto);
    Task<UsuarioResponseDto> AssignProfessorAsync(int usuarioId);
    Task<UsuarioResponseDto> UpdateAsync(int id, ActualizarUsuarioDto dto, int currentUserId, string currentUserRole);
    Task<Usuario?> AuthenticateAsync(string correo, string password);
    Task<UsuarioResponseDto> RegisterAsync(CrearUsuarioDto dto);
    Task<BusquedaEstudiantesDto> SearchStudentsAsync(string? search, string? skill, string? interest, string? availability, int page, int pageSize);
}
