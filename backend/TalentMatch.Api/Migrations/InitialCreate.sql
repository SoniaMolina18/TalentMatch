IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE TABLE [Habilidades] (
        [Id] int NOT NULL IDENTITY,
        [Nombre] nvarchar(100) NOT NULL,
        [Categoria] nvarchar(100) NOT NULL,
        CONSTRAINT [PK_Habilidades] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE TABLE [Intereses] (
        [Id] int NOT NULL IDENTITY,
        [Nombre] nvarchar(100) NOT NULL,
        CONSTRAINT [PK_Intereses] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE TABLE [Usuarios] (
        [Id] int NOT NULL IDENTITY,
        [Nombre] nvarchar(100) NOT NULL,
        [Apellido] nvarchar(100) NOT NULL,
        [Correo] nvarchar(200) NOT NULL,
        [PasswordHash] nvarchar(max) NOT NULL,
        [Rol] int NOT NULL,
        [Activo] bit NOT NULL DEFAULT CAST(1 AS bit),
        [FechaRegistro] datetime2 NOT NULL,
        CONSTRAINT [PK_Usuarios] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE TABLE [Estudiantes] (
        [Id] int NOT NULL IDENTITY,
        [UsuarioId] int NOT NULL,
        [CodigoEstudiante] nvarchar(50) NOT NULL,
        [Carrera] nvarchar(200) NOT NULL,
        [Semestre] int NOT NULL,
        CONSTRAINT [PK_Estudiantes] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Estudiantes_Usuarios_UsuarioId] FOREIGN KEY ([UsuarioId]) REFERENCES [Usuarios] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE TABLE [Notificaciones] (
        [Id] int NOT NULL IDENTITY,
        [UsuarioId] int NOT NULL,
        [Titulo] nvarchar(200) NOT NULL,
        [Mensaje] nvarchar(1000) NOT NULL,
        [Tipo] nvarchar(50) NOT NULL,
        [Leida] bit NOT NULL,
        [FechaCreacion] datetime2 NOT NULL,
        CONSTRAINT [PK_Notificaciones] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Notificaciones_Usuarios_UsuarioId] FOREIGN KEY ([UsuarioId]) REFERENCES [Usuarios] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE TABLE [Perfiles] (
        [Id] int NOT NULL IDENTITY,
        [UsuarioId] int NOT NULL,
        [Descripcion] nvarchar(2000) NULL,
        [Disponibilidad] nvarchar(200) NULL,
        [FotoPerfil] nvarchar(500) NULL,
        CONSTRAINT [PK_Perfiles] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Perfiles_Usuarios_UsuarioId] FOREIGN KEY ([UsuarioId]) REFERENCES [Usuarios] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE TABLE [Profesores] (
        [Id] int NOT NULL IDENTITY,
        [UsuarioId] int NOT NULL,
        [CodigoProfesor] nvarchar(50) NOT NULL,
        [Facultad] nvarchar(200) NOT NULL,
        CONSTRAINT [PK_Profesores] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Profesores_Usuarios_UsuarioId] FOREIGN KEY ([UsuarioId]) REFERENCES [Usuarios] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE TABLE [EstudianteHabilidades] (
        [Id] int NOT NULL IDENTITY,
        [EstudianteId] int NOT NULL,
        [HabilidadId] int NOT NULL,
        CONSTRAINT [PK_EstudianteHabilidades] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_EstudianteHabilidades_Estudiantes_EstudianteId] FOREIGN KEY ([EstudianteId]) REFERENCES [Estudiantes] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_EstudianteHabilidades_Habilidades_HabilidadId] FOREIGN KEY ([HabilidadId]) REFERENCES [Habilidades] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE TABLE [EstudianteIntereses] (
        [Id] int NOT NULL IDENTITY,
        [EstudianteId] int NOT NULL,
        [InteresId] int NOT NULL,
        CONSTRAINT [PK_EstudianteIntereses] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_EstudianteIntereses_Estudiantes_EstudianteId] FOREIGN KEY ([EstudianteId]) REFERENCES [Estudiantes] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_EstudianteIntereses_Intereses_InteresId] FOREIGN KEY ([InteresId]) REFERENCES [Intereses] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE TABLE [Proyectos] (
        [Id] int NOT NULL IDENTITY,
        [Titulo] nvarchar(200) NOT NULL,
        [Descripcion] nvarchar(2000) NOT NULL,
        [Estado] int NOT NULL,
        [FechaCreacion] datetime2 NOT NULL,
        [FechaLimite] datetime2 NOT NULL,
        [CuposDisponibles] int NOT NULL,
        [ProfesorId] int NOT NULL,
        CONSTRAINT [PK_Proyectos] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Proyectos_Profesores_ProfesorId] FOREIGN KEY ([ProfesorId]) REFERENCES [Profesores] ([Id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE TABLE [Equipos] (
        [Id] int NOT NULL IDENTITY,
        [Nombre] nvarchar(200) NOT NULL,
        [ProyectoId] int NOT NULL,
        [Estado] int NOT NULL,
        [FechaCreacion] datetime2 NOT NULL,
        CONSTRAINT [PK_Equipos] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Equipos_Proyectos_ProyectoId] FOREIGN KEY ([ProyectoId]) REFERENCES [Proyectos] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE TABLE [Postulaciones] (
        [Id] int NOT NULL IDENTITY,
        [EstudianteId] int NOT NULL,
        [ProyectoId] int NOT NULL,
        [Estado] int NOT NULL,
        [Mensaje] nvarchar(1000) NULL,
        [FechaPostulacion] datetime2 NOT NULL,
        CONSTRAINT [PK_Postulaciones] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Postulaciones_Estudiantes_EstudianteId] FOREIGN KEY ([EstudianteId]) REFERENCES [Estudiantes] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Postulaciones_Proyectos_ProyectoId] FOREIGN KEY ([ProyectoId]) REFERENCES [Proyectos] ([Id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE TABLE [ProyectoHabilidades] (
        [Id] int NOT NULL IDENTITY,
        [ProyectoId] int NOT NULL,
        [HabilidadId] int NOT NULL,
        CONSTRAINT [PK_ProyectoHabilidades] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ProyectoHabilidades_Habilidades_HabilidadId] FOREIGN KEY ([HabilidadId]) REFERENCES [Habilidades] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_ProyectoHabilidades_Proyectos_ProyectoId] FOREIGN KEY ([ProyectoId]) REFERENCES [Proyectos] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE TABLE [ProyectoIntereses] (
        [Id] int NOT NULL IDENTITY,
        [ProyectoId] int NOT NULL,
        [InteresId] int NOT NULL,
        CONSTRAINT [PK_ProyectoIntereses] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ProyectoIntereses_Intereses_InteresId] FOREIGN KEY ([InteresId]) REFERENCES [Intereses] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_ProyectoIntereses_Proyectos_ProyectoId] FOREIGN KEY ([ProyectoId]) REFERENCES [Proyectos] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE TABLE [Recomendaciones] (
        [Id] int NOT NULL IDENTITY,
        [EstudianteId] int NOT NULL,
        [ProyectoId] int NOT NULL,
        [PorcentajeCompatibilidad] decimal(5,2) NOT NULL,
        [FechaGeneracion] datetime2 NOT NULL,
        CONSTRAINT [PK_Recomendaciones] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Recomendaciones_Estudiantes_EstudianteId] FOREIGN KEY ([EstudianteId]) REFERENCES [Estudiantes] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Recomendaciones_Proyectos_ProyectoId] FOREIGN KEY ([ProyectoId]) REFERENCES [Proyectos] ([Id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE TABLE [MiembrosEquipo] (
        [Id] int NOT NULL IDENTITY,
        [EquipoId] int NOT NULL,
        [EstudianteId] int NOT NULL,
        [FechaIngreso] datetime2 NOT NULL,
        CONSTRAINT [PK_MiembrosEquipo] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_MiembrosEquipo_Equipos_EquipoId] FOREIGN KEY ([EquipoId]) REFERENCES [Equipos] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_MiembrosEquipo_Estudiantes_EstudianteId] FOREIGN KEY ([EstudianteId]) REFERENCES [Estudiantes] ([Id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_Equipos_ProyectoId] ON [Equipos] ([ProyectoId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_EstudianteHabilidades_EstudianteId_HabilidadId] ON [EstudianteHabilidades] ([EstudianteId], [HabilidadId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_EstudianteHabilidades_HabilidadId] ON [EstudianteHabilidades] ([HabilidadId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_EstudianteIntereses_EstudianteId_InteresId] ON [EstudianteIntereses] ([EstudianteId], [InteresId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_EstudianteIntereses_InteresId] ON [EstudianteIntereses] ([InteresId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_Estudiantes_CodigoEstudiante] ON [Estudiantes] ([CodigoEstudiante]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_Estudiantes_UsuarioId] ON [Estudiantes] ([UsuarioId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_Habilidades_Nombre] ON [Habilidades] ([Nombre]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_Intereses_Nombre] ON [Intereses] ([Nombre]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_MiembrosEquipo_EquipoId_EstudianteId] ON [MiembrosEquipo] ([EquipoId], [EstudianteId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_MiembrosEquipo_EstudianteId] ON [MiembrosEquipo] ([EstudianteId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_Notificaciones_UsuarioId] ON [Notificaciones] ([UsuarioId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_Perfiles_UsuarioId] ON [Perfiles] ([UsuarioId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_Postulaciones_EstudianteId_ProyectoId] ON [Postulaciones] ([EstudianteId], [ProyectoId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_Postulaciones_ProyectoId] ON [Postulaciones] ([ProyectoId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_Profesores_CodigoProfesor] ON [Profesores] ([CodigoProfesor]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_Profesores_UsuarioId] ON [Profesores] ([UsuarioId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_ProyectoHabilidades_HabilidadId] ON [ProyectoHabilidades] ([HabilidadId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_ProyectoHabilidades_ProyectoId_HabilidadId] ON [ProyectoHabilidades] ([ProyectoId], [HabilidadId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_ProyectoIntereses_InteresId] ON [ProyectoIntereses] ([InteresId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_ProyectoIntereses_ProyectoId_InteresId] ON [ProyectoIntereses] ([ProyectoId], [InteresId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_Proyectos_ProfesorId] ON [Proyectos] ([ProfesorId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_Recomendaciones_EstudianteId] ON [Recomendaciones] ([EstudianteId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_Recomendaciones_ProyectoId] ON [Recomendaciones] ([ProyectoId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_Usuarios_Correo] ON [Usuarios] ([Correo]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020212918_InitialCreate'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20261020212918_InitialCreate', N'8.0.8');
END;
GO

COMMIT;
GO

