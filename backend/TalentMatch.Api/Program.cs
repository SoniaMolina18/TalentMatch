using System.Text;
using System.Linq;
using System.Security.Cryptography;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using TalentMatch.Api.Data;
using TalentMatch.Api.Middleware;
using Microsoft.AspNetCore.Hosting.Server.Features;
using TalentMatch.Api.Repositories.Implementations;
using TalentMatch.Api.Repositories.Interfaces;
using TalentMatch.Api.Security;
using TalentMatch.Api.Services.Implementations;
using TalentMatch.Api.Services.Interfaces;
using System.Net;

var builder = WebApplication.CreateBuilder(args);

// Configurar Kestrel para usar un puerto fijo en localhost (ejemplo: 5000)
builder.WebHost.ConfigureKestrel(options =>
{
    // Listener HTTP en puerto fijo (IPv4 loopback)
    options.Listen(IPAddress.Loopback, 5000);

    // Listener HTTPS en puerto dinámico usando certificados disponibles (si existen)
    try
    {
        options.ListenLocalhost(0, listenOptions => { listenOptions.UseHttps(); });
    }
    catch
    {
        // Si no hay certificado de desarrollo, seguir con HTTP sólo.
    }
});

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();

builder.Services.AddDbContext<TalentMatchDbContext>(options =>
    options.UseSqlServer(
        builder.Configuration.GetConnectionString("TalentMatchDatabase")
    )
);

builder.Services.AddScoped<IUsuarioRepository, UsuarioRepository>();
builder.Services.AddScoped<IPerfilRepository, PerfilRepository>();
builder.Services.AddScoped<IHabilidadRepository, HabilidadRepository>();
builder.Services.AddScoped<IInteresRepository, InteresRepository>();
builder.Services.AddScoped<IProyectoRepository, ProyectoRepository>();
builder.Services.AddScoped<IEquipoRepository, EquipoRepository>();
builder.Services.AddScoped<IInvitacionEquipoRepository, InvitacionEquipoRepository>();
builder.Services.AddScoped<IPostulacionRepository, PostulacionRepository>();
builder.Services.AddScoped<IRecomendacionRepository, RecomendacionRepository>();
builder.Services.AddScoped<INotificacionRepository, NotificacionRepository>();
builder.Services.AddScoped<IMensajeRepository, MensajeRepository>();

builder.Services.AddScoped<IUsuarioService, UsuarioService>();
builder.Services.AddScoped<IPerfilService, PerfilService>();
builder.Services.AddScoped<IProyectoService, ProyectoService>();
builder.Services.AddScoped<IEquipoService, EquipoService>();
builder.Services.AddScoped<IInvitacionEquipoService, InvitacionEquipoService>();
builder.Services.AddScoped<IPostulacionService, PostulacionService>();
builder.Services.AddScoped<IRecomendacionService, RecomendacionService>();
builder.Services.AddScoped<INotificacionService, NotificacionService>();
builder.Services.AddScoped<IMensajeService, MensajeService>();
builder.Services.AddScoped<JwtService>();
builder.Services.AddScoped<DevelopmentAdminInitializer>();

var jwtKey = builder.Configuration["Jwt:Key"];
var jwtIssuer = builder.Configuration["Jwt:Issuer"] ?? "TalentMatch.Api";
var jwtAudience = builder.Configuration["Jwt:Audience"] ?? "TalentMatch.Client";

if (string.IsNullOrWhiteSpace(jwtKey))
{
    throw new InvalidOperationException(
        "La configuraci?n Jwt:Key no est? definida. Configure una clave segura mediante user-secrets o variables de entorno.");
}

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = jwtIssuer,
        ValidAudience = jwtAudience,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey)),
        ClockSkew = TimeSpan.Zero
    };
});

var useRealServices = !builder.Environment.IsDevelopment()
    || builder.Configuration.GetValue<bool>("Persistence:UseRealServices");

if (builder.Environment.IsDevelopment() && !useRealServices)
{
    builder.Services.AddSingleton<IUsuarioService, DevUsuarioService>();
    builder.Services.AddSingleton<IEquipoService, DevEquipoService>();
}

builder.Services.AddAuthorization();

builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo { Title = "TalentMatch API", Version = "v1" });

    options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        Scheme = "Bearer",
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Description = "Ingrese: Bearer {token}"
    });

    options.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            new string[] { }
        }
    });
});

var app = builder.Build();

app.UseMiddleware<GlobalExceptionMiddleware>();

if (app.Environment.IsDevelopment()
    && useRealServices
    && builder.Configuration.GetValue<bool>("BootstrapAdmin:Enabled"))
{
    using var scope = app.Services.CreateScope();
    await scope.ServiceProvider.GetRequiredService<DevelopmentAdminInitializer>().InitializeAsync();
}

if (app.Environment.IsDevelopment()
    && useRealServices
    && builder.Configuration.GetValue<bool>("Persistence:SeedDevelopment"))
{
    await DatabaseSeeder.SeedAsync(app.Services, builder.Configuration);
}

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(options =>
    {
        options.SwaggerEndpoint("/swagger/v1/swagger.json", "TalentMatch API v1");
        options.RoutePrefix = "swagger";
    });
}

app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

// Iniciar Kestrel y mantener la aplicación activa mediante el ciclo de vida estándar.
// La configuración de Kestrel mantiene HTTP en http://127.0.0.1:5000.
await app.RunAsync();
