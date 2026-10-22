/* Migration pendiente: no ejecutar desde Copilot.
   Requiere backup y revisión manual antes de aplicarse en TalentMatchDB. */

IF COL_LENGTH('dbo.Equipos', 'LiderEstudianteId') IS NULL
BEGIN
	ALTER TABLE dbo.Equipos
		ADD LiderEstudianteId INT NULL;
END;

IF OBJECT_ID('dbo.InvitacionesEquipo', 'U') IS NULL
BEGIN
	CREATE TABLE dbo.InvitacionesEquipo
	(
		Id INT IDENTITY(1,1) NOT NULL,
		EquipoId INT NOT NULL,
		RemitenteUsuarioId INT NOT NULL,
		DestinatarioUsuarioId INT NOT NULL,
		Mensaje NVARCHAR(1000) NULL,
		Estado INT NOT NULL CONSTRAINT DF_InvitacionesEquipo_Estado DEFAULT (1),
		FechaCreacion DATETIME2 NOT NULL CONSTRAINT DF_InvitacionesEquipo_FechaCreacion DEFAULT (SYSUTCDATETIME()),
		FechaRespuesta DATETIME2 NULL,
		CONSTRAINT PK_InvitacionesEquipo PRIMARY KEY (Id),
		CONSTRAINT FK_InvitacionesEquipo_Equipos FOREIGN KEY (EquipoId) REFERENCES dbo.Equipos(Id) ON DELETE CASCADE,
		CONSTRAINT FK_InvitacionesEquipo_Remitente FOREIGN KEY (RemitenteUsuarioId) REFERENCES dbo.Usuarios(Id),
		CONSTRAINT FK_InvitacionesEquipo_Destinatario FOREIGN KEY (DestinatarioUsuarioId) REFERENCES dbo.Usuarios(Id),
		CONSTRAINT CK_InvitacionesEquipo_Estado CHECK (Estado IN (1, 2, 3, 4))
	);
END;

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Equipos_Estudiantes_LiderEstudianteId')
BEGIN
	ALTER TABLE dbo.Equipos
		ADD CONSTRAINT FK_Equipos_Estudiantes_LiderEstudianteId
		FOREIGN KEY (LiderEstudianteId) REFERENCES dbo.Estudiantes(Id);
END;

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InvitacionesEquipo_Pendiente_Unica' AND object_id = OBJECT_ID('dbo.InvitacionesEquipo'))
BEGIN
	CREATE UNIQUE INDEX IX_InvitacionesEquipo_Pendiente_Unica
		ON dbo.InvitacionesEquipo (EquipoId, DestinatarioUsuarioId)
		WHERE Estado = 1;
END;

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InvitacionesEquipo_RemitenteUsuarioId' AND object_id = OBJECT_ID('dbo.InvitacionesEquipo'))
BEGIN
	CREATE INDEX IX_InvitacionesEquipo_RemitenteUsuarioId ON dbo.InvitacionesEquipo (RemitenteUsuarioId);
END;

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InvitacionesEquipo_DestinatarioUsuarioId' AND object_id = OBJECT_ID('dbo.InvitacionesEquipo'))
BEGIN
	CREATE INDEX IX_InvitacionesEquipo_DestinatarioUsuarioId ON dbo.InvitacionesEquipo (DestinatarioUsuarioId);
END;
