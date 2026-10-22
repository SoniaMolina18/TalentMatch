/* Migración pendiente: no ejecutar desde Copilot.
   Requiere respaldo y revisión manual del esquema TalentMatchDB. */

IF COL_LENGTH('dbo.Proyectos', 'Tipo') IS NULL
BEGIN
	ALTER TABLE dbo.Proyectos
		ADD Tipo INT NOT NULL CONSTRAINT DF_Proyectos_Tipo DEFAULT (1);
END;

IF COL_LENGTH('dbo.Proyectos', 'CreadorEstudianteId') IS NULL
BEGIN
	ALTER TABLE dbo.Proyectos
		ADD CreadorEstudianteId INT NULL;
END;

IF COL_LENGTH('dbo.Proyectos', 'Objetivo') IS NULL
BEGIN
	ALTER TABLE dbo.Proyectos
		ADD Objetivo NVARCHAR(2000) NULL;
END;

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('dbo.Proyectos') AND name = 'ProfesorId' AND is_nullable = 0)
BEGIN
	ALTER TABLE dbo.Proyectos ALTER COLUMN ProfesorId INT NULL;
END;

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('dbo.Proyectos') AND name = 'FechaLimite' AND is_nullable = 0)
BEGIN
	ALTER TABLE dbo.Proyectos ALTER COLUMN FechaLimite DATETIME2 NULL;
END;

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Proyectos_Estudiantes_CreadorEstudianteId')
BEGIN
	ALTER TABLE dbo.Proyectos
		ADD CONSTRAINT FK_Proyectos_Estudiantes_CreadorEstudianteId
		FOREIGN KEY (CreadorEstudianteId) REFERENCES dbo.Estudiantes(Id);
END;

IF NOT EXISTS (SELECT 1 FROM sys.check_constraints WHERE name = 'CK_Proyectos_Tipo')
BEGIN
	ALTER TABLE dbo.Proyectos
		ADD CONSTRAINT CK_Proyectos_Tipo CHECK (Tipo IN (1, 2));
END;