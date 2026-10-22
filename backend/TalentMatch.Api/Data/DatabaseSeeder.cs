using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage;
using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Enums;

namespace TalentMatch.Api.Data;

public static class DatabaseSeeder
{
    private const int StudentTarget = 100;
    private const int ProfessorTarget = 15;
    private const int ProfileTarget = 100;
    private const int SkillTarget = 50;
    private const int InterestTarget = 20;
    private const int ProjectTarget = 60;
    private const int TeamTarget = 40;
    private const int ApplicationTarget = 150;
    private const int NotificationTarget = 200;
    private const string LegacyStudentEmail = "seed.estudiante@talentmatch.local";
    private const string LegacyProfessorEmail = "seed.profesor@talentmatch.local";
    private const string SeedEmailDomain = "talentmatch.local";
    private const string SeedMarker = "C3";

    public static async Task SeedAsync(IServiceProvider services, IConfiguration configuration)
    {
        await using var scope = services.CreateAsyncScope();
        var context = scope.ServiceProvider.GetRequiredService<TalentMatchDbContext>();
        var environment = scope.ServiceProvider.GetRequiredService<IWebHostEnvironment>();

        if (!environment.IsDevelopment())
            throw new InvalidOperationException("DatabaseSeeder solo puede ejecutarse en Development.");

        if (!configuration.GetValue<bool>("Persistence:UseRealServices"))
            throw new InvalidOperationException("DatabaseSeeder requiere Persistence:UseRealServices=true.");

        if (!configuration.GetValue<bool>("Persistence:SeedDevelopment"))
            throw new InvalidOperationException("DatabaseSeeder requiere Persistence:SeedDevelopment=true.");

        var seedPassword = configuration["Seed:Password"];
        if (string.IsNullOrWhiteSpace(seedPassword))
            throw new InvalidOperationException("Configure Seed:Password mediante user-secrets antes de ejecutar el seed de Development.");

        if (!await context.Database.CanConnectAsync())
            throw new InvalidOperationException("No se pudo conectar con la base de datos de Development para ejecutar el seed.");

        if ((await context.Database.GetPendingMigrationsAsync()).Any())
            throw new InvalidOperationException("Hay migraciones pendientes. Aplique la migración antes de ejecutar el seed de Development.");

        var strategy = context.Database.CreateExecutionStrategy();
        await strategy.ExecuteAsync(async () =>
        {
            await using var transaction = await context.Database.BeginTransactionAsync();
            try
            {
                await SeedWithinTransactionAsync(context, seedPassword);
                await ValidateSeedAsync(context);
                await transaction.CommitAsync();
            }
            catch
            {
                await transaction.RollbackAsync();
                throw;
            }
        });
    }

    private static async Task SeedWithinTransactionAsync(TalentMatchDbContext context, string seedPassword)
    {
        var skills = await EnsureSkillsAsync(context);
        var interests = await EnsureInterestsAsync(context);
        var students = await EnsureStudentsAsync(context, seedPassword);
        var professors = await EnsureProfessorsAsync(context, seedPassword);
        await EnsureProfilesAsync(context, students);
        var projects = await EnsureProjectsAsync(context, professors);
        var teams = await EnsureTeamsAsync(context, projects);
        await EnsureStudentRelationshipsAsync(context, students, skills, interests);
        await EnsureProjectRelationshipsAsync(context, projects, skills, interests);
        await EnsureTeamMembersAsync(context, teams, students);
        await EnsureApplicationsAsync(context, students, projects);
        await EnsureRecommendationsAsync(context, students, projects);
        await EnsureNotificationsAsync(context, students, professors);
    }

    private static async Task<List<Habilidad>> EnsureSkillsAsync(TalentMatchDbContext context)
    {
        var result = new List<Habilidad>();
        var categories = new[] { "Backend", "Frontend", "Datos", "Infraestructura", "Diseño" };
        for (var index = 1; index <= SkillTarget; index++)
        {
            var name = $"{SeedMarker}-Habilidad-{index:D3}";
            var skill = await context.Habilidades.FirstOrDefaultAsync(x => x.Nombre == name);
            if (skill is null)
            {
                skill = new Habilidad { Nombre = name, Categoria = categories[(index - 1) % categories.Length] };
                context.Habilidades.Add(skill);
                await context.SaveChangesAsync();
            }
            result.Add(skill);
        }
        return result;
    }

