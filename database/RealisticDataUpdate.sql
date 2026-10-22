/*
 TalentMatchDB - datos ficticios realistas

 PRECAUCIONES:
 - Revisar este archivo antes de ejecutarlo.
 - No ejecutar desde Copilot.
 - No ejecutar DatabaseSeeder ni migraciones después.
 - No modifica IDs, correos, hashes, roles, Activo, fechas, estados, cupos ni claves foráneas.
 - El backup debe existir y verificarse antes de ejecutar.
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

/*
  PROCEDIMIENTO DE BACKUP — EJECUCIÓN MANUAL PREVIA, FUERA DE ESTE SCRIPT

  1. En una ventana administrativa de SQL Server, elegir una ruta local o de red
     aprobada y con espacio suficiente. No usar una ruta del equipo de Copilot.
  2. Ejecutar manualmente, sustituyendo la ruta:

     BACKUP DATABASE [TalentMatchDB]
     TO DISK = N'<RUTA_APROBADA>\TalentMatchDB_pre_RealisticDataUpdate.bak'
     WITH COPY_ONLY, INIT, CHECKSUM, STATS = 10;

  3. Verificar manualmente el backup:

     RESTORE VERIFYONLY
     FROM DISK = N'<RUTA_APROBADA>\TalentMatchDB_pre_RealisticDataUpdate.bak'
     WITH CHECKSUM;

  4. Registrar fecha, servidor, base de datos, tamaño y resultado de VERIFYONLY.
  5. No continuar si BACKUP o VERIFYONLY falla. Probar RESTORE en una base
     separada antes de aplicar cambios cuando el procedimiento operativo lo exija.

  Este bloque es documentación deliberadamente no ejecutable: el script de abajo
  solo transforma datos dentro de una transacción y no crea backups automáticamente.
*/

/* 0. Verificación de esquema y de la columna textual Notificaciones.Tipo. */
IF NOT EXISTS (
	SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = N'Notificaciones' AND COLUMN_NAME = N'Tipo'
	  AND DATA_TYPE = N'nvarchar' AND CHARACTER_MAXIMUM_LENGTH = 50
	  AND IS_NULLABLE = N'NO')
	THROW 52000, 'Notificaciones.Tipo no coincide con nvarchar(50) NOT NULL.', 1;

IF NOT EXISTS (
	SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = N'Usuarios' AND COLUMN_NAME = N'PasswordHash'
	  AND DATA_TYPE = N'nvarchar' AND IS_NULLABLE = N'NO')
	THROW 52001, 'El esquema de Usuarios no coincide con el contrato esperado.', 1;

IF OBJECT_ID(N'dbo.Usuarios', N'U') IS NULL
   OR OBJECT_ID(N'dbo.Estudiantes', N'U') IS NULL
   OR OBJECT_ID(N'dbo.Profesores', N'U') IS NULL
   OR OBJECT_ID(N'dbo.Perfiles', N'U') IS NULL
   OR OBJECT_ID(N'dbo.Habilidades', N'U') IS NULL
   OR OBJECT_ID(N'dbo.Intereses', N'U') IS NULL
   OR OBJECT_ID(N'dbo.Proyectos', N'U') IS NULL
   OR OBJECT_ID(N'dbo.Equipos', N'U') IS NULL
   OR OBJECT_ID(N'dbo.Postulaciones', N'U') IS NULL
   OR OBJECT_ID(N'dbo.Notificaciones', N'U') IS NULL
    THROW 52003, 'Falta una tabla requerida del esquema TalentMatchDB.', 1;

/* 1. Captura estable por identificadores originales. No se filtra por Rol. */
DROP TABLE IF EXISTS #Students;
DROP TABLE IF EXISTS #Professors;
DROP TABLE IF EXISTS #Users;
DROP TABLE IF EXISTS #Skills;
DROP TABLE IF EXISTS #Interests;
DROP TABLE IF EXISTS #Projects;
DROP TABLE IF EXISTS #Teams;
DROP TABLE IF EXISTS #Applications;
DROP TABLE IF EXISTS #Notifications;
DROP TABLE IF EXISTS #SharedProfessor;

SELECT e.Id AS StudentId, e.UsuarioId AS UserId,
	   ROW_NUMBER() OVER (ORDER BY e.Id) AS Position
INTO #Students
FROM Estudiantes e
WHERE e.CodigoEstudiante LIKE N'SEED-EST-%';

SELECT p.Id AS ProfessorId, p.UsuarioId AS UserId,
	   ROW_NUMBER() OVER (ORDER BY p.Id) AS Position
INTO #Professors
FROM Profesores p
WHERE p.CodigoProfesor LIKE N'SEED-PRO-%';

SELECT p.Id AS ProfessorId, p.UsuarioId AS UserId
INTO #SharedProfessor
FROM Profesores p
WHERE p.Id = 16
  AND p.UsuarioId = 2
  AND p.CodigoProfesor = N'PRO-000002';

SELECT DISTINCT UserId INTO #Users
FROM (
    SELECT UserId FROM #Students
    UNION ALL
    SELECT UserId FROM #Professors
    UNION ALL
    SELECT UserId FROM #SharedProfessor
) x;

SELECT Id AS SkillId, ROW_NUMBER() OVER (ORDER BY Id) AS Position
INTO #Skills FROM Habilidades WHERE Nombre LIKE N'C3-Habilidad-%';

SELECT Id AS InterestId, ROW_NUMBER() OVER (ORDER BY Id) AS Position
INTO #Interests FROM Intereses WHERE Nombre LIKE N'C3-Interes-%';

