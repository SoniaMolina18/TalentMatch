using System.IdentityModel.Tokens.Jwt;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using TalentMatch.Api.Data;
using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Enums;
using TalentMatch.Api.Domain.Exceptions;
using TalentMatch.Api.DTOs.Usuarios;
using TalentMatch.Api.DTOs.Perfiles;
using TalentMatch.Api.Repositories.Implementations;
using TalentMatch.Api.Repositories.Interfaces;
using TalentMatch.Api.Security;
using TalentMatch.Api.Services.Implementations;
using Xunit;

namespace TalentMatch.Api.Tests;

public sealed class AuthenticationAndAuthorizationTests
{
    [Fact]
    public void Jwt_contains_real_identity_and_role_claims()
    {
        var configuration = new ConfigurationBuilder()
            .AddInMemoryCollection(new Dictionary<string, string?>
            {
                ["Jwt:Key"] = "development-only-test-key-with-at-least-32-chars",
                ["Jwt:Issuer"] = "TalentMatch.Api",
                ["Jwt:Audience"] = "TalentMatch.Client",
                ["Jwt:ExpiryMinutes"] = "60"
            })
            .Build();

        var token = new JwtService(configuration).GenerateToken(new Usuario
        {
            Id = 42,
            Nombre = "Usuario",
            Apellido = "Sintético",
            Correo = "usuario@example.test",
            Rol = RolUsuario.Profesor
        });

        var jwt = new JwtSecurityTokenHandler().ReadJwtToken(token);
        Assert.Contains(jwt.Claims, claim => claim.Type == JwtRegisteredClaimNames.Sub && claim.Value == "42");
        Assert.Contains(jwt.Claims, claim => claim.Type == System.Security.Claims.ClaimTypes.Email && claim.Value == "usuario@example.test");
        Assert.Contains(jwt.Claims, claim => claim.Type == System.Security.Claims.ClaimTypes.Role && claim.Value == "Profesor");
    }

    [Fact]
    public async Task Public_registration_rejects_privileged_role_before_persistence()
    {
        var repository = new InMemoryUsuarioRepository();
        var context = new TalentMatchDbContext(new Microsoft.EntityFrameworkCore.DbContextOptionsBuilder<TalentMatchDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString())
            .Options);
        var service = new UsuarioService(repository, context);

        var exception = await Assert.ThrowsAsync<TalentMatchException>(() => service.RegisterAsync(new CrearUsuarioDto
        {
            Nombre = "No",
            Apellido = "Permitido",
            Correo = "no-permitido@example.test",
            Password = "No se persiste",
            Rol = "Administrador"
        }));