    private static async Task<List<Interes>> EnsureInterestsAsync(TalentMatchDbContext context)
    {
        var result = new List<Interes>();
        for (var index = 1; index <= InterestTarget; index++)
        {
            var name = $"{SeedMarker}-Interes-{index:D3}";
            var interest = await context.Intereses.FirstOrDefaultAsync(x => x.Nombre == name);
            if (interest is null)
            {
                interest = new Interes { Nombre = name };
                context.Intereses.Add(interest);
                await context.SaveChangesAsync();
            }
            result.Add(interest);
        }
        return result;
    }

    private static async Task<List<Estudiante>> EnsureStudentsAsync(TalentMatchDbContext context, string password)
    {
        var result = new List<Estudiante>();
        for (var index = 1; index <= StudentTarget; index++)
        {
            var email = index == 1 ? LegacyStudentEmail : $"seed.estudiante.{index:D3}@{SeedEmailDomain}";
            var user = await EnsureUserAsync(context, email, $"Estudiante{index:D3}", "Sintético", RolUsuario.Estudiante, password);
            var student = await context.Estudiantes.FirstOrDefaultAsync(x => x.UsuarioId == user.Id);
            if (student is null)
            {
                student = new Estudiante
                {
                    UsuarioId = user.Id,
                    CodigoEstudiante = index == 1 ? $"SEED-EST-{user.Id:D6}" : $"SEED-EST-{index:D3}",
                    Carrera = GetCareer(index),
                    Semestre = (index % 10) + 1
                };
                context.Estudiantes.Add(student);
                await context.SaveChangesAsync();
            }
            result.Add(student);
        }
        return result;
    }

    private static async Task<List<Profesor>> EnsureProfessorsAsync(TalentMatchDbContext context, string password)
    {
        var result = new List<Profesor>();
        for (var index = 1; index <= ProfessorTarget; index++)
        {
            var email = index == 1 ? LegacyProfessorEmail : $"seed.profesor.{index:D3}@{SeedEmailDomain}";
            var user = await EnsureUserAsync(context, email, $"Profesor{index:D3}", "Sintético", RolUsuario.Profesor, password);
            var professor = await context.Profesores.FirstOrDefaultAsync(x => x.UsuarioId == user.Id);
            if (professor is null)
            {
                professor = new Profesor
                {
                    UsuarioId = user.Id,
                    CodigoProfesor = index == 1 ? $"SEED-PRO-{user.Id:D6}" : $"SEED-PRO-{index:D3}",
                    Facultad = GetFaculty(index)
                };
                context.Profesores.Add(professor);
                await context.SaveChangesAsync();
            }
            result.Add(professor);
        }
        return result;
    }

    private static async Task<Usuario> EnsureUserAsync(TalentMatchDbContext context, string email, string name, string lastName, RolUsuario role, string password)
    {
        var user = await context.Usuarios.FirstOrDefaultAsync(x => x.Correo == email);
        if (user is not null)
        {
            if (user.Rol != role)
                throw new InvalidOperationException($"El usuario sintético {email} tiene un rol incompatible.");
            return user;
        }

        user = new Usuario
        {
            Nombre = name,
            Apellido = lastName,
            Correo = email,
            PasswordHash = BCrypt.Net.BCrypt.HashPassword(password),
            Rol = role,
            Activo = true,
            FechaRegistro = DateTime.UtcNow
        };
        context.Usuarios.Add(user);
        await context.SaveChangesAsync();
        return user;
    }

