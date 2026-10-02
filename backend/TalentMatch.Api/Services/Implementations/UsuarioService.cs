using System.Security.Claims;
using TalentMatch.Api.Data;
using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Enums;
using TalentMatch.Api.Domain.Exceptions;
using TalentMatch.Api.DTOs.Usuarios;
using TalentMatch.Api.Repositories.Interfaces;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Services.Implementations;

public class UsuarioService : IUsuarioService
{
    private readonly IUsuarioRepository _usuarioRepository;
    private readonly TalentMatchDbContext _context;

    public UsuarioService(IUsuarioRepository usuarioRepository, TalentMatchDbContext context)
    {
        _usuarioRepository = usuarioRepository;
        _context = context;
    }

    public async Task<IEnumerable<UsuarioResponseDto>> GetAllAsync()
    {
        var usuarios = await _usuarioRepository.GetAllAsync();
        return usuarios.Select(MapToResponseDto);
    }

    public async Task<UsuarioResponseDto?> GetByIdAsync(int id)
    {
        var usuario = await _usuarioRepository.GetByIdAsync(id);
        return usuario is null ? null : MapToResponseDto(usuario);
    }

    public async Task<UsuarioResponseDto> CreateAsync(CrearUsuarioDto dto)
    {
        await ValidateUniqueEmailAsync(dto.Correo);

        var usuario = new Usuario
        {
            Nombre = dto.Nombre,
            Apellido = dto.Apellido,
            Correo = dto.Correo.Trim(),
            PasswordHash = BCrypt.Net.BCrypt.HashPassword(dto.Password),
            Rol = ParseRol(dto.Rol),
            Activo = true,
            FechaRegistro = DateTime.UtcNow
        };

        await _usuarioRepository.AddAsync(usuario);

        if (usuario.Rol == RolUsuario.Estudiante)
        {
            var estudiante = new Estudiante
            {
                UsuarioId = usuario.Id,
                CodigoEstudiante = $"EST-{usuario.Id:D6}",
                Carrera = "No especificada",
                Semestre = 1
            };
            _context.Estudiantes.Add(estudiante);
            await _context.SaveChangesAsync();
        }
        else if (usuario.Rol == RolUsuario.Profesor)
        {
            var profesor = new Profesor
            {
                UsuarioId = usuario.Id,
                CodigoProfesor = $"PRO-{usuario.Id:D6}",
                Facultad = "No especificada"
            };
            _context.Profesores.Add(profesor);
            await _context.SaveChangesAsync();
        }

        return MapToResponseDto(usuario);
    }

    public async Task<UsuarioResponseDto> UpdateAsync(int id, ActualizarUsuarioDto dto, int currentUserId, string currentUserRole)
    {
        if (id != currentUserId && currentUserRole != "Administrador")
            throw new TalentMatchException("No tienes permisos para modificar este usuario.", 403);

        var usuario = await _usuarioRepository.GetByIdAsync(id)
            ?? throw new TalentMatchException("Usuario no encontrado.", 404);

        if (!string.Equals(usuario.Correo, dto.Correo, StringComparison.OrdinalIgnoreCase))
        {
            await ValidateUniqueEmailAsync(dto.Correo, id);
        }

        usuario.Nombre = dto.Nombre;
        usuario.Apellido = dto.Apellido;
        usuario.Correo = dto.Correo.Trim();

        await _usuarioRepository.UpdateAsync(usuario);
        return MapToResponseDto(usuario);
    }

    public async Task<Usuario?> AuthenticateAsync(string correo, string password)
    {
        var usuario = await _usuarioRepository.GetByCorreoAsync(correo.Trim());
        if (usuario is null || !usuario.Activo)
            return null;

        return BCrypt.Net.BCrypt.Verify(password, usuario.PasswordHash) ? usuario : null;
    }

    public async Task<UsuarioResponseDto> RegisterAsync(CrearUsuarioDto dto)
    {
        return await CreateAsync(dto);
    }

    private static RolUsuario ParseRol(string rol)
    {
        return rol.Trim() switch
        {
            "Estudiante" => RolUsuario.Estudiante,
            "Profesor" => RolUsuario.Profesor,
            "Administrador" => RolUsuario.Administrador,
            _ => throw new TalentMatchException("Rol no válido.", 400)
        };
    }

    private async Task ValidateUniqueEmailAsync(string correo, int? ignoreUsuarioId = null)
    {
        var existing = await _usuarioRepository.GetByCorreoAsync(correo.Trim());
        if (existing is not null && (!ignoreUsuarioId.HasValue || existing.Id != ignoreUsuarioId.Value))
            throw new TalentMatchException("El correo ya está registrado.", 409);
    }

    private static UsuarioResponseDto MapToResponseDto(Usuario usuario)
    {
        return new UsuarioResponseDto
        {
            Id = usuario.Id,
            Nombre = usuario.Nombre,
            Apellido = usuario.Apellido,
            Correo = usuario.Correo,
            Rol = usuario.Rol.ToString(),
            Activo = usuario.Activo,
            FechaRegistro = usuario.FechaRegistro
        };
    }
}
