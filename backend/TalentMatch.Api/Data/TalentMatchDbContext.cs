using Microsoft.EntityFrameworkCore;
using TalentMatch.Api.Domain.Entities;

namespace TalentMatch.Api.Data;

public class TalentMatchDbContext : DbContext
{
    public TalentMatchDbContext(DbContextOptions<TalentMatchDbContext> options) : base(options)
    {
    }

    public DbSet<Usuario> Usuarios { get; set; }
    public DbSet<Estudiante> Estudiantes { get; set; }
    public DbSet<Profesor> Profesores { get; set; }
    public DbSet<Perfil> Perfiles { get; set; }
    public DbSet<Habilidad> Habilidades { get; set; }
    public DbSet<Interes> Intereses { get; set; }
    public DbSet<Proyecto> Proyectos { get; set; }
    public DbSet<Equipo> Equipos { get; set; }
    public DbSet<Postulacion> Postulaciones { get; set; }
    public DbSet<Recomendacion> Recomendaciones { get; set; }
    public DbSet<Notificacion> Notificaciones { get; set; }
    public DbSet<EstudianteHabilidad> EstudianteHabilidades { get; set; }
    public DbSet<EstudianteInteres> EstudianteIntereses { get; set; }
    public DbSet<ProyectoHabilidad> ProyectoHabilidades { get; set; }
    public DbSet<ProyectoInteres> ProyectoIntereses { get; set; }
    public DbSet<MiembroEquipo> MiembrosEquipo { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<Usuario>(entity =>
        {
            entity.HasKey(u => u.Id);
            entity.Property(u => u.Nombre).IsRequired().HasMaxLength(100);
            entity.Property(u => u.Apellido).IsRequired().HasMaxLength(100);
            entity.Property(u => u.Correo).IsRequired().HasMaxLength(200);
            entity.HasIndex(u => u.Correo).IsUnique();
            entity.Property(u => u.PasswordHash).IsRequired();
            entity.Property(u => u.Activo).HasDefaultValue(true);
        });

        modelBuilder.Entity<Estudiante>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.CodigoEstudiante).IsRequired().HasMaxLength(50);
            entity.Property(e => e.Carrera).IsRequired().HasMaxLength(200);
            entity.HasIndex(e => e.CodigoEstudiante).IsUnique();
            entity.HasOne(e => e.Usuario)
                .WithOne(u => u.Estudiante)
                .HasForeignKey<Estudiante>(e => e.UsuarioId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<Profesor>(entity =>
        {
            entity.HasKey(p => p.Id);
            entity.Property(p => p.CodigoProfesor).IsRequired().HasMaxLength(50);
            entity.Property(p => p.Facultad).IsRequired().HasMaxLength(200);
            entity.HasIndex(p => p.CodigoProfesor).IsUnique();
            entity.HasOne(p => p.Usuario)
                .WithOne(u => u.Profesor)
                .HasForeignKey<Profesor>(p => p.UsuarioId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<Perfil>(entity =>
        {
            entity.HasKey(p => p.Id);
            entity.HasOne(p => p.Usuario)
                .WithOne(u => u.Perfil)
                .HasForeignKey<Perfil>(p => p.UsuarioId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.Property(p => p.Descripcion).HasMaxLength(2000);
            entity.Property(p => p.Disponibilidad).HasMaxLength(200);
            entity.Property(p => p.FotoPerfil).HasMaxLength(500);
        });

        modelBuilder.Entity<Habilidad>(entity =>
        {
            entity.HasKey(h => h.Id);
            entity.Property(h => h.Nombre).IsRequired().HasMaxLength(100);
            entity.Property(h => h.Categoria).IsRequired().HasMaxLength(100);
            entity.HasIndex(h => h.Nombre).IsUnique();
        });

        modelBuilder.Entity<Interes>(entity =>
        {
            entity.HasKey(i => i.Id);
            entity.Property(i => i.Nombre).IsRequired().HasMaxLength(100);
            entity.HasIndex(i => i.Nombre).IsUnique();
        });

        modelBuilder.Entity<Proyecto>(entity =>
        {
            entity.HasKey(p => p.Id);
            entity.Property(p => p.Titulo).IsRequired().HasMaxLength(200);
            entity.Property(p => p.Descripcion).IsRequired().HasMaxLength(2000);
            entity.Property(p => p.FechaLimite).IsRequired();
            entity.Property(p => p.CuposDisponibles).IsRequired();
            entity.HasOne(p => p.Profesor)
                .WithMany(prof => prof.Proyectos)
                .HasForeignKey(p => p.ProfesorId)
                .OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<Equipo>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Nombre).IsRequired().HasMaxLength(200);
            entity.HasOne(e => e.Proyecto)
                .WithMany(p => p.Equipos)
                .HasForeignKey(e => e.ProyectoId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<Postulacion>(entity =>
        {
            entity.HasKey(p => p.Id);
            entity.Property(p => p.Mensaje).HasMaxLength(1000);
            entity.HasOne(p => p.Estudiante)
                .WithMany(e => e.Postulaciones)
                .HasForeignKey(p => p.EstudianteId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasOne(p => p.Proyecto)
                .WithMany(p => p.Postulaciones)
                .HasForeignKey(p => p.ProyectoId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasIndex(p => new { p.EstudianteId, p.ProyectoId }).IsUnique();
        });

        modelBuilder.Entity<Recomendacion>(entity =>
        {
            entity.HasKey(r => r.Id);
            entity.HasOne(r => r.Estudiante)
                .WithMany(e => e.Recomendaciones)
                .HasForeignKey(r => r.EstudianteId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasOne(r => r.Proyecto)
                .WithMany(p => p.Recomendaciones)
                .HasForeignKey(r => r.ProyectoId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.Property(r => r.PorcentajeCompatibilidad).HasColumnType("decimal(5,2)");
        });

        modelBuilder.Entity<Notificacion>(entity =>
        {
            entity.HasKey(n => n.Id);
            entity.Property(n => n.Titulo).IsRequired().HasMaxLength(200);
            entity.Property(n => n.Mensaje).IsRequired().HasMaxLength(1000);
            entity.Property(n => n.Tipo).IsRequired().HasMaxLength(50);
            entity.HasOne(n => n.Usuario)
                .WithMany(u => u.Notificaciones)
                .HasForeignKey(n => n.UsuarioId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<EstudianteHabilidad>(entity =>
        {
            entity.HasKey(eh => eh.Id);
            entity.HasOne(eh => eh.Estudiante)
                .WithMany(e => e.EstudianteHabilidades)
                .HasForeignKey(eh => eh.EstudianteId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasOne(eh => eh.Habilidad)
                .WithMany(h => h.Estudiantes)
                .HasForeignKey(eh => eh.HabilidadId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasIndex(eh => new { eh.EstudianteId, eh.HabilidadId }).IsUnique();
        });

        modelBuilder.Entity<EstudianteInteres>(entity =>
        {
            entity.HasKey(ei => ei.Id);
            entity.HasOne(ei => ei.Estudiante)
                .WithMany(e => e.EstudianteIntereses)
                .HasForeignKey(ei => ei.EstudianteId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasOne(ei => ei.Interes)
                .WithMany(i => i.Estudiantes)
                .HasForeignKey(ei => ei.InteresId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasIndex(ei => new { ei.EstudianteId, ei.InteresId }).IsUnique();
        });

        modelBuilder.Entity<ProyectoHabilidad>(entity =>
        {
            entity.HasKey(ph => ph.Id);
            entity.HasOne(ph => ph.Proyecto)
                .WithMany(p => p.ProyectoHabilidades)
                .HasForeignKey(ph => ph.ProyectoId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasOne(ph => ph.Habilidad)
                .WithMany(h => h.Proyectos)
                .HasForeignKey(ph => ph.HabilidadId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasIndex(ph => new { ph.ProyectoId, ph.HabilidadId }).IsUnique();
        });

        modelBuilder.Entity<ProyectoInteres>(entity =>
        {
            entity.HasKey(pi => pi.Id);
            entity.HasOne(pi => pi.Proyecto)
                .WithMany(p => p.ProyectoIntereses)
                .HasForeignKey(pi => pi.ProyectoId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasOne(pi => pi.Interes)
                .WithMany(i => i.Proyectos)
                .HasForeignKey(pi => pi.InteresId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasIndex(pi => new { pi.ProyectoId, pi.InteresId }).IsUnique();
        });

        modelBuilder.Entity<MiembroEquipo>(entity =>
        {
            entity.HasKey(me => me.Id);
            entity.HasOne(me => me.Equipo)
                .WithMany(e => e.Miembros)
                .HasForeignKey(me => me.EquipoId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasOne(me => me.Estudiante)
                .WithMany(e => e.MiembrosEquipo)
                .HasForeignKey(me => me.EstudianteId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasIndex(me => new { me.EquipoId, me.EstudianteId }).IsUnique();
        });
    }
}