    private static async Task EnsureProfilesAsync(TalentMatchDbContext context, IReadOnlyCollection<Estudiante> students)
    {
        foreach (var student in students)
        {
            if (!await context.Perfiles.AnyAsync(x => x.UsuarioId == student.UsuarioId))
            {
                context.Perfiles.Add(new Perfil
                {
                    UsuarioId = student.UsuarioId,
                    Descripcion = $"Perfil {SeedMarker} de estudiante sintético {student.Id}.",
                    Disponibilidad = "Disponibilidad sintética"
                });
            }
        }
        await context.SaveChangesAsync();
    }

    private static async Task<List<Proyecto>> EnsureProjectsAsync(TalentMatchDbContext context, IReadOnlyList<Profesor> professors)
    {
        var result = new List<Proyecto>();
        for (var index = 1; index <= ProjectTarget; index++)
        {
            var title = $"{SeedMarker}-Proyecto-{index:D3}";
            var project = await context.Proyectos.FirstOrDefaultAsync(x => x.Titulo == title);
            if (project is null)
            {
                project = new Proyecto
                {
                    Titulo = title,
                    Descripcion = $"Proyecto sintético {index:D3} para pruebas de Development.",
                    Estado = (EstadoProyecto)((index - 1) % Enum.GetValues<EstadoProyecto>().Length + 1),
                    FechaCreacion = DateTime.UtcNow.Date.AddDays(-index),
                    FechaLimite = DateTime.UtcNow.Date.AddDays(30 + index),
                    CuposDisponibles = 3 + (index % 8),
                    ProfesorId = professors[(index - 1) % professors.Count].Id
                };
                context.Proyectos.Add(project);
                await context.SaveChangesAsync();
            }
            result.Add(project);
        }
        return result;
    }

    private static async Task<List<Equipo>> EnsureTeamsAsync(TalentMatchDbContext context, IReadOnlyList<Proyecto> projects)
    {
        var result = new List<Equipo>();
        for (var index = 1; index <= TeamTarget; index++)
        {
            var project = projects[(index - 1) % projects.Count];
            var name = $"{SeedMarker}-Equipo-{index:D3}";
            var team = await context.Equipos.FirstOrDefaultAsync(x => x.Nombre == name && x.ProyectoId == project.Id);
            if (team is null)
            {
                team = new Equipo
                {
                    Nombre = name,
                    ProyectoId = project.Id,
                    Estado = (EstadoEquipo)((index - 1) % Enum.GetValues<EstadoEquipo>().Length + 1),
                    FechaCreacion = DateTime.UtcNow.Date.AddDays(-index)
                };
                context.Equipos.Add(team);
                await context.SaveChangesAsync();
            }
            result.Add(team);
        }
        return result;
    }

    private static async Task EnsureStudentRelationshipsAsync(TalentMatchDbContext context, IReadOnlyList<Estudiante> students, IReadOnlyList<Habilidad> skills, IReadOnlyList<Interes> interests)
    {
        foreach (var student in students)
        {
            await EnsureStudentSkillAsync(context, student.Id, skills[(student.Id - 1) % skills.Count].Id);
            await EnsureStudentSkillAsync(context, student.Id, skills[(student.Id + 6) % skills.Count].Id);
            await EnsureStudentInterestAsync(context, student.Id, interests[(student.Id - 1) % interests.Count].Id);
        }
    }

    private static async Task EnsureProjectRelationshipsAsync(TalentMatchDbContext context, IReadOnlyList<Proyecto> projects, IReadOnlyList<Habilidad> skills, IReadOnlyList<Interes> interests)
    {
        foreach (var project in projects)
        {
            await EnsureProjectSkillAsync(context, project.Id, skills[(project.Id - 1) % skills.Count].Id);
            await EnsureProjectSkillAsync(context, project.Id, skills[(project.Id + 11) % skills.Count].Id);
            await EnsureProjectInterestAsync(context, project.Id, interests[(project.Id - 1) % interests.Count].Id);
        }
    }

    private static async Task EnsureTeamMembersAsync(TalentMatchDbContext context, IReadOnlyList<Equipo> teams, IReadOnlyList<Estudiante> students)
    {
        foreach (var team in teams)
        {
            for (var offset = 0; offset < 3; offset++)
            {
                var student = students[(team.Id + offset) % students.Count];
                if (!await context.MiembrosEquipo.AnyAsync(x => x.EquipoId == team.Id && x.EstudianteId == student.Id))
                    context.MiembrosEquipo.Add(new MiembroEquipo { EquipoId = team.Id, EstudianteId = student.Id, FechaIngreso = DateTime.UtcNow });
            }
        }
        await context.SaveChangesAsync();
    }

