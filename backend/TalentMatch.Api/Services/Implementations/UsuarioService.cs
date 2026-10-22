using System.Security.Claims;
using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;
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

    public async Task<UsuarioResponseDto> CreateAdministrativeAsync(CrearUsuarioAdministrativoDto dto)
    {
        ValidateAdministrativeInput(dto);
        await ValidateUniqueEmailAsync(dto.Correo);

        await using var transaction = await _context.Database.BeginTransactionAsync();
        try
        {
            var role = dto.Rol.Trim() switch
            {
                "Estudiante" => RolUsuario.Estudiante,
                "Profesor" => RolUsuario.Profesor,
                _ => throw new TalentMatchException("Solo se pueden crear usuarios Estudiante o Profesor.", 400)
            };

            var usuario = new Usuario
            {
                Nombre = dto.Nombre.Trim(),
                Apellido = dto.Apellido.Trim(),
                Correo = dto.Correo.Trim(),
                PasswordHash = BCrypt.Net.BCrypt.HashPassword(dto.Password),
                Rol = role,
                Activo = true,
                FechaRegistro = DateTime.UtcNow
            };

            await _context.Usuarios.AddAsync(usuario);
            await _context.SaveChangesAsync();

            if (role == RolUsuario.Estudiante)
            {
                _context.Estudiantes.Add(new Estudiante
                {
                    UsuarioId = usuario.Id,
                    CodigoEstudiante = $"EST-{usuario.Id:D6}",
                    Carrera = "No especificada",
                    Semestre = 1
                });
            }
            else
            {
                _context.Profesores.Add(new Profesor
                {
                    UsuarioId = usuario.Id,
                    CodigoProfesor = $"PRO-{usuario.Id:D6}",
                    Facultad = "No especificada"
                });
            }

            await _context.SaveChangesAsync();
            await transaction.CommitAsync();
            return MapToResponseDto(usuario);
        }
        catch
        {
            await transaction.RollbackAsync();
            throw;
        }
    }

    public async Task<UsuarioResponseDto> AssignProfessorAsync(int usuarioId)
    {
        var usuario = await _usuarioRepository.GetByIdAsync(usuarioId)
            ?? throw new TalentMatchException("Usuario no encontrado.", 404);

        if (usuario.Rol == RolUsuario.Administrador)
            throw new TalentMatchException("No se puede convertir un Administrador en Profesor.", 400);

        usuario.Rol = RolUsuario.Profesor;
        await _usuarioRepository.UpdateAsync(usuario);

        var profesor = await _context.Profesores.FirstOrDefaultAsync(p => p.UsuarioId == usuario.Id);
        if (profesor is null)
        {
            _context.Profesores.Add(new Profesor
            {
                UsuarioId = usuario.Id,
                CodigoProfesor = $"PRO-{usuario.Id:D6}",
                Facultad = "No especificada"
            });
            await _context.SaveChangesAsync();
        }

        return MapToResponseDto(usuario);
    }

    private static void ValidateAdministrativeInput(CrearUsuarioAdministrativoDto dto)
    {
        if (string.IsNullOrWhiteSpace(dto.Nombre) || dto.Nombre.Trim().Length > 100
            || string.IsNullOrWhiteSpace(dto.Apellido) || dto.Apellido.Trim().Length > 100)
            throw new TalentMatchException("Nombre y apellido son obligatorios y no pueden superar 100 caracteres.", 400);

        if (string.IsNullOrWhiteSpace(dto.Correo) || dto.Correo.Trim().Length > 200
            || !new EmailAddressAttribute().IsValid(dto.Correo.Trim()))
            throw new TalentMatchException("El correo electrónico no es válido.", 400);

        if (string.IsNullOrWhiteSpace(dto.Password)
            || dto.Password.Length < 8
            || !dto.Password.Any(char.IsUpper)
            || !dto.Password.Any(char.IsLower)
            || !dto.Password.Any(char.IsDigit)
            || dto.Password.All(char.IsLetterOrDigit))
            throw new TalentMatchException("La contraseña debe tener al menos 8 caracteres, mayúscula, minúscula, número y símbolo.", 400);

        if (dto.Rol.Trim() is not ("Estudiante" or "Profesor"))
            throw new TalentMatchException("Solo se pueden crear usuarios Estudiante o Profesor.", 400);
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
        if (!string.Equals(dto.Rol?.Trim(), "Estudiante", StringComparison.OrdinalIgnoreCase))
            throw new TalentMatchException("El registro público solo permite el rol Estudiante.", 400);

        dto.Rol = "Estudiante";
        return await CreateAsync(dto);
    }

    public async Task<BusquedaEstudiantesDto> SearchStudentsAsync(string? search, string? skill, string? interest, string? availability, int page, int pageSize)
    {
        page = Math.Max(1, page);
        pageSize = Math.Clamp(pageSize, 1, 50);
        var (items, total) = await _usuarioRepository.SearchStudentsAsync(search, skill, interest, availability, page, pageSize);
        return new BusquedaEstudiantesDto
        {
            Page = page,
            PageSize = pageSize,
            Total = total,
            Items = items.Where(u => u.Estudiante is not null).Select(u => new EstudianteTalentoDto
            {
                EstudianteId = u.Estudiante!.Id,
                UsuarioId = u.Id,
                Nombre = u.Nombre,
                Apellido = u.Apellido,
                Carrera = u.Estudiante.Carrera,
                Semestre = u.Estudiante.Semestre,
                Descripcion = u.Perfil?.Descripcion,
                Disponibilidad = u.Perfil?.Disponibilidad,
                Habilidades = u.Estudiante.EstudianteHabilidades.Select(eh => eh.Habilidad.Nombre).ToArray(),
                Intereses = u.Estudiante.EstudianteIntereses.Select(ei => ei.Interes.Nombre).ToArray()
            }).ToArray()
        };
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