SELECT Id AS ProjectId, ProfesorId, ROW_NUMBER() OVER (ORDER BY Id) AS Position
INTO #Projects FROM Proyectos WHERE Titulo LIKE N'C3-Proyecto-%';

SELECT Id AS TeamId, ROW_NUMBER() OVER (ORDER BY Id) AS Position
INTO #Teams FROM Equipos WHERE Nombre LIKE N'C3-Equipo-%';

SELECT Id AS ApplicationId, ROW_NUMBER() OVER (ORDER BY Id) AS Position
INTO #Applications FROM Postulaciones WHERE Mensaje LIKE N'Postulación C3%';

SELECT Id AS NotificationId, ROW_NUMBER() OVER (ORDER BY Id) AS Position
INTO #Notifications FROM Notificaciones WHERE Titulo LIKE N'C3-Notificacion-%' ;

/* 2. Precondiciones e idempotencia. */
DECLARE @OriginalMarkers int =
    (SELECT COUNT(*) FROM Habilidades WHERE Nombre LIKE N'C3-Habilidad-%')
    + (SELECT COUNT(*) FROM Intereses WHERE Nombre LIKE N'C3-Interes-%')
    + (SELECT COUNT(*) FROM Proyectos WHERE Titulo LIKE N'C3-Proyecto-%')
    + (SELECT COUNT(*) FROM Equipos WHERE Nombre LIKE N'C3-Equipo-%')
    + (SELECT COUNT(*) FROM Notificaciones WHERE Titulo LIKE N'C3-Notificacion-%');

DECLARE @NewProjectTitles TABLE (Title nvarchar(200) PRIMARY KEY);
INSERT INTO @NewProjectTitles VALUES
(N'Analítica de permanencia estudiantil'),(N'Plataforma de seguimiento de proyectos universitarios'),(N'Asistente digital para orientación académica'),(N'Sistema de recomendación de oportunidades'),(N'Monitoreo de indicadores de sostenibilidad'),(N'Laboratorio de accesibilidad web'),(N'Clasificación de documentos académicos'),(N'Arquitectura de servicios para datos universitarios'),(N'Visualización de redes de colaboración'),(N'Aplicación móvil para equipos de proyecto'),(N'Calidad y gobierno de datos académicos'),(N'Predicción de demanda de asignaturas'),(N'Herramienta de apoyo a tutorías'),(N'Mapa de recursos académicos abiertos'),(N'Análisis de movilidad universitaria'),(N'Sistema de alertas para seguimiento estudiantil'),(N'Repositorio de evidencias de aprendizaje'),(N'Panel de indicadores de investigación'),(N'Participación en proyectos sociales'),(N'Clasificación de consultas académicas'),(N'Biblioteca digital accesible'),(N'Evaluación de experiencia en trámites'),(N'Inventario inteligente de laboratorios'),(N'Visualización de consumo energético'),(N'Reservas de espacios académicos'),(N'Análisis de comunidades de aprendizaje'),(N'Revisión de requisitos de software'),(N'Portal de divulgación científica'),(N'Trazabilidad de entregables'),(N'Priorización de iniciativas académicas'),(N'Servicio de mentorías universitarias'),(N'Seguimiento de prácticas profesionales'),(N'Participación en actividades formativas'),(N'Consulta de normativa académica'),(N'Tablero de coordinación docente'),(N'Automatización de reportes institucionales'),(N'Accesibilidad de contenidos digitales'),(N'Detección de datos incompletos'),(N'Formación universitaria híbrida'),(N'Indicadores de bienestar estudiantil'),(N'Agenda colaborativa de proyectos'),(N'Clasificación de recursos educativos'),(N'Plataforma de evaluación de proyectos'),(N'Experiencia de estudiantes nuevos'),(N'Demanda de espacios universitarios'),(N'Control de versiones documental'),(N'Comunicación para equipos académicos'),(N'Predicción de asistencia'),(N'Seguimiento de objetivos de aprendizaje'),(N'Aplicación para investigación colaborativa'),(N'Tendencias tecnológicas emergentes'),(N'Catálogo de capacidades estudiantiles'),(N'Gestión de convocatorias académicas'),(N'Visualización de resultados de encuestas'),(N'Documentación de APIs institucionales'),(N'Recomendación de recursos formativos'),(N'Colaboración interdisciplinar'),(N'Indicadores ambientales universitarios'),(N'Laboratorio remoto de aprendizaje'),(N'Evaluación de calidad de datos');

DECLARE @AppliedProjectTitles int =
    (SELECT COUNT(*) FROM Proyectos p INNER JOIN @NewProjectTitles n ON n.Title = p.Titulo);
DECLARE @AppliedTeams int =
    (SELECT COUNT(*) FROM Equipos WHERE Nombre LIKE N'Equipo %' AND Nombre LIKE N'%[0-9]');
DECLARE @AppliedNotifications int =
    (SELECT COUNT(*) FROM Notificaciones
     WHERE Tipo = N'Proyecto'
       AND Titulo IN (N'Actualización de proyecto', N'Nueva oportunidad académica', N'Revisión de postulación', N'Actividad de equipo', N'Recordatorio de participación'));

IF @OriginalMarkers = 0
   AND @AppliedProjectTitles = 60
   AND @AppliedTeams = 40
   AND @AppliedNotifications = 200
BEGIN
    PRINT 'La carga de datos realistas ya está aplicada. No se ejecutan escrituras.';
    RETURN;
END;

IF @OriginalMarkers = 0 OR @AppliedProjectTitles > 0 OR @AppliedTeams > 0 OR @AppliedNotifications > 0
    THROW 52006, 'Carga parcial, base no identificable o cambios posteriores detectados. No se modifica nada.', 1;