    private static async Task EnsureApplicationsAsync(TalentMatchDbContext context, IReadOnlyList<Estudiante> students, IReadOnlyList<Proyecto> projects)
    {
        for (var index = 0; index < ApplicationTarget; index++)
        {
            var student = students[index % students.Count];
            var project = projects[(index * 7) % projects.Count];
            if (!await context.Postulaciones.AnyAsync(x => x.EstudianteId == student.Id && x.ProyectoId == project.Id))
            {
                context.Postulaciones.Add(new Postulacion
                {
                    EstudianteId = student.Id,
                    ProyectoId = project.Id,
                    Estado = (EstadoPostulacion)(index % Enum.GetValues<EstadoPostulacion>().Length + 1),
                    Mensaje = $"Postulación {SeedMarker} {index + 1:D3}.",
                    FechaPostulacion = DateTime.UtcNow.Date.AddDays(-index)
                });
            }
        }
        await context.SaveChangesAsync();
    }

    private static async Task EnsureRecommendationsAsync(TalentMatchDbContext context, IReadOnlyList<Estudiante> students, IReadOnlyList<Proyecto> projects)
    {
        for (var index = 0; index < ApplicationTarget; index++)
        {
            var student = students[index % students.Count];
            var project = projects[(index * 7) % projects.Count];
            if (!await context.Recomendaciones.AnyAsync(x => x.EstudianteId == student.Id && x.ProyectoId == project.Id))
            {
                context.Recomendaciones.Add(new Recomendacion
                {
                    EstudianteId = student.Id,
                    ProyectoId = project.Id,
                    PorcentajeCompatibilidad = 60 + (index % 40),
                    FechaGeneracion = DateTime.UtcNow.Date.AddDays(-index)
                });
            }
        }
        await context.SaveChangesAsync();
    }

    private static async Task EnsureNotificationsAsync(TalentMatchDbContext context, IReadOnlyList<Estudiante> students, IReadOnlyList<Profesor> professors)
    {
        var userIds = students.Select(x => x.UsuarioId).Concat(professors.Select(x => x.UsuarioId)).ToArray();
        for (var index = 1; index <= NotificationTarget; index++)
        {
            var userId = userIds[(index - 1) % userIds.Length];
            var title = $"{SeedMarker}-Notificacion-{index:D3}";
            if (!await context.Notificaciones.AnyAsync(x => x.UsuarioId == userId && x.Titulo == title))
            {
                context.Notificaciones.Add(new Notificacion
                {
                    UsuarioId = userId,
                    Titulo = title,
                    Mensaje = $"Notificación sintética {index:D3} para Development.",
                    Tipo = "Development",
                    Leida = index % 4 == 0,
                    FechaCreacion = DateTime.UtcNow.Date.AddDays(-index)
                });
            }
        }
        await context.SaveChangesAsync();
    }

