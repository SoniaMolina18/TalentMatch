using System.Reflection;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.Sqlite;
using Microsoft.EntityFrameworkCore;
using TalentMatch.Api.Controllers;
using TalentMatch.Api.Data;
using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Exceptions;
using TalentMatch.Api.DTOs.Usuarios;
using TalentMatch.Api.Repositories.Implementations;
using TalentMatch.Api.Services.Implementations;
using Xunit;

namespace TalentMatch.Api.Tests;

public sealed class AdministrativeUserCreationTests
{
    [Fact]
    public void Administrative_endpoint_requires_administrator_role()
    {
        var method = typeof(UsuariosController).GetMethod(nameof(UsuariosController.CreateAdministrative));
        var authorize = method?.GetCustomAttribute<AuthorizeAttribute>();

        Assert.NotNull(authorize);
        Assert.Equal("Administrador", authorize!.Roles);
        Assert.Null(method.GetCustomAttribute<AllowAnonymousAttribute>());
    }

    [Theory]
    [InlineData("Profesor")]
    [InlineData("Estudiante")]
    public void Non_administrator_roles_are_not_granted_by_endpoint_policy(string role)
    {
        var method = typeof(UsuariosController).GetMethod(nameof(UsuariosController.CreateAdministrative));
        var authorize = method?.GetCustomAttribute<AuthorizeAttribute>();

        Assert.NotNull(authorize);
        Assert.DoesNotContain(role, authorize!.Roles!.Split(','));
    }

    [Fact]
    public async Task Administrator_can_create_student_with_hashed_password_and_related_entity()
    {
        await using var fixture = await SqliteFixture.CreateAsync();
        const string password = "Student-password-123!";

        var result = await fixture.Service.CreateAdministrativeAsync(new CrearUsuarioAdministrativoDto
        {
            Nombre = "Estudiante",
            Apellido = "Administrativo",
            Correo = "estudiante.admin@example.test",
            Password = password,
            Rol = "Estudiante"
        });

        var user = await fixture.Context.Usuarios.SingleAsync();
        var student = await fixture.Context.Estudiantes.SingleAsync();

        Assert.Equal("Estudiante", result.Rol);
        Assert.NotEqual(password, user.PasswordHash);
        Assert.True(BCrypt.Net.BCrypt.Verify(password, user.PasswordHash));
        Assert.Equal(user.Id, student.UsuarioId);
        Assert.DoesNotContain("PasswordHash", System.Text.Json.JsonSerializer.Serialize(result));
    }

    [Fact]
    public async Task Administrator_can_create_professor_with_related_entity()
    {
        await using var fixture = await SqliteFixture.CreateAsync();

        var result = await fixture.Service.CreateAdministrativeAsync(new CrearUsuarioAdministrativoDto
        {
            Nombre = "Profesor",
            Apellido = "Administrativo",
            Correo = "profesor.admin@example.test",
            Password = "Professor-password-123!",
            Rol = "Profesor"
        });

        var user = await fixture.Context.Usuarios.SingleAsync();
        var professor = await fixture.Context.Profesores.SingleAsync();

        Assert.Equal("Profesor", result.Rol);
        Assert.Equal(user.Id, professor.UsuarioId);
    }

    [Theory]
    [InlineData("Administrador")]
    [InlineData("Invitado")]
    public async Task Administrative_creation_rejects_roles_outside_student_and_professor(string role)
    {
        await using var fixture = await SqliteFixture.CreateAsync();

        var exception = await Assert.ThrowsAsync<TalentMatchException>(() => fixture.Service.CreateAdministrativeAsync(new CrearUsuarioAdministrativoDto
        {
            Nombre = "No",
            Apellido = "Permitido",
            Correo = $"{role.ToLowerInvariant()}@example.test",
            Password = "Secure-password-123!",
            Rol = role
        }));

        Assert.Equal(400, exception.StatusCode);
        Assert.Empty(await fixture.Context.Usuarios.ToListAsync());
    }

    [Fact]
    public async Task Administrative_creation_rejects_duplicate_email()
    {
        await using var fixture = await SqliteFixture.CreateAsync();
        var first = ValidDto("duplicate@example.test");
        await fixture.Service.CreateAdministrativeAsync(first);

        var exception = await Assert.ThrowsAsync<TalentMatchException>(() => fixture.Service.CreateAdministrativeAsync(ValidDto("duplicate@example.test")));

        Assert.Equal(409, exception.StatusCode);
        Assert.Equal(1, await fixture.Context.Usuarios.CountAsync());
    }

    [Fact]
    public async Task Administrative_creation_rolls_back_user_when_related_insert_fails()
    {
        await using var fixture = await SqliteFixture.CreateAsync();
        var existingUser = new Usuario
        {
            Id = 1,
            Nombre = "Existente",
            Apellido = "Profesor",
            Correo = "existente@example.test",
            PasswordHash = BCrypt.Net.BCrypt.HashPassword("Existing-password-123!"),
            Rol = Domain.Enums.RolUsuario.Profesor
        };
        fixture.Context.Usuarios.Add(existingUser);
        fixture.Context.Profesores.Add(new Profesor
        {
            UsuarioId = existingUser.Id,
            CodigoProfesor = "PRO-000002",
            Facultad = "Existente"
        });
        await fixture.Context.SaveChangesAsync();

        await Assert.ThrowsAsync<DbUpdateException>(() => fixture.Service.CreateAdministrativeAsync(new CrearUsuarioAdministrativoDto
        {
            Nombre = "Debe",
            Apellido = "Revertirse",
            Correo = "rollback@example.test",
            Password = "Rollback-password-123!",
            Rol = "Profesor"
        }));

        fixture.Context.ChangeTracker.Clear();
        Assert.Equal(1, await fixture.Context.Usuarios.CountAsync());
        Assert.Null(await fixture.Context.Usuarios.SingleOrDefaultAsync(user => user.Correo == "rollback@example.test"));
    }

    private static CrearUsuarioAdministrativoDto ValidDto(string email) => new()
    {
        Nombre = "Usuario",
        Apellido = "Administrativo",
        Correo = email,
        Password = "Valid-password-123!",
        Rol = "Estudiante"
    };

    private sealed class SqliteFixture : IAsyncDisposable
    {
        private readonly SqliteConnection _connection;
        public TalentMatchDbContext Context { get; }
        public UsuarioService Service { get; }

        private SqliteFixture(SqliteConnection connection, TalentMatchDbContext context)
        {
            _connection = connection;
            Context = context;
            Service = new UsuarioService(new UsuarioRepository(context), context);
        }

        public static async Task<SqliteFixture> CreateAsync()
        {
            var connection = new SqliteConnection("Data Source=:memory:");
            await connection.OpenAsync();
            var options = new DbContextOptionsBuilder<TalentMatchDbContext>()
                .UseSqlite(connection)
                .Options;
            var context = new TalentMatchDbContext(options);
            await context.Database.EnsureCreatedAsync();
            return new SqliteFixture(connection, context);
        }

        public async ValueTask DisposeAsync()
        {
            await Context.DisposeAsync();
            await _connection.DisposeAsync();
        }
    }
}