        Assert.Equal(400, exception.StatusCode);
        Assert.Empty(repository.Users);
    }

    [Fact]
    public async Task Public_registration_hashes_student_password()
    {
        var repository = new InMemoryUsuarioRepository();
        var context = new TalentMatchDbContext(new Microsoft.EntityFrameworkCore.DbContextOptionsBuilder<TalentMatchDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString())
            .Options);
        var service = new UsuarioService(repository, context);
        const string password = "Student-password-123!";

        var result = await service.RegisterAsync(new CrearUsuarioDto
        {
            Nombre = "Estudiante",
            Apellido = "Sintético",
            Correo = "estudiante@example.test",
            Password = password,
            Rol = "Estudiante"
        });

        var user = repository.Users.Single();
        Assert.Equal("Estudiante", result.Rol);
        Assert.NotEqual(password, user.PasswordHash);
        Assert.True(BCrypt.Net.BCrypt.Verify(password, user.PasswordHash));
    }

    [Fact]
    public async Task Profile_read_rejects_a_different_user()
    {
        await using var context = new TalentMatchDbContext(new DbContextOptionsBuilder<TalentMatchDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString())
            .Options);
        var service = new PerfilService(new PerfilRepository(context), new UsuarioRepository(context));

        var exception = await Assert.ThrowsAsync<TalentMatchException>(() =>
            service.GetByUsuarioIdAsync(20, 10, "Estudiante"));

        Assert.Equal(403, exception.StatusCode);
    }

    [Fact]
    public async Task Admin_bootstrap_requires_explicit_credentials_and_flag()
    {
        await using var context = new TalentMatchDbContext(new DbContextOptionsBuilder<TalentMatchDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString())
            .Options);
        var configuration = new ConfigurationBuilder()
            .AddInMemoryCollection(new Dictionary<string, string?>
            {
                ["BootstrapAdmin:Enabled"] = "true"
            })
            .Build();
        var environment = new TestWebHostEnvironment { EnvironmentName = "Development" };
        var initializer = new DevelopmentAdminInitializer(context, configuration, environment);

        var exception = await Assert.ThrowsAsync<InvalidOperationException>(() => initializer.InitializeAsync());

        Assert.Contains("BootstrapAdmin:Email", exception.Message);
        Assert.Empty(context.Usuarios);
    }

    private sealed class InMemoryUsuarioRepository : IUsuarioRepository
    {
        public List<Usuario> Users { get; } = [];
        public Task<IEnumerable<Usuario>> GetAllAsync() => Task.FromResult<IEnumerable<Usuario>>(Users);
        public Task<Usuario?> GetByIdAsync(int id) => Task.FromResult(Users.SingleOrDefault(x => x.Id == id));
        public Task<Usuario?> GetByCorreoAsync(string correo) => Task.FromResult(Users.SingleOrDefault(x => x.Correo == correo));
        public Task AddAsync(Usuario usuario)
        {
            usuario.Id = Users.Count + 1;
            Users.Add(usuario);
            return Task.CompletedTask;
        }
        public Task UpdateAsync(Usuario usuario) => Task.CompletedTask;
        public Task DeleteAsync(int id) => Task.CompletedTask;

        public Task<(IReadOnlyCollection<Usuario> Items, int Total)> SearchStudentsAsync(
            string? search,
            string? skill,
            string? interest,
            string? availability,
            int page,
            int pageSize)
        {
            page = Math.Max(1, page);
            pageSize = Math.Clamp(pageSize, 1, 50);

            IEnumerable<Usuario> query = Users.Where(user => user.Activo && user.Estudiante is not null);

            if (!string.IsNullOrWhiteSpace(search))
            {
                var value = search.Trim();
                query = query.Where(user =>
                    user.Nombre.Contains(value, StringComparison.OrdinalIgnoreCase)
                    || user.Apellido.Contains(value, StringComparison.OrdinalIgnoreCase)
                    || user.Estudiante!.Carrera.Contains(value, StringComparison.OrdinalIgnoreCase));
            }

            if (!string.IsNullOrWhiteSpace(skill))
            {
                var value = skill.Trim();
                query = query.Where(user => user.Estudiante!.EstudianteHabilidades.Any(item =>
                    item.Habilidad.Nombre.Contains(value, StringComparison.OrdinalIgnoreCase)));
            }

            if (!string.IsNullOrWhiteSpace(interest))
            {
                var value = interest.Trim();
                query = query.Where(user => user.Estudiante!.EstudianteIntereses.Any(item =>
                    item.Interes.Nombre.Contains(value, StringComparison.OrdinalIgnoreCase)));
            }

            if (!string.IsNullOrWhiteSpace(availability))
            {
                var value = availability.Trim();
                query = query.Where(user => user.Perfil?.Disponibilidad?.Contains(value, StringComparison.OrdinalIgnoreCase) == true);
            }

            var ordered = query.OrderBy(user => user.Apellido).ThenBy(user => user.Nombre);
            var total = query.Count();
            var items = ordered.Skip((page - 1) * pageSize).Take(pageSize).ToArray();

            return Task.FromResult<(IReadOnlyCollection<Usuario> Items, int Total)>((items, total));
        }
    }

    private sealed class TestWebHostEnvironment : Microsoft.AspNetCore.Hosting.IWebHostEnvironment
    {
        public string EnvironmentName { get; set; } = "Development";
        public string ApplicationName { get; set; } = typeof(AuthenticationAndAuthorizationTests).Assembly.GetName().Name!;
        public string WebRootPath { get; set; } = string.Empty;
        public Microsoft.Extensions.FileProviders.IFileProvider WebRootFileProvider { get; set; } = new Microsoft.Extensions.FileProviders.NullFileProvider();
        public string ContentRootPath { get; set; } = AppContext.BaseDirectory;
        public Microsoft.Extensions.FileProviders.IFileProvider ContentRootFileProvider { get; set; } = new Microsoft.Extensions.FileProviders.NullFileProvider();
    }
}