    private static async Task ValidateSeedAsync(TalentMatchDbContext context)
    {
        var studentUsers = await context.Usuarios.CountAsync(x => x.Correo == LegacyStudentEmail || (x.Correo.StartsWith("seed.estudiante.") && x.Correo.EndsWith("@" + SeedEmailDomain)));
        var professorUsers = await context.Usuarios.CountAsync(x => x.Correo == LegacyProfessorEmail || (x.Correo.StartsWith("seed.profesor.") && x.Correo.EndsWith("@" + SeedEmailDomain)));
        var studentUserIds = await context.Estudiantes
            .Where(x => x.Usuario.Correo == LegacyStudentEmail || (x.Usuario.Correo.StartsWith("seed.estudiante.") && x.Usuario.Correo.EndsWith("@" + SeedEmailDomain)))
            .Select(x => x.UsuarioId)
            .ToListAsync();
        var profiles = await context.Perfiles.CountAsync(x => studentUserIds.Contains(x.UsuarioId));
        var skills = await context.Habilidades.CountAsync(x => x.Nombre.StartsWith(SeedMarker + "-Habilidad-"));
        var interests = await context.Intereses.CountAsync(x => x.Nombre.StartsWith(SeedMarker + "-Interes-"));
        var projects = await context.Proyectos.CountAsync(x => x.Titulo.StartsWith(SeedMarker + "-Proyecto-"));
        var teams = await context.Equipos.CountAsync(x => x.Nombre.StartsWith(SeedMarker + "-Equipo-"));
        var applications = await context.Postulaciones.CountAsync(x => x.Mensaje != null && x.Mensaje.StartsWith("Postulación " + SeedMarker));
        var notifications = await context.Notificaciones.CountAsync(x => x.Titulo.StartsWith(SeedMarker + "-Notificacion-"));

        if (studentUsers != StudentTarget || professorUsers != ProfessorTarget || profiles < ProfileTarget || skills != SkillTarget || interests != InterestTarget || projects != ProjectTarget || teams != TeamTarget || applications != ApplicationTarget || notifications != NotificationTarget)
            throw new InvalidOperationException("La validación del conjunto sintético no alcanzó las cantidades objetivo.");

        if (await context.Usuarios.AnyAsync(x => x.Rol == RolUsuario.Administrador && (x.Correo == LegacyStudentEmail || x.Correo == LegacyProfessorEmail || x.Correo.StartsWith("seed."))))
            throw new InvalidOperationException("El conjunto sintético no puede crear Administradores.");

        if (await context.Postulaciones.Where(x => x.Mensaje != null && x.Mensaje.StartsWith("Postulación " + SeedMarker)).GroupBy(x => new { x.EstudianteId, x.ProyectoId }).AnyAsync(x => x.Count() > 1))
            throw new InvalidOperationException("El conjunto sintético contiene postulaciones duplicadas.");
    }

    private static async Task EnsureProjectSkillAsync(TalentMatchDbContext context, int projectId, int skillId)
    {
        if (!await context.ProyectoHabilidades.AnyAsync(x => x.ProyectoId == projectId && x.HabilidadId == skillId))
        {
            context.ProyectoHabilidades.Add(new ProyectoHabilidad { ProyectoId = projectId, HabilidadId = skillId });
            await context.SaveChangesAsync();
        }
    }

    private static async Task EnsureProjectInterestAsync(TalentMatchDbContext context, int projectId, int interestId)
    {
        if (!await context.ProyectoIntereses.AnyAsync(x => x.ProyectoId == projectId && x.InteresId == interestId))
        {
            context.ProyectoIntereses.Add(new ProyectoInteres { ProyectoId = projectId, InteresId = interestId });
            await context.SaveChangesAsync();
        }
    }

    private static async Task EnsureStudentSkillAsync(TalentMatchDbContext context, int studentId, int skillId)
    {
        if (!await context.EstudianteHabilidades.AnyAsync(x => x.EstudianteId == studentId && x.HabilidadId == skillId))
        {
            context.EstudianteHabilidades.Add(new EstudianteHabilidad { EstudianteId = studentId, HabilidadId = skillId });
            await context.SaveChangesAsync();
        }
    }

    private static async Task EnsureStudentInterestAsync(TalentMatchDbContext context, int studentId, int interestId)
    {
        if (!await context.EstudianteIntereses.AnyAsync(x => x.EstudianteId == studentId && x.InteresId == interestId))
        {
            context.EstudianteIntereses.Add(new EstudianteInteres { EstudianteId = studentId, InteresId = interestId });
            await context.SaveChangesAsync();
        }
    }

    private static string GetCareer(int index) => new[] { "Ingeniería de software", "Ciencia de datos", "Diseño digital", "Sistemas", "Tecnologías web" }[(index - 1) % 5];
    private static string GetFaculty(int index) => new[] { "Facultad de Tecnología", "Facultad de Ciencias", "Facultad de Diseño" }[(index - 1) % 3];
}
