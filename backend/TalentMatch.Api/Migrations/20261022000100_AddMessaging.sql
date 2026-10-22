/*
  Migración preparada para Mensajes. No ejecutar automáticamente.
  Aplicar manualmente después de revisar el modelo EF y realizar backup.
  Este script es idempotente: no elimina ni sobrescribe tablas o datos existentes.
  Está separado de las migraciones EF Core registradas en el snapshot.
*/

IF OBJECT_ID(N'dbo.Conversaciones', N'U') IS NULL
BEGIN
	CREATE TABLE [dbo].[Conversaciones]
	(
		[Id] int IDENTITY(1,1) NOT NULL CONSTRAINT [PK_Conversaciones] PRIMARY KEY,
		[UsuarioAId] int NOT NULL,
		[UsuarioBId] int NOT NULL,
		[FechaCreacion] datetime2 NOT NULL,
		CONSTRAINT [CK_Conversaciones_Usuarios_Orden] CHECK ([UsuarioAId] < [UsuarioBId]),
		CONSTRAINT [FK_Conversaciones_Usuarios_UsuarioAId]
			FOREIGN KEY ([UsuarioAId]) REFERENCES [dbo].[Usuarios] ([Id]) ON DELETE NO ACTION,
		CONSTRAINT [FK_Conversaciones_Usuarios_UsuarioBId]
			FOREIGN KEY ([UsuarioBId]) REFERENCES [dbo].[Usuarios] ([Id]) ON DELETE NO ACTION
	);
END;

IF OBJECT_ID(N'dbo.Mensajes', N'U') IS NULL
BEGIN
	CREATE TABLE [dbo].[Mensajes]
	(
		[Id] int IDENTITY(1,1) NOT NULL CONSTRAINT [PK_Mensajes] PRIMARY KEY,
		[ConversacionId] int NOT NULL,
		[RemitenteId] int NOT NULL,
		[Contenido] nvarchar(2000) NOT NULL,
		[FechaEnvio] datetime2 NOT NULL,
		[Leido] bit NOT NULL,
		CONSTRAINT [FK_Mensajes_Conversaciones_ConversacionId]
			FOREIGN KEY ([ConversacionId]) REFERENCES [dbo].[Conversaciones] ([Id]) ON DELETE CASCADE,
		CONSTRAINT [FK_Mensajes_Usuarios_RemitenteId]
			FOREIGN KEY ([RemitenteId]) REFERENCES [dbo].[Usuarios] ([Id]) ON DELETE NO ACTION
	);
END;

IF OBJECT_ID(N'dbo.Conversaciones', N'U') IS NOT NULL
   AND NOT EXISTS
   (
	   SELECT 1
	   FROM sys.indexes
	   WHERE [name] = N'IX_Conversaciones_UsuarioAId_UsuarioBId'
		 AND [object_id] = OBJECT_ID(N'dbo.Conversaciones', N'U')
   )
BEGIN
	CREATE UNIQUE INDEX [IX_Conversaciones_UsuarioAId_UsuarioBId]
		ON [dbo].[Conversaciones] ([UsuarioAId], [UsuarioBId]);
END;

IF OBJECT_ID(N'dbo.Mensajes', N'U') IS NOT NULL
   AND NOT EXISTS
   (
	   SELECT 1
	   FROM sys.indexes
	   WHERE [name] = N'IX_Mensajes_ConversacionId'
		 AND [object_id] = OBJECT_ID(N'dbo.Mensajes', N'U')
   )
BEGIN
	CREATE INDEX [IX_Mensajes_ConversacionId]
		ON [dbo].[Mensajes] ([ConversacionId]);
END;

IF OBJECT_ID(N'dbo.Mensajes', N'U') IS NOT NULL
   AND NOT EXISTS
   (
	   SELECT 1
	   FROM sys.indexes
	   WHERE [name] = N'IX_Mensajes_RemitenteId'
		 AND [object_id] = OBJECT_ID(N'dbo.Mensajes', N'U')
   )
BEGIN
	CREATE INDEX [IX_Mensajes_RemitenteId]
		ON [dbo].[Mensajes] ([RemitenteId]);
END;
