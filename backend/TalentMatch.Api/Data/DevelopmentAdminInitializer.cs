using Microsoft.EntityFrameworkCore;
using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Enums;

namespace TalentMatch.Api.Data;

public sealed class DevelopmentAdminInitializer
{
    private readonly TalentMatchDbContext _context;
    private readonly IConfiguration _configuration;
    private readonly IWebHostEnvironment _environment;

    public DevelopmentAdminInitializer(
        TalentMatchDbContext context,
        IConfiguration configuration,
        IWebHostEnvironment environment)
    {
        _context = context;
        _configuration = configuration;
        _environment = environment;
    }

    public async Task InitializeAsync(CancellationToken cancellationToken = default)
    {
        if (!_environment.IsDevelopment() || !_configuration.GetValue<bool>("BootstrapAdmin:Enabled"))
            return;

        var email = Required("BootstrapAdmin:Email");
        var password = Required("BootstrapAdmin:Password");
        var name = Required("BootstrapAdmin:Name");
        var lastName = Required("BootstrapAdmin:LastName");

        if (password.Length < 12)
            throw new InvalidOperationException("BootstrapAdmin:Password debe tener al menos 12 caracteres.");

        if (!await _context.Database.CanConnectAsync(cancellationToken))
            throw new InvalidOperationException("No se pudo conectar con la base de datos para inicializar el Administrador de Development.");

        if ((await _context.Database.GetPendingMigrationsAsync(cancellationToken)).Any())
            throw new InvalidOperationException("Hay migraciones pendientes. Aplique las migraciones antes de inicializar el Administrador.");

        if (await _context.Usuarios.AnyAsync(u => u.Rol == RolUsuario.Administrador, cancellationToken))
            return;

        if (await _context.Usuarios.AnyAsync(u => u.Correo == email, cancellationToken))
            throw new InvalidOperationException("El correo configurado para BootstrapAdmin ya pertenece a otro usuario.");

        _context.Usuarios.Add(new Usuario
        {
            Nombre = name,
            Apellido = lastName,
            Correo = email,
            PasswordHash = BCrypt.Net.BCrypt.HashPassword(password),
            Rol = RolUsuario.Administrador,
            Activo = true,
            FechaRegistro = DateTime.UtcNow
        });

        await _context.SaveChangesAsync(cancellationToken);
    }

    private string Required(string key)
    {
        var value = _configuration[key]?.Trim();
        if (string.IsNullOrWhiteSpace(value))
            throw new InvalidOperationException($"Configure {key} mediante user-secrets antes de inicializar el Administrador.");

        return value;
    }
}