IF (SELECT COUNT(*) FROM #Students) <> 100
   OR (SELECT COUNT(*) FROM #Professors) <> 15
   OR (SELECT COUNT(*) FROM #Skills) <> 50
   OR (SELECT COUNT(*) FROM #Interests) <> 20
   OR (SELECT COUNT(*) FROM #Projects) <> 60
   OR (SELECT COUNT(*) FROM #Teams) <> 40
   OR (SELECT COUNT(*) FROM #Applications) <> 150
   OR (SELECT COUNT(*) FROM #Notifications) <> 200
    THROW 52002, 'La carga pendiente no coincide con los marcadores esperados; no se modifica nada.', 1;

IF NOT EXISTS (SELECT 1 FROM #Students WHERE UserId = 2 AND StudentId = 1)
    THROW 52003, 'No se conserva la relación esperada Usuario 2 / Estudiante 1.', 1;
IF (SELECT COUNT(*) FROM #SharedProfessor) <> 1
    THROW 52004, 'No se conserva la relación especial Usuario 2 / Profesor 16.', 1;
IF EXISTS (SELECT 1 FROM Usuarios WHERE Id = 2 AND (Rol <> 2 OR Correo <> N'seed.estudiante@talentmatch.local'))
    THROW 52005, 'El UsuarioId 2 no conserva su rol o correo.', 1;

/* 4. Conjuntos descriptivos. Las posiciones se relacionan con los IDs capturados. */
DECLARE @Names TABLE (Position int PRIMARY KEY, Nombre nvarchar(100), Apellido nvarchar(100), Carrera nvarchar(200), Descripcion nvarchar(2000), Disponibilidad nvarchar(200));
INSERT INTO @Names
SELECT
    ROW_NUMBER() OVER (ORDER BY f.Position, l.Position),
    f.Nombre,
    l.Apellido,
    CASE ((ROW_NUMBER() OVER (ORDER BY f.Position, l.Position) - 1) % 5) + 1
        WHEN 1 THEN N'Ingeniería de software'
        WHEN 2 THEN N'Ciencia de datos'
        WHEN 3 THEN N'Diseño digital'
        WHEN 4 THEN N'Ingeniería de sistemas'
        ELSE N'Tecnologías web'
    END,
    CASE ((ROW_NUMBER() OVER (ORDER BY f.Position, l.Position) - 1) % 6) + 1
        WHEN 1 THEN N'Interés en desarrollo web, diseño de APIs y calidad de software.'
        WHEN 2 THEN N'Orientado al análisis exploratorio y la visualización de información.'
        WHEN 3 THEN N'Experiencia académica en prototipado y experiencia de usuario.'
        WHEN 4 THEN N'Interés en bases de datos, integración de servicios y soporte de plataformas.'
        WHEN 5 THEN N'Enfocado en interfaces responsivas, accesibilidad y pruebas de usabilidad.'
        ELSE N'Interés en estadística aplicada y comunicación de resultados.'
    END,
    CASE ((ROW_NUMBER() OVER (ORDER BY f.Position, l.Position) - 1) % 8) + 1
        WHEN 1 THEN N'Mañanas entre semana'
        WHEN 2 THEN N'Tardes entre semana'
        WHEN 3 THEN N'Viernes y sábados'
        WHEN 4 THEN N'Fines de semana'
        WHEN 5 THEN N'Mañanas'
        WHEN 6 THEN N'Tardes'
        WHEN 7 THEN N'Noches'
        ELSE N'Horario flexible'
    END
FROM
(
    SELECT 1 AS Position, N'Valentina' AS Nombre UNION ALL SELECT 2, N'Mateo' UNION ALL SELECT 3, N'Camila' UNION ALL SELECT 4, N'Julián' UNION ALL SELECT 5, N'Sofía' UNION ALL SELECT 6, N'Emiliano' UNION ALL SELECT 7, N'Luciana' UNION ALL SELECT 8, N'Tomás' UNION ALL SELECT 9, N'Isabela' UNION ALL SELECT 10, N'Bruno' UNION ALL SELECT 11, N'Antonia' UNION ALL SELECT 12, N'Gabriel' UNION ALL SELECT 13, N'Martina' UNION ALL SELECT 14, N'Nicolás' UNION ALL SELECT 15, N'Elena' UNION ALL SELECT 16, N'Samuel' UNION ALL SELECT 17, N'Julieta' UNION ALL SELECT 18, N'Andrés' UNION ALL SELECT 19, N'Laura' UNION ALL SELECT 20, N'Felipe'
) f
CROSS JOIN
(
    SELECT 1 AS Position, N'Ríos' AS Apellido UNION ALL SELECT 2, N'Salcedo' UNION ALL SELECT 3, N'Navarro' UNION ALL SELECT 4, N'Mendoza' UNION ALL SELECT 5, N'Paredes'
) l;

IF (SELECT COUNT(*) FROM @Names) <> 100
    THROW 52022, 'El catálogo de nombres de estudiantes no contiene 100 combinaciones.', 1;

DECLARE @ProfNames TABLE (Position int PRIMARY KEY, Nombre nvarchar(100), Apellido nvarchar(100), Facultad nvarchar(200));
INSERT INTO @ProfNames VALUES
(1,N'Adriana',N'Miranda',N'Facultad de Ingeniería y Tecnología'),(2,N'Rafael',N'Velasco',N'Facultad de Ciencias Aplicadas'),(3,N'Elena',N'Bermúdez',N'Facultad de Diseño y Comunicación'),(4,N'Ignacio',N'Serrano',N'Facultad de Ingeniería y Tecnología'),(5,N'Mariana',N'Cortés',N'Facultad de Ciencias Aplicadas'),(6,N'Federico',N'Pinto',N'Facultad de Sistemas y Computación'),(7,N'Natalia',N'Robledo',N'Facultad de Diseño y Comunicación'),(8,N'Álvaro',N'Peña',N'Facultad de Ingeniería y Tecnología'),(9,N'Beatriz',N'Londoño',N'Facultad de Ciencias Aplicadas'),(10,N'Sergio',N'Valdés',N'Facultad de Sistemas y Computación'),(11,N'Claudia',N'Parra',N'Facultad de Diseño y Comunicación'),(12,N'Hernán',N'Ibáñez',N'Facultad de Ingeniería y Tecnología'),(13,N'Patricia',N'Roldán',N'Facultad de Ciencias Aplicadas'),(14,N'Mauricio',N'Correa',N'Facultad de Sistemas y Computación'),(15,N'Lorena',N'Buitrago',N'Facultad de Diseño y Comunicación');

/* 5. Validación de colisiones antes de abrir la transacción. */
IF EXISTS (SELECT 1 FROM @Names n INNER JOIN Usuarios u ON u.Nombre=n.Nombre AND u.Apellido=n.Apellido WHERE u.Id NOT IN (SELECT UserId FROM #Students))
	THROW 52007, 'Colisión de nombre de estudiante con un usuario no sintético.', 1;
IF EXISTS (SELECT 1 FROM @ProfNames n INNER JOIN Usuarios u ON u.Nombre=n.Nombre AND u.Apellido=n.Apellido WHERE u.Id NOT IN (SELECT UserId FROM #Professors))
	THROW 52008, 'Colisión de nombre de profesor con un usuario no sintético.', 1;
IF EXISTS (SELECT 1 FROM @NewProjectTitles n INNER JOIN Proyectos p ON p.Titulo=n.Title)
	THROW 52009, 'Colisión de título de proyecto.', 1;

/* 6. Las tablas temporales de asignación se crean antes de las validaciones que las usan. */
DECLARE @StudentMap TABLE (StudentId int PRIMARY KEY, UserId int UNIQUE, Position int UNIQUE);
INSERT INTO @StudentMap SELECT StudentId, UserId, Position FROM #Students;
DECLARE @ProfessorMap TABLE (ProfessorId int PRIMARY KEY, UserId int UNIQUE, Position int UNIQUE);
INSERT INTO @ProfessorMap SELECT ProfessorId, UserId, Position FROM #Professors;

DECLARE @StudentUserCount int = (SELECT COUNT(*) FROM @StudentMap);
DECLARE @ProfessorUserCount int = (SELECT COUNT(*) FROM @ProfessorMap);
DECLARE @SharedUserCount int = (
    SELECT COUNT(*) FROM @StudentMap s INNER JOIN @ProfessorMap p ON p.UserId = s.UserId
);
DECLARE @SharedProfessorCount int = (SELECT COUNT(*) FROM #SharedProfessor);
DECLARE @SharedStudentProfessorCount int = (
    SELECT COUNT(*) FROM @StudentMap s INNER JOIN #SharedProfessor p ON p.UserId = s.UserId
);
DECLARE @DistinctUserCount int = @StudentUserCount + @ProfessorUserCount + @SharedProfessorCount
    - @SharedUserCount - @SharedStudentProfessorCount;

BEGIN TRY
    BEGIN TRANSACTION;

    /* Comprobar que el conjunto aún está pendiente y conserva los valores del seeder. */
    IF EXISTS (SELECT 1 FROM Proyectos WHERE Titulo LIKE N'C3-Proyecto-%' AND Descripcion NOT LIKE N'Proyecto sintético % para pruebas de Development.')
        THROW 52010, 'Proyecto modificado manualmente; no se sobrescribe.', 1;
    IF EXISTS (SELECT 1 FROM Equipos WHERE Nombre LIKE N'C3-Equipo-%' AND ProyectoId IS NULL)
        THROW 52011, 'Equipo sintético sin relación válida.', 1;
    IF EXISTS (SELECT 1 FROM Postulaciones WHERE Mensaje LIKE N'Postulación C3%' AND (EstudianteId IS NULL OR ProyectoId IS NULL))
        THROW 52012, 'Postulación sintética inconsistente.', 1;
    IF (SELECT COUNT(*) FROM Usuarios u INNER JOIN @StudentMap s ON s.UserId = u.Id WHERE u.Nombre LIKE N'Estudiante%' AND u.Apellido = N'Sintético') <> @StudentUserCount
        THROW 52023, 'Hay estudiantes con cambios manuales o nombres no identificables.', 1;
    IF (SELECT COUNT(*) FROM Profesores p INNER JOIN @ProfessorMap x ON x.ProfessorId = p.Id WHERE p.Facultad LIKE N'Facultad de %') <> @ProfessorUserCount
        THROW 52024, 'Hay profesores con datos no identificables; no se sobrescriben.', 1;
    IF (SELECT COUNT(*) FROM Perfiles pf INNER JOIN @StudentMap s ON s.UserId = pf.UsuarioId WHERE pf.Descripcion LIKE N'Perfil C3 de estudiante sintético %') <> @StudentUserCount
        THROW 52025, 'Hay perfiles sintéticos ausentes o modificados manualmente.', 1;

    /* Cada UsuarioId, incluido el UsuarioId 2, se actualiza una sola vez.
       Cuando un usuario tiene ambas relaciones, prevalece su asignación de profesor
       porque conserva actualmente ese rol, sin modificar el rol ni las relaciones. */
    DECLARE @UserData TABLE (UserId int PRIMARY KEY, Nombre nvarchar(100), Apellido nvarchar(100));
    INSERT INTO @UserData (UserId, Nombre, Apellido)
    SELECT p.UserId, n.Nombre, n.Apellido
    FROM @ProfessorMap p
    INNER JOIN @ProfNames n ON n.Position = p.Position
    UNION ALL
    SELECT s.UserId, n.Nombre, n.Apellido
    FROM @StudentMap s
    INNER JOIN @Names n ON n.Position = s.Position
    WHERE NOT EXISTS (SELECT 1 FROM @ProfessorMap p WHERE p.UserId = s.UserId)
      AND NOT EXISTS (SELECT 1 FROM #SharedProfessor q WHERE q.UserId = s.UserId)
    UNION ALL
    SELECT UserId, N'Marcos', N'Arbeláez'
    FROM #SharedProfessor;

    IF (SELECT COUNT(*) FROM @UserData) <> @DistinctUserCount
        THROW 52026, 'El mapa de usuarios no es único o está incompleto.', 1;

    UPDATE u
    SET u.Nombre = d.Nombre, u.Apellido = d.Apellido
    FROM Usuarios u
    INNER JOIN @UserData d ON d.UserId = u.Id
    WHERE u.Nombre LIKE N'Estudiante%' OR u.Nombre LIKE N'Profesor%';
    IF @@ROWCOUNT <> @DistinctUserCount
        THROW 52027, 'La actualización de usuarios no afectó exactamente el conjunto deduplicado.', 1;

    UPDATE e SET e.Carrera=n.Carrera
    FROM Estudiantes e INNER JOIN @StudentMap s ON s.StudentId=e.Id INNER JOIN @Names n ON n.Position=s.Position;
    IF @@ROWCOUNT <> @StudentUserCount
        THROW 52028, 'La actualización de carreras no afectó el conjunto esperado.', 1;

    UPDATE p SET p.Facultad=n.Facultad
    FROM Profesores p INNER JOIN @ProfessorMap x ON x.ProfessorId=p.Id INNER JOIN @ProfNames n ON n.Position=x.Position;
    IF @@ROWCOUNT <> @ProfessorUserCount
        THROW 52029, 'La actualización de facultades no afectó el conjunto esperado.', 1;

    UPDATE pf SET pf.Descripcion=n.Descripcion, pf.Disponibilidad=n.Disponibilidad
    FROM Perfiles pf INNER JOIN @StudentMap s ON s.UserId=pf.UsuarioId INNER JOIN @Names n ON n.Position=s.Position
    WHERE pf.Descripcion LIKE N'Perfil C3 de estudiante sintético %';
    IF @@ROWCOUNT <> @StudentUserCount
        THROW 52030, 'La actualización de perfiles no afectó el conjunto esperado.', 1;

	/* Habilidades e intereses: destino real y JOIN por ID. */
	DECLARE @SkillData TABLE (Position int PRIMARY KEY, Nombre nvarchar(100), Categoria nvarchar(100));
	INSERT INTO @SkillData VALUES
	(1,N'Python',N'Datos'),(2,N'TypeScript',N'Frontend'),(3,N'React',N'Frontend'),(4,N'ASP.NET Core',N'Backend'),(5,N'SQL Server',N'Datos'),(6,N'Entity Framework Core',N'Backend'),(7,N'Diseño de APIs REST',N'Backend'),(8,N'Pruebas automatizadas',N'Backend'),(9,N'Git y control de versiones',N'Infraestructura'),(10,N'Docker',N'Infraestructura'),(11,N'Visualización de datos',N'Datos'),(12,N'Análisis estadístico',N'Datos'),(13,N'Machine learning',N'Datos'),(14,N'Power BI',N'Datos'),(15,N'Pandas',N'Datos'),(16,N'NumPy',N'Datos'),(17,N'Figma',N'Diseño'),(18,N'Investigación de usuarios',N'Diseño'),(19,N'Prototipado UX',N'Diseño'),(20,N'Accesibilidad web',N'Diseño'),(21,N'HTML y CSS',N'Frontend'),(22,N'Tailwind CSS',N'Frontend'),(23,N'Vite',N'Frontend'),(24,N'Node.js',N'Backend'),(25,N'Arquitectura de software',N'Backend'),(26,N'Modelado relacional',N'Datos'),(27,N'Optimización SQL',N'Datos'),(28,N'Seguridad web',N'Infraestructura'),(29,N'CI/CD',N'Infraestructura'),(30,N'Observabilidad',N'Infraestructura'),(31,N'Gestión de proyectos',N'Gestión'),(32,N'Metodologías ágiles',N'Gestión'),(33,N'Documentación técnica',N'Gestión'),(34,N'Comunicación científica',N'Gestión'),(35,N'Procesamiento de lenguaje natural',N'Datos'),(36,N'Visión por computador',N'Datos'),(37,N'Sistemas distribuidos',N'Backend'),(38,N'Microservicios',N'Backend'),(39,N'Azure',N'Infraestructura'),(40,N'Linux',N'Infraestructura'),(41,N'Kotlin',N'Frontend'),(42,N'Flutter',N'Frontend'),(43,N'Java',N'Backend'),(44,N'C#',N'Backend'),(45,N'Compiladores',N'Backend'),(46,N'Criptografía aplicada',N'Seguridad'),(47,N'Gestión de requisitos',N'Gestión'),(48,N'Calidad de datos',N'Datos'),(49,N'Visualización interactiva',N'Diseño'),(50,N'Diseño de servicios',N'Diseño');

	UPDATE h SET h.Nombre=d.Nombre, h.Categoria=d.Categoria
	FROM Habilidades h INNER JOIN #Skills s ON s.SkillId=h.Id INNER JOIN @SkillData d ON d.Position=s.Position;
    IF @@ROWCOUNT <> 50
        THROW 52031, 'La actualización de habilidades no afectó exactamente 50 filas.', 1;

	DECLARE @InterestData TABLE (Position int PRIMARY KEY, Nombre nvarchar(100));
	INSERT INTO @InterestData VALUES
	(1,N'Innovación educativa'),(2,N'Tecnología cívica'),(3,N'Salud digital'),(4,N'Sostenibilidad'),(5,N'Ciudades inteligentes'),(6,N'Analítica institucional'),(7,N'Inclusión digital'),(8,N'Emprendimiento tecnológico'),(9,N'Humanidades digitales'),(10,N'Accesibilidad'),(11,N'Automatización'),(12,N'Computación en la nube'),(13,N'Protección de datos'),(14,N'Visualización científica'),(15,N'Aprendizaje automático'),(16,N'Interacción persona-computador'),(17,N'Bibliotecas digitales'),(18,N'Energía sostenible'),(19,N'Movilidad urbana'),(20,N'Comunicación científica');

	UPDATE i SET i.Nombre=d.Nombre
	FROM Intereses i INNER JOIN #Interests x ON x.InterestId=i.Id INNER JOIN @InterestData d ON d.Position=x.Position;
    IF @@ROWCOUNT <> 20
        THROW 52032, 'La actualización de intereses no afectó exactamente 20 filas.', 1;

	/* Proyectos: títulos diferenciados; se conserva ProfesorId, Estado, fechas y cupos. */
	DECLARE @ProjectData TABLE (Position int PRIMARY KEY, Titulo nvarchar(200), Descripcion nvarchar(2000));
	INSERT INTO @ProjectData VALUES
	(1,N'Analítica de permanencia estudiantil',N'Diseño de un tablero de indicadores para analizar factores asociados a la permanencia y orientar acciones de acompañamiento académico.'),(2,N'Plataforma de seguimiento de proyectos universitarios',N'Construcción de una plataforma web para registrar avances, responsables, entregables y evidencias de proyectos académicos.'),(3,N'Asistente digital para orientación académica',N'Prototipo de asistente conversacional para facilitar consultas académicas con respuestas trazables y comprensibles.'),(4,N'Sistema de recomendación de oportunidades',N'Modelo de recomendación basado en habilidades e intereses para relacionar estudiantes con proyectos universitarios.'),(5,N'Monitoreo de indicadores de sostenibilidad',N'Solución de visualización y análisis para consolidar indicadores de consumo, movilidad y sostenibilidad institucional.'),(6,N'Laboratorio de accesibilidad web',N'Evaluación y mejora de interfaces digitales mediante criterios de accesibilidad y pruebas con usuarios.'),(7,N'Clasificación de documentos académicos',N'Aplicación de procesamiento de lenguaje natural para organizar documentos por temática y pertinencia.'),(8,N'Arquitectura de servicios para datos universitarios',N'Diseño de servicios REST seguros para integrar información de proyectos, perfiles y participación.'),(9,N'Visualización de redes de colaboración',N'Exploración visual de relaciones entre estudiantes, habilidades, intereses y proyectos mediante grafos interactivos.'),(10,N'Aplicación móvil para equipos de proyecto',N'Prototipo móvil para consultar tareas, integrantes, avances y notificaciones de equipos académicos.'),(11,N'Calidad y gobierno de datos académicos',N'Definición de reglas de validación, trazabilidad y control de calidad para información académica estructurada.'),(12,N'Predicción de demanda de asignaturas',N'Análisis de históricos académicos para estimar tendencias de demanda y apoyar la planificación de cursos.'),(13,N'Herramienta de apoyo a tutorías',N'Diseño de una herramienta para registrar sesiones de tutoría, compromisos y evolución de estudiantes.'),(14,N'Mapa de recursos académicos abiertos',N'Catálogo georreferenciado de recursos digitales y espacios de aprendizaje disponibles para la comunidad.'),(15,N'Análisis de movilidad universitaria',N'Visualización de patrones de movilidad para identificar oportunidades de transporte sostenible.'),(16,N'Sistema de alertas para seguimiento estudiantil',N'Prototipo de alertas basado en indicadores de participación y actividad académica.'),(17,N'Repositorio de evidencias de aprendizaje',N'Plataforma para organizar evidencias, entregables y reflexiones asociadas a resultados de aprendizaje.'),(18,N'Panel de indicadores de investigación',N'Diseño de un panel para consultar producción, colaboración y evolución de iniciativas de investigación.'),(19,N'Participación en proyectos sociales',N'Sistema de registro y análisis de participación estudiantil en iniciativas con impacto comunitario.'),(20,N'Clasificación de consultas académicas',N'Modelo para categorizar consultas frecuentes y facilitar la orientación a estudiantes.'),(21,N'Biblioteca digital accesible',N'Prototipo de biblioteca digital con navegación inclusiva, búsqueda y metadatos normalizados.'),(22,N'Evaluación de experiencia en trámites',N'Estudio de experiencia de usuario para identificar mejoras en procesos digitales universitarios.'),(23,N'Inventario inteligente de laboratorios',N'Sistema de control de equipos, disponibilidad, mantenimiento y reservas de laboratorios.'),(24,N'Visualización de consumo energético',N'Panel interactivo para analizar consumo energético y detectar patrones de ahorro.'),(25,N'Reservas de espacios académicos',N'Aplicación para consultar disponibilidad y gestionar reservas de espacios de trabajo y aprendizaje.'),(26,N'Análisis de comunidades de aprendizaje',N'Análisis de relaciones de colaboración para identificar comunidades y oportunidades de apoyo.'),(27,N'Revisión de requisitos de software',N'Método asistido para registrar, priorizar y validar requisitos de soluciones académicas.'),(28,N'Portal de divulgación científica',N'Portal para publicar resultados de investigación con navegación clara y visualizaciones comprensibles.'),(29,N'Trazabilidad de entregables',N'Herramienta para relacionar objetivos, tareas, responsables y evidencias durante un proyecto.'),(30,N'Priorización de iniciativas académicas',N'Modelo multicriterio para apoyar la selección transparente de iniciativas institucionales.'),(31,N'Servicio de mentorías universitarias',N'Plataforma para coordinar perfiles, disponibilidad y seguimiento de mentorías entre estudiantes.'),(32,N'Seguimiento de prácticas profesionales',N'Sistema para registrar objetivos, avances y retroalimentación durante prácticas profesionales.'),(33,N'Participación en actividades formativas',N'Análisis de participación en talleres y actividades para conocer tendencias de interés académico.'),(34,N'Consulta de normativa académica',N'Buscador estructurado para facilitar la consulta de reglamentos y procedimientos universitarios.'),(35,N'Tablero de coordinación docente',N'Panel para consolidar actividades, hitos y necesidades de coordinación entre docentes.'),(36,N'Automatización de reportes institucionales',N'Flujo automatizado para consolidar datos y generar reportes consistentes para seguimiento.'),(37,N'Accesibilidad de contenidos digitales',N'Auditoría de contenidos educativos digitales con recomendaciones de mejora y seguimiento.'),(38,N'Detección de datos incompletos',N'Modelo de reglas y alertas para identificar registros incompletos en conjuntos académicos.'),(39,N'Formación universitaria híbrida',N'Análisis de necesidades y diseño de recursos para mejorar experiencias formativas híbridas.'),(40,N'Indicadores de bienestar estudiantil',N'Visualización de indicadores agregados para apoyar acciones de bienestar y acompañamiento.'),(41,N'Agenda colaborativa de proyectos',N'Aplicación para coordinar reuniones, tareas y próximos hitos de equipos interdisciplinarios.'),(42,N'Clasificación de recursos educativos',N'Sistema para organizar materiales de aprendizaje por temática, nivel y formato.'),(43,N'Plataforma de evaluación de proyectos',N'Módulo para registrar criterios, evidencias y retroalimentación en la evaluación de proyectos.'),(44,N'Experiencia de estudiantes nuevos',N'Investigación y prototipo para mejorar la orientación de estudiantes durante su incorporación.'),(45,N'Demanda de espacios universitarios',N'Análisis de uso de aulas y espacios para apoyar decisiones de asignación y planificación.'),(46,N'Control de versiones documental',N'Flujo de trabajo para conservar historial, revisiones y responsables de documentos académicos.'),(47,N'Comunicación para equipos académicos',N'Prototipo de comunicación interna con avisos, acuerdos y seguimiento de actividades.'),(48,N'Predicción de asistencia',N'Modelo exploratorio para analizar factores relacionados con asistencia a actividades formativas.'),(49,N'Seguimiento de objetivos de aprendizaje',N'Panel para relacionar objetivos, actividades, evidencias y avances de aprendizaje.'),(50,N'Aplicación para investigación colaborativa',N'Plataforma para organizar participantes, documentos, tareas y resultados de investigación.'),(51,N'Tendencias tecnológicas emergentes',N'Análisis de fuentes y visualización de tendencias relevantes para proyectos académicos.'),(52,N'Catálogo de capacidades estudiantiles',N'Catálogo estructurado de habilidades, intereses y disponibilidad para facilitar colaboraciones.'),(53,N'Gestión de convocatorias académicas',N'Sistema para publicar, consultar y dar seguimiento a convocatorias y postulaciones.'),(54,N'Visualización de resultados de encuestas',N'Panel para explorar respuestas agregadas y detectar patrones en encuestas académicas.'),(55,N'Documentación de APIs institucionales',N'Repositorio para documentar endpoints, modelos de datos y ejemplos de integración.'),(56,N'Recomendación de recursos formativos',N'Modelo para sugerir recursos de aprendizaje según intereses y necesidades identificadas.'),(57,N'Colaboración interdisciplinar',N'Plataforma para conectar perfiles de distintas áreas alrededor de retos académicos comunes.'),(58,N'Indicadores ambientales universitarios',N'Sistema para consolidar y visualizar indicadores ambientales de forma periódica.'),(59,N'Laboratorio remoto de aprendizaje',N'Prototipo para facilitar prácticas remotas con recursos, instrucciones y seguimiento.'),(60,N'Evaluación de calidad de datos',N'Conjunto de reglas e indicadores para valorar completitud, consistencia y actualidad de datos académicos.');

	IF (SELECT COUNT(*) FROM @ProjectData) <> 60 THROW 52013, 'El catálogo de proyectos no contiene 60 filas.', 1;
	UPDATE p SET p.Titulo=d.Titulo, p.Descripcion=d.Descripcion
	FROM Proyectos p INNER JOIN #Projects x ON x.ProjectId=p.Id INNER JOIN @ProjectData d ON d.Position=x.Position;
    IF @@ROWCOUNT <> 60
        THROW 52033, 'La actualización de proyectos no afectó exactamente 60 filas.', 1;

	/* Equipos: se conservan ProyectoId, Estado y FechaCreacion. */
	UPDATE e SET e.Nombre = CONCAT(CASE ((x.Position-1)%8)+1 WHEN 1 THEN N'Equipo Analítica Aplicada' WHEN 2 THEN N'Equipo Producto Digital' WHEN 3 THEN N'Equipo Datos y Evidencia' WHEN 4 THEN N'Equipo Experiencia de Usuario' WHEN 5 THEN N'Equipo Integración de Servicios' WHEN 6 THEN N'Equipo Innovación Educativa' WHEN 7 THEN N'Equipo Visualización' ELSE N'Equipo Prototipado' END, N' ', CONVERT(nvarchar(10), x.Position))
	FROM Equipos e INNER JOIN #Teams x ON x.TeamId=e.Id;
    IF @@ROWCOUNT <> 40
        THROW 52034, 'La actualización de equipos no afectó exactamente 40 filas.', 1;

    UPDATE po SET po.Mensaje = CASE ((x.Position-1)%6)+1 WHEN 1 THEN N'Interés en desarrollo de software y trabajo colaborativo.' WHEN 2 THEN N'Interés en análisis de datos y comunicación de resultados.' WHEN 3 THEN N'Interés en diseño de interfaces y validación con usuarios.' WHEN 4 THEN N'Interés en bases de datos y servicios web.' WHEN 5 THEN N'Interés en investigación aplicada y documentación técnica.' ELSE N'Disponibilidad para aportar en prototipado, pruebas y seguimiento.' END
    FROM Postulaciones po INNER JOIN #Applications x ON x.ApplicationId=po.Id;
    IF @@ROWCOUNT <> 150
        THROW 52035, 'La actualización de postulaciones no afectó exactamente 150 filas.', 1;

    UPDATE no SET no.Titulo = CASE ((x.Position-1)%5)+1 WHEN 1 THEN N'Actualización de proyecto' WHEN 2 THEN N'Nueva oportunidad académica' WHEN 3 THEN N'Revisión de postulación' WHEN 4 THEN N'Actividad de equipo' ELSE N'Recordatorio de participación' END, no.Mensaje = CASE ((x.Position-1)%5)+1 WHEN 1 THEN N'Hay información nueva relacionada con uno de tus proyectos.' WHEN 2 THEN N'Se ha identificado una oportunidad relacionada con tu perfil.' WHEN 3 THEN N'Una postulación asociada requiere revisión o seguimiento.' WHEN 4 THEN N'El equipo de un proyecto tiene actividad reciente.' ELSE N'Revisa tus proyectos y próximas actividades en TalentMatch.' END, no.Tipo = N'Proyecto'
    FROM Notificaciones no INNER JOIN #Notifications x ON x.NotificationId=no.Id;
    IF @@ROWCOUNT <> 200
        THROW 52036, 'La actualización de notificaciones no afectó exactamente 200 filas.', 1;

	/* Validación de propiedades protegidas y de integridad. */
	IF EXISTS (SELECT 1 FROM Usuarios WHERE Id=2 AND (Rol<>2 OR Correo<>N'seed.estudiante@talentmatch.local')) THROW 52014, 'Se alteró la identidad protegida del Usuario 2.', 1;
	IF EXISTS (SELECT 1 FROM Proyectos p LEFT JOIN Profesores f ON f.Id=p.ProfesorId WHERE f.Id IS NULL) THROW 52015, 'Proyecto sin profesor válido.', 1;
	IF EXISTS (SELECT 1 FROM Equipos e LEFT JOIN Proyectos p ON p.Id=e.ProyectoId WHERE p.Id IS NULL) THROW 52016, 'Equipo sin proyecto válido.', 1;
	IF EXISTS (SELECT 1 FROM Postulaciones a LEFT JOIN Estudiantes s ON s.Id=a.EstudianteId LEFT JOIN Proyectos p ON p.Id=a.ProyectoId WHERE s.Id IS NULL OR p.Id IS NULL) THROW 52017, 'Postulación sin relación válida.', 1;
	IF EXISTS (SELECT Nombre FROM Habilidades GROUP BY Nombre HAVING COUNT(*)>1) THROW 52018, 'Nombres de habilidades duplicados.', 1;
	IF EXISTS (SELECT Nombre FROM Intereses GROUP BY Nombre HAVING COUNT(*)>1) THROW 52019, 'Nombres de intereses duplicados.', 1;
	IF EXISTS (SELECT Correo FROM Usuarios GROUP BY Correo HAVING COUNT(*)>1) THROW 52020, 'Correos duplicados.', 1;
	IF EXISTS (SELECT EstudianteId,ProyectoId FROM Postulaciones GROUP BY EstudianteId,ProyectoId HAVING COUNT(*)>1) THROW 52021, 'Postulaciones duplicadas.', 1;

	SELECT 'Usuarios sintéticos' AS Registro, COUNT(*) AS Filas FROM #Users
	UNION ALL SELECT 'Estudiantes', COUNT(*) FROM #Students
	UNION ALL SELECT 'Profesores SEED', COUNT(*) FROM #Professors
	UNION ALL SELECT 'Proyectos', COUNT(*) FROM #Projects
	UNION ALL SELECT 'Equipos', COUNT(*) FROM #Teams
	UNION ALL SELECT 'Postulaciones', COUNT(*) FROM #Applications
	UNION ALL SELECT 'Notificaciones', COUNT(*) FROM #Notifications;

	/* Para revisar antes de confirmar, sustituir COMMIT por ROLLBACK. */
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
	THROW;
END CATCH;
