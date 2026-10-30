USE [TalentMatchDB]
GO
/****** Objeto: Table [dbo].[__EFMigrationsHistory] Fecha de script: 22/10/2026 12:54:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Conversaciones] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conversaciones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioAId] [int] NOT NULL,
	[UsuarioBId] [int] NOT NULL,
	[FechaCreacion] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Conversaciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Equipos] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](200) NOT NULL,
	[ProyectoId] [int] NOT NULL,
	[Estado] [int] NOT NULL,
	[FechaCreacion] [datetime2](7) NOT NULL,
	[LiderEstudianteId] [int] NULL,
 CONSTRAINT [PK_Equipos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[EstudianteHabilidades] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstudianteHabilidades](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EstudianteId] [int] NOT NULL,
	[HabilidadId] [int] NOT NULL,
 CONSTRAINT [PK_EstudianteHabilidades] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[EstudianteIntereses] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstudianteIntereses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EstudianteId] [int] NOT NULL,
	[InteresId] [int] NOT NULL,
 CONSTRAINT [PK_EstudianteIntereses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Estudiantes] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estudiantes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioId] [int] NOT NULL,
	[CodigoEstudiante] [nvarchar](50) NOT NULL,
	[Carrera] [nvarchar](200) NOT NULL,
	[Semestre] [int] NOT NULL,
 CONSTRAINT [PK_Estudiantes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Habilidades] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Habilidades](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Categoria] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Habilidades] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Intereses] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Intereses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Intereses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[InvitacionesEquipo] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvitacionesEquipo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EquipoId] [int] NOT NULL,
	[RemitenteUsuarioId] [int] NOT NULL,
	[DestinatarioUsuarioId] [int] NOT NULL,
	[Mensaje] [nvarchar](1000) NULL,
	[Estado] [int] NOT NULL,
	[FechaCreacion] [datetime2](7) NOT NULL,
	[FechaRespuesta] [datetime2](7) NULL,
 CONSTRAINT [PK_InvitacionesEquipo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Mensajes] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mensajes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ConversacionId] [int] NOT NULL,
	[RemitenteId] [int] NOT NULL,
	[Contenido] [nvarchar](2000) NOT NULL,
	[FechaEnvio] [datetime2](7) NOT NULL,
	[Leido] [bit] NOT NULL,
 CONSTRAINT [PK_Mensajes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[MiembrosEquipo] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MiembrosEquipo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EquipoId] [int] NOT NULL,
	[EstudianteId] [int] NOT NULL,
	[FechaIngreso] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_MiembrosEquipo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Notificaciones] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notificaciones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioId] [int] NOT NULL,
	[Titulo] [nvarchar](200) NOT NULL,
	[Mensaje] [nvarchar](1000) NOT NULL,
	[Tipo] [nvarchar](50) NOT NULL,
	[Leida] [bit] NOT NULL,
	[FechaCreacion] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Notificaciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Perfiles] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfiles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioId] [int] NOT NULL,
	[Descripcion] [nvarchar](2000) NULL,
	[Disponibilidad] [nvarchar](200) NULL,
	[FotoPerfil] [nvarchar](500) NULL,
 CONSTRAINT [PK_Perfiles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Postulaciones] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Postulaciones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EstudianteId] [int] NOT NULL,
	[ProyectoId] [int] NOT NULL,
	[Estado] [int] NOT NULL,
	[Mensaje] [nvarchar](1000) NULL,
	[FechaPostulacion] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Postulaciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Profesores] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profesores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioId] [int] NOT NULL,
	[CodigoProfesor] [nvarchar](50) NOT NULL,
	[Facultad] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Profesores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ProyectoHabilidades] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProyectoHabilidades](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProyectoId] [int] NOT NULL,
	[HabilidadId] [int] NOT NULL,
 CONSTRAINT [PK_ProyectoHabilidades] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ProyectoIntereses] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProyectoIntereses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProyectoId] [int] NOT NULL,
	[InteresId] [int] NOT NULL,
 CONSTRAINT [PK_ProyectoIntereses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Proyectos] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proyectos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [nvarchar](200) NOT NULL,
	[Descripcion] [nvarchar](2000) NOT NULL,
	[Estado] [int] NOT NULL,
	[FechaCreacion] [datetime2](7) NOT NULL,
	[FechaLimite] [datetime2](7) NULL,
	[CuposDisponibles] [int] NOT NULL,
	[ProfesorId] [int] NULL,
	[Tipo] [int] NOT NULL,
	[CreadorEstudianteId] [int] NULL,
	[Objetivo] [nvarchar](2000) NULL,
 CONSTRAINT [PK_Proyectos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Recomendaciones] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recomendaciones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EstudianteId] [int] NOT NULL,
	[ProyectoId] [int] NOT NULL,
	[PorcentajeCompatibilidad] [decimal](5, 2) NOT NULL,
	[FechaGeneracion] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Recomendaciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Usuarios] Fecha de script: 22/10/2026 12:54:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Apellido] [nvarchar](100) NOT NULL,
	[Correo] [nvarchar](200) NOT NULL,
	[PasswordHash] [nvarchar](max) NOT NULL,
	[Rol] [int] NOT NULL,
	[Activo] [bit] NOT NULL,
	[FechaRegistro] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20261020212918_InitialCreate', N'8.0.8')
GO
SET IDENTITY_INSERT [dbo].[Conversaciones] ON 

INSERT [dbo].[Conversaciones] ([Id], [UsuarioAId], [UsuarioBId], [FechaCreacion]) VALUES (1, 43, 118, CAST(N'2026-10-22T13:08:17.2277643' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Conversaciones] OFF
GO
SET IDENTITY_INSERT [dbo].[Equipos] ON 

INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (1, N'Equipo Analítica para prevenir la deserción universitaria', 1, 1, CAST(N'2026-10-19T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (2, N'Equipo Portal de seguimiento de semilleros de investigación', 2, 2, CAST(N'2026-10-18T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (3, N'Equipo Asistente virtual de orientación académica', 3, 3, CAST(N'2026-10-17T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (4, N'Equipo Recomendador de oportunidades de aprendizaje', 4, 1, CAST(N'2026-10-16T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (5, N'Equipo Tablero de sostenibilidad de campus', 5, 2, CAST(N'2026-10-15T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (6, N'Equipo Auditoría de accesibilidad de portales educativos', 6, 3, CAST(N'2026-10-14T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (7, N'Equipo Clasificador de documentos académicos', 7, 1, CAST(N'2026-10-13T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (8, N'Equipo API de integración para información universitaria', 8, 2, CAST(N'2026-10-12T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (9, N'Equipo Mapa de redes de colaboración académica', 9, 3, CAST(N'2026-10-11T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (10, N'Equipo Aplicación móvil para seguimiento de equipos', 10, 1, CAST(N'2026-10-10T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (11, N'Equipo Modelo de calidad de datos de matrículas', 11, 2, CAST(N'2026-10-09T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (12, N'Equipo Pronóstico de demanda de asignaturas', 12, 3, CAST(N'2026-10-08T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (13, N'Equipo Plataforma de acompañamiento a tutorías', 13, 1, CAST(N'2026-10-07T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (14, N'Equipo Mapa interactivo de recursos educativos abiertos', 14, 2, CAST(N'2026-10-06T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (15, N'Equipo Análisis de rutas de movilidad estudiantil', 15, 3, CAST(N'2026-10-05T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (16, N'Equipo Alertas tempranas de riesgo académico', 16, 1, CAST(N'2026-10-04T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (17, N'Equipo Repositorio de evidencias de aprendizaje', 17, 2, CAST(N'2026-10-03T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (18, N'Equipo Indicadores de productividad investigativa', 18, 3, CAST(N'2026-10-02T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (19, N'Equipo Portal de proyectos con impacto comunitario', 19, 1, CAST(N'2026-10-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (20, N'Equipo Clasificación de consultas de estudiantes', 20, 2, CAST(N'2026-09-30T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (21, N'Equipo Biblioteca digital inclusiva', 21, 3, CAST(N'2026-09-29T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (22, N'Equipo Evaluación de experiencia de trámites académicos', 22, 1, CAST(N'2026-09-28T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (23, N'Equipo Inventario inteligente de laboratorios', 23, 2, CAST(N'2026-09-27T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (24, N'Equipo Monitoreo de consumo energético del campus', 24, 3, CAST(N'2026-09-26T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (25, N'Equipo Sistema de reservas de salas universitarias', 25, 1, CAST(N'2026-09-25T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (26, N'Equipo Análisis de comunidades de aprendizaje', 26, 2, CAST(N'2026-09-24T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (27, N'Equipo Validador automatizado de requisitos de software', 27, 3, CAST(N'2026-09-23T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (28, N'Equipo Portal de divulgación de proyectos científicos', 28, 1, CAST(N'2026-09-22T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (29, N'Equipo Trazabilidad de entregables en investigación', 29, 2, CAST(N'2026-09-21T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (30, N'Equipo Priorización de propuestas de innovación', 30, 3, CAST(N'2026-09-20T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (31, N'Equipo Servicio de acompañamiento a mentorías', 31, 1, CAST(N'2026-09-19T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (32, N'Equipo Control de prácticas y pasantías académicas', 32, 2, CAST(N'2026-09-18T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (33, N'Equipo Indicadores de participación estudiantil', 33, 3, CAST(N'2026-09-17T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (34, N'Equipo Buscador de normativa académica', 34, 1, CAST(N'2026-09-16T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (35, N'Equipo Panel de planificación para docentes', 35, 2, CAST(N'2026-09-15T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (36, N'Equipo Automatización de informes institucionales', 36, 3, CAST(N'2026-09-14T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (37, N'Equipo Accesibilidad de contenidos multimedia educativos', 37, 1, CAST(N'2026-09-13T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (38, N'Equipo Detección de inconsistencias en datos académicos', 38, 2, CAST(N'2026-09-12T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (39, N'Equipo Herramientas de aprendizaje híbrido', 39, 3, CAST(N'2026-09-11T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (40, N'Equipo Indicadores de bienestar y permanencia', 40, 1, CAST(N'2026-09-10T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Equipos] ([Id], [Nombre], [ProyectoId], [Estado], [FechaCreacion], [LiderEstudianteId]) VALUES (41, N'Dashboard inteligente para oportunidades académicas', 61, 1, CAST(N'2026-10-22T15:06:00.4814390' AS DateTime2), 101)
SET IDENTITY_INSERT [dbo].[Equipos] OFF
GO
SET IDENTITY_INSERT [dbo].[EstudianteHabilidades] ON 

INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (1, 1, 1)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (2, 1, 8)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (3, 2, 2)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (4, 2, 9)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (5, 3, 3)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (6, 3, 10)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (7, 4, 4)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (8, 4, 11)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (9, 5, 5)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (10, 5, 12)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (11, 6, 6)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (12, 6, 13)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (13, 7, 7)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (14, 7, 14)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (15, 8, 8)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (16, 8, 15)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (17, 9, 9)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (18, 9, 16)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (19, 10, 10)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (20, 10, 17)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (21, 11, 11)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (22, 11, 18)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (23, 12, 12)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (24, 12, 19)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (25, 13, 13)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (26, 13, 20)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (27, 14, 14)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (28, 14, 21)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (29, 15, 15)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (30, 15, 22)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (31, 16, 16)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (32, 16, 23)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (33, 17, 17)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (34, 17, 24)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (35, 18, 18)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (36, 18, 25)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (37, 19, 19)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (38, 19, 26)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (39, 20, 20)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (40, 20, 27)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (41, 21, 21)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (42, 21, 28)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (43, 22, 22)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (44, 22, 29)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (45, 23, 23)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (46, 23, 30)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (47, 24, 24)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (48, 24, 31)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (49, 25, 25)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (50, 25, 32)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (51, 26, 26)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (52, 26, 33)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (53, 27, 27)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (54, 27, 34)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (55, 28, 28)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (56, 28, 35)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (57, 29, 29)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (58, 29, 36)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (59, 30, 30)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (60, 30, 37)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (61, 31, 31)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (62, 31, 38)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (63, 32, 32)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (64, 32, 39)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (65, 33, 33)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (66, 33, 40)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (67, 34, 34)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (68, 34, 41)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (69, 35, 35)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (70, 35, 42)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (71, 36, 36)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (72, 36, 43)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (73, 37, 37)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (74, 37, 44)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (75, 38, 38)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (76, 38, 45)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (77, 39, 39)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (78, 39, 46)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (79, 40, 40)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (80, 40, 47)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (81, 41, 41)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (82, 41, 48)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (83, 42, 42)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (84, 42, 49)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (85, 43, 43)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (86, 43, 50)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (88, 44, 1)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (87, 44, 44)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (90, 45, 2)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (89, 45, 45)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (92, 46, 3)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (91, 46, 46)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (94, 47, 4)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (93, 47, 47)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (96, 48, 5)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (95, 48, 48)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (98, 49, 6)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (97, 49, 49)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (100, 50, 7)
GO
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (99, 50, 50)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (101, 51, 1)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (102, 51, 8)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (103, 52, 2)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (104, 52, 9)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (105, 53, 3)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (106, 53, 10)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (107, 54, 4)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (108, 54, 11)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (109, 55, 5)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (110, 55, 12)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (111, 56, 6)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (112, 56, 13)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (113, 57, 7)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (114, 57, 14)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (115, 58, 8)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (116, 58, 15)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (117, 59, 9)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (118, 59, 16)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (119, 60, 10)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (120, 60, 17)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (121, 61, 11)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (122, 61, 18)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (123, 62, 12)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (124, 62, 19)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (125, 63, 13)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (126, 63, 20)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (127, 64, 14)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (128, 64, 21)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (129, 65, 15)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (130, 65, 22)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (131, 66, 16)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (132, 66, 23)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (133, 67, 17)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (134, 67, 24)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (135, 68, 18)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (136, 68, 25)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (137, 69, 19)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (138, 69, 26)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (139, 70, 20)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (140, 70, 27)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (141, 71, 21)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (142, 71, 28)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (143, 72, 22)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (144, 72, 29)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (145, 73, 23)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (146, 73, 30)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (147, 74, 24)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (148, 74, 31)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (149, 75, 25)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (150, 75, 32)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (151, 76, 26)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (152, 76, 33)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (153, 77, 27)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (154, 77, 34)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (155, 78, 28)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (156, 78, 35)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (157, 79, 29)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (158, 79, 36)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (159, 80, 30)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (160, 80, 37)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (161, 81, 31)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (162, 81, 38)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (163, 82, 32)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (164, 82, 39)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (165, 83, 33)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (166, 83, 40)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (167, 84, 34)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (168, 84, 41)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (169, 85, 35)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (170, 85, 42)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (171, 86, 36)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (172, 86, 43)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (173, 87, 37)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (174, 87, 44)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (175, 88, 38)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (176, 88, 45)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (177, 89, 39)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (178, 89, 46)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (179, 90, 40)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (180, 90, 47)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (181, 91, 41)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (182, 91, 48)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (183, 92, 42)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (184, 92, 49)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (185, 93, 43)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (186, 93, 50)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (188, 94, 1)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (187, 94, 44)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (190, 95, 2)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (189, 95, 45)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (192, 96, 3)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (191, 96, 46)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (194, 97, 4)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (193, 97, 47)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (196, 98, 5)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (195, 98, 48)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (198, 99, 6)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (197, 99, 49)
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (200, 100, 7)
GO
INSERT [dbo].[EstudianteHabilidades] ([Id], [EstudianteId], [HabilidadId]) VALUES (199, 100, 50)
SET IDENTITY_INSERT [dbo].[EstudianteHabilidades] OFF
GO
SET IDENTITY_INSERT [dbo].[EstudianteIntereses] ON 

INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (1, 1, 1)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (2, 2, 2)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (3, 3, 3)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (4, 4, 4)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (5, 5, 5)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (6, 6, 6)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (7, 7, 7)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (8, 8, 8)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (9, 9, 9)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (10, 10, 10)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (11, 11, 11)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (12, 12, 12)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (13, 13, 13)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (14, 14, 14)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (15, 15, 15)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (16, 16, 16)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (17, 17, 17)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (18, 18, 18)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (19, 19, 19)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (20, 20, 20)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (21, 21, 1)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (22, 22, 2)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (23, 23, 3)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (24, 24, 4)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (25, 25, 5)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (26, 26, 6)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (27, 27, 7)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (28, 28, 8)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (29, 29, 9)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (30, 30, 10)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (31, 31, 11)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (32, 32, 12)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (33, 33, 13)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (34, 34, 14)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (35, 35, 15)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (36, 36, 16)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (37, 37, 17)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (38, 38, 18)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (39, 39, 19)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (40, 40, 20)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (41, 41, 1)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (42, 42, 2)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (43, 43, 3)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (44, 44, 4)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (45, 45, 5)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (46, 46, 6)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (47, 47, 7)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (48, 48, 8)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (49, 49, 9)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (50, 50, 10)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (51, 51, 11)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (52, 52, 12)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (53, 53, 13)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (54, 54, 14)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (55, 55, 15)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (56, 56, 16)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (57, 57, 17)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (58, 58, 18)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (59, 59, 19)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (60, 60, 20)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (61, 61, 1)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (62, 62, 2)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (63, 63, 3)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (64, 64, 4)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (65, 65, 5)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (66, 66, 6)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (67, 67, 7)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (68, 68, 8)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (69, 69, 9)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (70, 70, 10)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (71, 71, 11)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (72, 72, 12)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (73, 73, 13)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (74, 74, 14)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (75, 75, 15)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (76, 76, 16)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (77, 77, 17)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (78, 78, 18)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (79, 79, 19)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (80, 80, 20)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (81, 81, 1)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (82, 82, 2)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (83, 83, 3)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (84, 84, 4)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (85, 85, 5)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (86, 86, 6)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (87, 87, 7)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (88, 88, 8)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (89, 89, 9)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (90, 90, 10)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (91, 91, 11)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (92, 92, 12)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (93, 93, 13)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (94, 94, 14)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (95, 95, 15)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (96, 96, 16)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (97, 97, 17)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (98, 98, 18)
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (99, 99, 19)
GO
INSERT [dbo].[EstudianteIntereses] ([Id], [EstudianteId], [InteresId]) VALUES (100, 100, 20)
SET IDENTITY_INSERT [dbo].[EstudianteIntereses] OFF
GO
SET IDENTITY_INSERT [dbo].[Estudiantes] ON 

INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (1, 2, N'SEED-EST-000002', N'Ingeniería de sistemas', 2)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (2, 3, N'SEED-EST-002', N'Ciencia de datos', 3)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (3, 4, N'SEED-EST-003', N'Ingeniería de software', 4)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (4, 5, N'SEED-EST-004', N'Diseño digital', 5)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (5, 6, N'SEED-EST-005', N'Ingeniería informática', 6)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (6, 7, N'SEED-EST-006', N'Ingeniería de sistemas', 7)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (7, 8, N'SEED-EST-007', N'Ciencia de datos', 8)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (8, 9, N'SEED-EST-008', N'Ingeniería de software', 9)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (9, 10, N'SEED-EST-009', N'Diseño digital', 10)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (10, 11, N'SEED-EST-010', N'Ingeniería informática', 1)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (11, 12, N'SEED-EST-011', N'Ingeniería de sistemas', 2)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (12, 13, N'SEED-EST-012', N'Ciencia de datos', 3)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (13, 14, N'SEED-EST-013', N'Ingeniería de software', 4)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (14, 15, N'SEED-EST-014', N'Diseño digital', 5)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (15, 16, N'SEED-EST-015', N'Ingeniería informática', 6)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (16, 17, N'SEED-EST-016', N'Ingeniería de sistemas', 7)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (17, 18, N'SEED-EST-017', N'Ciencia de datos', 8)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (18, 19, N'SEED-EST-018', N'Ingeniería de software', 9)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (19, 20, N'SEED-EST-019', N'Diseño digital', 10)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (20, 21, N'SEED-EST-020', N'Ingeniería informática', 1)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (21, 22, N'SEED-EST-021', N'Ingeniería de sistemas', 2)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (22, 23, N'SEED-EST-022', N'Ciencia de datos', 3)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (23, 24, N'SEED-EST-023', N'Ingeniería de software', 4)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (24, 25, N'SEED-EST-024', N'Diseño digital', 5)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (25, 26, N'SEED-EST-025', N'Ingeniería informática', 6)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (26, 27, N'SEED-EST-026', N'Ingeniería de sistemas', 7)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (27, 28, N'SEED-EST-027', N'Ciencia de datos', 8)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (28, 29, N'SEED-EST-028', N'Ingeniería de software', 9)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (29, 30, N'SEED-EST-029', N'Diseño digital', 10)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (30, 31, N'SEED-EST-030', N'Ingeniería informática', 1)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (31, 32, N'SEED-EST-031', N'Ingeniería de sistemas', 2)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (32, 33, N'SEED-EST-032', N'Ciencia de datos', 3)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (33, 34, N'SEED-EST-033', N'Ingeniería de software', 4)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (34, 35, N'SEED-EST-034', N'Diseño digital', 5)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (35, 36, N'SEED-EST-035', N'Ingeniería informática', 6)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (36, 37, N'SEED-EST-036', N'Ingeniería de sistemas', 7)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (37, 38, N'SEED-EST-037', N'Ciencia de datos', 8)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (38, 39, N'SEED-EST-038', N'Ingeniería de software', 9)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (39, 40, N'SEED-EST-039', N'Diseño digital', 10)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (40, 41, N'SEED-EST-040', N'Ingeniería informática', 1)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (41, 42, N'SEED-EST-041', N'Ingeniería de sistemas', 2)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (42, 43, N'SEED-EST-042', N'Ciencia de datos', 3)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (43, 44, N'SEED-EST-043', N'Ingeniería de software', 4)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (44, 45, N'SEED-EST-044', N'Diseño digital', 5)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (45, 46, N'SEED-EST-045', N'Ingeniería informática', 6)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (46, 47, N'SEED-EST-046', N'Ingeniería de sistemas', 7)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (47, 48, N'SEED-EST-047', N'Ciencia de datos', 8)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (48, 49, N'SEED-EST-048', N'Ingeniería de software', 9)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (49, 50, N'SEED-EST-049', N'Diseño digital', 10)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (50, 51, N'SEED-EST-050', N'Ingeniería informática', 1)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (51, 52, N'SEED-EST-051', N'Ingeniería de sistemas', 2)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (52, 53, N'SEED-EST-052', N'Ciencia de datos', 3)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (53, 54, N'SEED-EST-053', N'Ingeniería de software', 4)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (54, 55, N'SEED-EST-054', N'Diseño digital', 5)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (55, 56, N'SEED-EST-055', N'Ingeniería informática', 6)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (56, 57, N'SEED-EST-056', N'Ingeniería de sistemas', 7)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (57, 58, N'SEED-EST-057', N'Ciencia de datos', 8)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (58, 59, N'SEED-EST-058', N'Ingeniería de software', 9)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (59, 60, N'SEED-EST-059', N'Diseño digital', 10)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (60, 61, N'SEED-EST-060', N'Ingeniería informática', 1)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (61, 62, N'SEED-EST-061', N'Ingeniería de sistemas', 2)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (62, 63, N'SEED-EST-062', N'Ciencia de datos', 3)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (63, 64, N'SEED-EST-063', N'Ingeniería de software', 4)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (64, 65, N'SEED-EST-064', N'Diseño digital', 5)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (65, 66, N'SEED-EST-065', N'Ingeniería informática', 6)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (66, 67, N'SEED-EST-066', N'Ingeniería de sistemas', 7)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (67, 68, N'SEED-EST-067', N'Ciencia de datos', 8)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (68, 69, N'SEED-EST-068', N'Ingeniería de software', 9)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (69, 70, N'SEED-EST-069', N'Diseño digital', 10)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (70, 71, N'SEED-EST-070', N'Ingeniería informática', 1)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (71, 72, N'SEED-EST-071', N'Ingeniería de sistemas', 2)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (72, 73, N'SEED-EST-072', N'Ciencia de datos', 3)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (73, 74, N'SEED-EST-073', N'Ingeniería de software', 4)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (74, 75, N'SEED-EST-074', N'Diseño digital', 5)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (75, 76, N'SEED-EST-075', N'Ingeniería informática', 6)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (76, 77, N'SEED-EST-076', N'Ingeniería de sistemas', 7)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (77, 78, N'SEED-EST-077', N'Ciencia de datos', 8)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (78, 79, N'SEED-EST-078', N'Ingeniería de software', 9)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (79, 80, N'SEED-EST-079', N'Diseño digital', 10)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (80, 81, N'SEED-EST-080', N'Ingeniería informática', 1)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (81, 82, N'SEED-EST-081', N'Ingeniería de sistemas', 2)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (82, 83, N'SEED-EST-082', N'Ciencia de datos', 3)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (83, 84, N'SEED-EST-083', N'Ingeniería de software', 4)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (84, 85, N'SEED-EST-084', N'Diseño digital', 5)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (85, 86, N'SEED-EST-085', N'Ingeniería informática', 6)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (86, 87, N'SEED-EST-086', N'Ingeniería de sistemas', 7)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (87, 88, N'SEED-EST-087', N'Ciencia de datos', 8)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (88, 89, N'SEED-EST-088', N'Ingeniería de software', 9)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (89, 90, N'SEED-EST-089', N'Diseño digital', 10)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (90, 91, N'SEED-EST-090', N'Ingeniería informática', 1)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (91, 92, N'SEED-EST-091', N'Ingeniería de sistemas', 2)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (92, 93, N'SEED-EST-092', N'Ciencia de datos', 3)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (93, 94, N'SEED-EST-093', N'Ingeniería de software', 4)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (94, 95, N'SEED-EST-094', N'Diseño digital', 5)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (95, 96, N'SEED-EST-095', N'Ingeniería informática', 6)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (96, 97, N'SEED-EST-096', N'Ingeniería de sistemas', 7)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (97, 98, N'SEED-EST-097', N'Ciencia de datos', 8)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (98, 99, N'SEED-EST-098', N'Ingeniería de software', 9)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (99, 100, N'SEED-EST-099', N'Diseño digital', 10)
GO
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (100, 101, N'SEED-EST-100', N'Ingeniería informática', 1)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (101, 117, N'EST-000117', N'No especificada', 1)
INSERT [dbo].[Estudiantes] ([Id], [UsuarioId], [CodigoEstudiante], [Carrera], [Semestre]) VALUES (102, 119, N'EST-000119', N'No especificada', 1)
SET IDENTITY_INSERT [dbo].[Estudiantes] OFF
GO
SET IDENTITY_INSERT [dbo].[Habilidades] ON 

INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (1, N'Python', N'Datos')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (2, N'TypeScript', N'Desarrollo web')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (3, N'React', N'Desarrollo web')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (4, N'ASP.NET Core', N'Desarrollo de software')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (5, N'SQL Server', N'Datos')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (6, N'Entity Framework Core', N'Desarrollo de software')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (7, N'Diseño de API REST', N'Desarrollo de software')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (8, N'Pruebas automatizadas', N'Calidad')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (9, N'Git', N'Herramientas')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (10, N'Docker', N'Infraestructura')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (11, N'Visualización de datos', N'Datos')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (12, N'Análisis estadístico', N'Datos')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (13, N'Aprendizaje automático', N'Inteligencia artificial')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (14, N'Power BI', N'Datos')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (15, N'Pandas', N'Datos')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (16, N'NumPy', N'Datos')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (17, N'Figma', N'Diseño')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (18, N'Investigación de usuarios', N'Diseño')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (19, N'Prototipado UX', N'Diseño')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (20, N'Accesibilidad web', N'Diseño')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (21, N'HTML y CSS', N'Desarrollo web')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (22, N'Tailwind CSS', N'Desarrollo web')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (23, N'Vite', N'Desarrollo web')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (24, N'Node.js', N'Desarrollo de software')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (25, N'Arquitectura de software', N'Desarrollo de software')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (26, N'Modelado relacional', N'Datos')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (27, N'Optimización SQL', N'Datos')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (28, N'Seguridad de aplicaciones', N'Seguridad')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (29, N'Integración continua', N'Infraestructura')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (30, N'Observabilidad', N'Infraestructura')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (31, N'Gestión de proyectos', N'Gestión')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (32, N'Metodologías ágiles', N'Gestión')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (33, N'Documentación técnica', N'Gestión')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (34, N'Comunicación científica', N'Investigación')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (35, N'Procesamiento de lenguaje natural', N'Inteligencia artificial')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (36, N'Visión por computador', N'Inteligencia artificial')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (37, N'Sistemas distribuidos', N'Desarrollo de software')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (38, N'Microservicios', N'Desarrollo de software')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (39, N'Azure', N'Infraestructura')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (40, N'Linux', N'Infraestructura')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (41, N'Kotlin', N'Desarrollo móvil')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (42, N'Flutter', N'Desarrollo móvil')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (43, N'Java', N'Desarrollo de software')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (44, N'C#', N'Desarrollo de software')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (45, N'Diseño de algoritmos', N'Desarrollo de software')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (46, N'Criptografía aplicada', N'Seguridad')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (47, N'Gestión de requisitos', N'Gestión')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (48, N'Calidad de datos', N'Datos')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (49, N'Visualización interactiva', N'Diseño')
INSERT [dbo].[Habilidades] ([Id], [Nombre], [Categoria]) VALUES (50, N'Diseño de servicios', N'Diseño')
SET IDENTITY_INSERT [dbo].[Habilidades] OFF
GO
SET IDENTITY_INSERT [dbo].[Intereses] ON 

INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (10, N'Accesibilidad')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (6, N'Analítica institucional')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (15, N'Aprendizaje automático')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (11, N'Automatización')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (17, N'Bibliotecas digitales')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (5, N'Ciudades inteligentes')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (12, N'Computación en la nube')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (20, N'Divulgación científica')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (8, N'Emprendimiento tecnológico')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (18, N'Energía sostenible')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (9, N'Humanidades digitales')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (7, N'Inclusión digital')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (1, N'Innovación educativa')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (16, N'Interacción persona-computador')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (19, N'Movilidad urbana')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (13, N'Protección de datos')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (3, N'Salud digital')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (4, N'Sostenibilidad')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (2, N'Tecnología cívica')
INSERT [dbo].[Intereses] ([Id], [Nombre]) VALUES (14, N'Visualización científica')
SET IDENTITY_INSERT [dbo].[Intereses] OFF
GO
SET IDENTITY_INSERT [dbo].[InvitacionesEquipo] ON 

INSERT [dbo].[InvitacionesEquipo] ([Id], [EquipoId], [RemitenteUsuarioId], [DestinatarioUsuarioId], [Mensaje], [Estado], [FechaCreacion], [FechaRespuesta]) VALUES (1, 41, 117, 119, NULL, 2, CAST(N'2026-10-22T15:25:19.7089716' AS DateTime2), CAST(N'2026-10-22T15:27:05.9558102' AS DateTime2))
SET IDENTITY_INSERT [dbo].[InvitacionesEquipo] OFF
GO
SET IDENTITY_INSERT [dbo].[MiembrosEquipo] ON 

INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (1, 1, 2, CAST(N'2026-10-20T23:00:36.8856236' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (2, 1, 3, CAST(N'2026-10-20T23:00:36.9001896' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (3, 1, 4, CAST(N'2026-10-20T23:00:36.9013718' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (4, 2, 3, CAST(N'2026-10-20T23:00:36.9023565' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (5, 2, 4, CAST(N'2026-10-20T23:00:36.9032996' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (6, 2, 5, CAST(N'2026-10-20T23:00:36.9041643' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (7, 3, 4, CAST(N'2026-10-20T23:00:36.9050573' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (8, 3, 5, CAST(N'2026-10-20T23:00:36.9059134' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (9, 3, 6, CAST(N'2026-10-20T23:00:36.9067957' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (10, 4, 5, CAST(N'2026-10-20T23:00:36.9076534' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (11, 4, 6, CAST(N'2026-10-20T23:00:36.9085114' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (12, 4, 7, CAST(N'2026-10-20T23:00:36.9093770' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (13, 5, 6, CAST(N'2026-10-20T23:00:36.9102427' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (14, 5, 7, CAST(N'2026-10-20T23:00:36.9111695' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (15, 5, 8, CAST(N'2026-10-20T23:00:36.9121207' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (16, 6, 7, CAST(N'2026-10-20T23:00:36.9130480' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (17, 6, 8, CAST(N'2026-10-20T23:00:36.9141511' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (18, 6, 9, CAST(N'2026-10-20T23:00:36.9152351' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (19, 7, 8, CAST(N'2026-10-20T23:00:36.9175182' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (20, 7, 9, CAST(N'2026-10-20T23:00:36.9191532' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (21, 7, 10, CAST(N'2026-10-20T23:00:36.9202845' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (22, 8, 9, CAST(N'2026-10-20T23:00:36.9214287' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (23, 8, 10, CAST(N'2026-10-20T23:00:36.9224092' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (24, 8, 11, CAST(N'2026-10-20T23:00:36.9234150' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (25, 9, 10, CAST(N'2026-10-20T23:00:36.9245135' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (26, 9, 11, CAST(N'2026-10-20T23:00:36.9254907' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (27, 9, 12, CAST(N'2026-10-20T23:00:36.9263118' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (28, 10, 11, CAST(N'2026-10-20T23:00:36.9272325' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (29, 10, 12, CAST(N'2026-10-20T23:00:36.9281801' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (30, 10, 13, CAST(N'2026-10-20T23:00:36.9301520' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (31, 11, 12, CAST(N'2026-10-20T23:00:36.9322041' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (32, 11, 13, CAST(N'2026-10-20T23:00:36.9347442' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (33, 11, 14, CAST(N'2026-10-20T23:00:36.9360395' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (34, 12, 13, CAST(N'2026-10-20T23:00:36.9373354' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (35, 12, 14, CAST(N'2026-10-20T23:00:36.9387178' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (36, 12, 15, CAST(N'2026-10-20T23:00:36.9396099' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (37, 13, 14, CAST(N'2026-10-20T23:00:36.9403387' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (38, 13, 15, CAST(N'2026-10-20T23:00:36.9410691' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (39, 13, 16, CAST(N'2026-10-20T23:00:36.9417496' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (40, 14, 15, CAST(N'2026-10-20T23:00:36.9425930' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (41, 14, 16, CAST(N'2026-10-20T23:00:36.9432726' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (42, 14, 17, CAST(N'2026-10-20T23:00:36.9438326' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (43, 15, 16, CAST(N'2026-10-20T23:00:36.9443890' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (44, 15, 17, CAST(N'2026-10-20T23:00:36.9448704' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (45, 15, 18, CAST(N'2026-10-20T23:00:36.9454963' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (46, 16, 17, CAST(N'2026-10-20T23:00:36.9461327' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (47, 16, 18, CAST(N'2026-10-20T23:00:36.9466637' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (48, 16, 19, CAST(N'2026-10-20T23:00:36.9471274' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (49, 17, 18, CAST(N'2026-10-20T23:00:36.9476408' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (50, 17, 19, CAST(N'2026-10-20T23:00:36.9482234' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (51, 17, 20, CAST(N'2026-10-20T23:00:36.9493449' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (52, 18, 19, CAST(N'2026-10-20T23:00:36.9504849' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (53, 18, 20, CAST(N'2026-10-20T23:00:36.9513131' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (54, 18, 21, CAST(N'2026-10-20T23:00:36.9519654' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (55, 19, 20, CAST(N'2026-10-20T23:00:36.9524903' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (56, 19, 21, CAST(N'2026-10-20T23:00:36.9531201' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (57, 19, 22, CAST(N'2026-10-20T23:00:36.9536961' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (58, 20, 21, CAST(N'2026-10-20T23:00:36.9543100' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (59, 20, 22, CAST(N'2026-10-20T23:00:36.9549974' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (60, 20, 23, CAST(N'2026-10-20T23:00:36.9555939' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (61, 21, 22, CAST(N'2026-10-20T23:00:36.9561949' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (62, 21, 23, CAST(N'2026-10-20T23:00:36.9568826' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (63, 21, 24, CAST(N'2026-10-20T23:00:36.9574363' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (64, 22, 23, CAST(N'2026-10-20T23:00:36.9580134' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (65, 22, 24, CAST(N'2026-10-20T23:00:36.9586443' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (66, 22, 25, CAST(N'2026-10-20T23:00:36.9593445' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (67, 23, 24, CAST(N'2026-10-20T23:00:36.9599713' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (68, 23, 25, CAST(N'2026-10-20T23:00:36.9604791' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (69, 23, 26, CAST(N'2026-10-20T23:00:36.9610105' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (70, 24, 25, CAST(N'2026-10-20T23:00:36.9616014' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (71, 24, 26, CAST(N'2026-10-20T23:00:36.9621261' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (72, 24, 27, CAST(N'2026-10-20T23:00:36.9626390' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (73, 25, 26, CAST(N'2026-10-20T23:00:36.9631286' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (74, 25, 27, CAST(N'2026-10-20T23:00:36.9636244' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (75, 25, 28, CAST(N'2026-10-20T23:00:36.9642193' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (76, 26, 27, CAST(N'2026-10-20T23:00:36.9649590' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (77, 26, 28, CAST(N'2026-10-20T23:00:36.9656681' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (78, 26, 29, CAST(N'2026-10-20T23:00:36.9665371' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (79, 27, 28, CAST(N'2026-10-20T23:00:36.9674949' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (80, 27, 29, CAST(N'2026-10-20T23:00:36.9680543' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (81, 27, 30, CAST(N'2026-10-20T23:00:36.9686803' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (82, 28, 29, CAST(N'2026-10-20T23:00:36.9692877' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (83, 28, 30, CAST(N'2026-10-20T23:00:36.9698628' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (84, 28, 31, CAST(N'2026-10-20T23:00:36.9704122' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (85, 29, 30, CAST(N'2026-10-20T23:00:36.9710281' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (86, 29, 31, CAST(N'2026-10-20T23:00:36.9716269' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (87, 29, 32, CAST(N'2026-10-20T23:00:36.9722239' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (88, 30, 31, CAST(N'2026-10-20T23:00:36.9727206' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (89, 30, 32, CAST(N'2026-10-20T23:00:36.9733043' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (90, 30, 33, CAST(N'2026-10-20T23:00:36.9739503' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (91, 31, 32, CAST(N'2026-10-20T23:00:36.9744776' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (92, 31, 33, CAST(N'2026-10-20T23:00:36.9749941' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (93, 31, 34, CAST(N'2026-10-20T23:00:36.9754805' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (94, 32, 33, CAST(N'2026-10-20T23:00:36.9759657' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (95, 32, 34, CAST(N'2026-10-20T23:00:36.9764732' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (96, 32, 35, CAST(N'2026-10-20T23:00:36.9770347' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (97, 33, 34, CAST(N'2026-10-20T23:00:36.9779810' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (98, 33, 35, CAST(N'2026-10-20T23:00:36.9787809' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (99, 33, 36, CAST(N'2026-10-20T23:00:36.9793675' AS DateTime2))
GO
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (100, 34, 35, CAST(N'2026-10-20T23:00:36.9799302' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (101, 34, 36, CAST(N'2026-10-20T23:00:36.9805902' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (102, 34, 37, CAST(N'2026-10-20T23:00:36.9811792' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (103, 35, 36, CAST(N'2026-10-20T23:00:36.9818051' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (104, 35, 37, CAST(N'2026-10-20T23:00:36.9827590' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (105, 35, 38, CAST(N'2026-10-20T23:00:36.9836177' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (106, 36, 37, CAST(N'2026-10-20T23:00:36.9842884' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (107, 36, 38, CAST(N'2026-10-20T23:00:36.9848798' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (108, 36, 39, CAST(N'2026-10-20T23:00:36.9853975' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (109, 37, 38, CAST(N'2026-10-20T23:00:36.9860844' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (110, 37, 39, CAST(N'2026-10-20T23:00:36.9867321' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (111, 37, 40, CAST(N'2026-10-20T23:00:36.9873760' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (112, 38, 39, CAST(N'2026-10-20T23:00:36.9880061' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (113, 38, 40, CAST(N'2026-10-20T23:00:36.9885353' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (114, 38, 41, CAST(N'2026-10-20T23:00:36.9890384' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (115, 39, 40, CAST(N'2026-10-20T23:00:36.9896061' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (116, 39, 41, CAST(N'2026-10-20T23:00:36.9901627' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (117, 39, 42, CAST(N'2026-10-20T23:00:36.9907546' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (118, 40, 41, CAST(N'2026-10-20T23:00:36.9915304' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (119, 40, 42, CAST(N'2026-10-20T23:00:36.9920542' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (120, 40, 43, CAST(N'2026-10-20T23:00:36.9925675' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (121, 41, 101, CAST(N'2026-10-22T15:06:00.5947846' AS DateTime2))
INSERT [dbo].[MiembrosEquipo] ([Id], [EquipoId], [EstudianteId], [FechaIngreso]) VALUES (122, 41, 102, CAST(N'2026-10-22T15:27:05.9558008' AS DateTime2))
SET IDENTITY_INSERT [dbo].[MiembrosEquipo] OFF
GO
SET IDENTITY_INSERT [dbo].[Notificaciones] ON 

INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (1, 2, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-10-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (2, 3, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-10-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (3, 4, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-10-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (4, 5, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-10-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (5, 6, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-10-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (6, 7, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-10-14T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (7, 8, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-10-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (8, 9, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-10-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (9, 10, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-10-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (10, 11, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-10-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (11, 12, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-10-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (12, 13, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-10-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (13, 14, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-10-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (14, 15, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-10-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (15, 16, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-10-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (16, 17, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-10-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (17, 18, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-10-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (18, 19, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-10-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (19, 20, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-10-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (20, 21, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-09-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (21, 22, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-09-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (22, 23, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-09-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (23, 24, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-09-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (24, 25, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-09-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (25, 26, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-09-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (26, 27, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-09-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (27, 28, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-09-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (28, 29, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-09-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (29, 30, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-09-21T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (30, 31, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-09-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (31, 32, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-09-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (32, 33, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-09-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (33, 34, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-09-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (34, 35, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-09-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (35, 36, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-09-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (36, 37, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-09-14T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (37, 38, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-09-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (38, 39, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-09-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (39, 40, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-09-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (40, 41, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-09-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (41, 42, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-09-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (42, 43, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-09-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (43, 44, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-09-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (44, 45, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-09-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (45, 46, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-09-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (46, 47, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-09-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (47, 48, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-09-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (48, 49, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-09-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (49, 50, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-09-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (50, 51, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-08-31T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (51, 52, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-08-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (52, 53, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-08-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (53, 54, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-08-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (54, 55, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-08-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (55, 56, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-08-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (56, 57, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-08-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (57, 58, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-08-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (58, 59, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-08-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (59, 60, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-08-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (60, 61, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-08-21T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (61, 62, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-08-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (62, 63, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-08-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (63, 64, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-08-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (64, 65, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-08-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (65, 66, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-08-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (66, 67, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-08-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (67, 68, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-08-14T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (68, 69, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-08-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (69, 70, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-08-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (70, 71, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-08-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (71, 72, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-08-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (72, 73, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-08-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (73, 74, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-08-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (74, 75, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-08-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (75, 76, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-08-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (76, 77, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-08-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (77, 78, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-08-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (78, 79, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-08-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (79, 80, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-08-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (80, 81, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-08-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (81, 82, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-07-31T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (82, 83, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-07-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (83, 84, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-07-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (84, 85, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-07-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (85, 86, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-07-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (86, 87, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-07-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (87, 88, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-07-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (88, 89, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-07-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (89, 90, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-07-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (90, 91, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-07-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (91, 92, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-07-21T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (92, 93, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-07-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (93, 94, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-07-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (94, 95, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-07-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (95, 96, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-07-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (96, 97, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-07-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (97, 98, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-07-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (98, 99, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-07-14T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (99, 100, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-07-13T00:00:00.0000000' AS DateTime2))
GO
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (100, 101, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-07-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (101, 102, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-07-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (102, 103, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-07-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (103, 104, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-07-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (104, 105, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-07-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (105, 106, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-07-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (106, 107, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-07-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (107, 108, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-07-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (108, 109, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-07-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (109, 110, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-07-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (110, 111, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-07-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (111, 112, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-07-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (112, 113, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-06-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (113, 114, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-06-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (114, 115, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-06-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (115, 116, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-06-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (116, 2, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-06-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (117, 3, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-06-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (118, 4, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-06-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (119, 5, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-06-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (120, 6, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-06-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (121, 7, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-06-21T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (122, 8, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-06-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (123, 9, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-06-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (124, 10, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-06-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (125, 11, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-06-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (126, 12, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-06-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (127, 13, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-06-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (128, 14, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-06-14T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (129, 15, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-06-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (130, 16, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-06-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (131, 17, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-06-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (132, 18, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-06-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (133, 19, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-06-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (134, 20, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-06-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (135, 21, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-06-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (136, 22, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-06-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (137, 23, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-06-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (138, 24, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-06-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (139, 25, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-06-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (140, 26, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-06-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (141, 27, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-06-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (142, 28, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-05-31T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (143, 29, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-05-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (144, 30, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-05-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (145, 31, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-05-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (146, 32, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-05-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (147, 33, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-05-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (148, 34, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-05-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (149, 35, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-05-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (150, 36, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-05-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (151, 37, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-05-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (152, 38, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-05-21T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (153, 39, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-05-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (154, 40, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-05-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (155, 41, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-05-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (156, 42, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-05-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (157, 43, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-05-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (158, 44, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-05-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (159, 45, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-05-14T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (160, 46, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-05-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (161, 47, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-05-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (162, 48, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-05-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (163, 49, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-05-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (164, 50, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-05-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (165, 51, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-05-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (166, 52, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-05-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (167, 53, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-05-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (168, 54, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-05-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (169, 55, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-05-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (170, 56, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-05-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (171, 57, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-05-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (172, 58, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-05-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (173, 59, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-04-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (174, 60, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-04-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (175, 61, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-04-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (176, 62, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-04-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (177, 63, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-04-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (178, 64, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-04-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (179, 65, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-04-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (180, 66, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-04-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (181, 67, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-04-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (182, 68, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-04-21T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (183, 69, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-04-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (184, 70, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-04-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (185, 71, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-04-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (186, 72, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-04-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (187, 73, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-04-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (188, 74, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-04-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (189, 75, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-04-14T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (190, 76, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-04-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (191, 77, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-04-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (192, 78, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-04-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (193, 79, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-04-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (194, 80, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-04-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (195, 81, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-04-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (196, 82, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-04-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (197, 83, N'Seguimiento de proyecto', N'Consulta las novedades de los proyectos de tu área académica.', N'Development', 0, CAST(N'2026-04-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (198, 84, N'Convocatoria académica', N'Hay oportunidades de participación relacionadas con tus intereses.', N'Development', 0, CAST(N'2026-04-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (199, 85, N'Actualización de postulación', N'Revisa el estado de tus postulaciones y los próximos pasos.', N'Development', 0, CAST(N'2026-04-04T00:00:00.0000000' AS DateTime2))
GO
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (200, 86, N'Actividad colaborativa', N'Conoce las actividades recientes de los equipos de investigación.', N'Development', 1, CAST(N'2026-04-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (201, 102, N'Nueva postulación', N'El estudiante yuliana mazabel se postuló a C3-Proyecto-001.', N'Postulacion', 0, CAST(N'2026-10-22T00:58:55.8813635' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (202, 106, N'Nueva postulación', N'El estudiante yuliana mazabel se postuló a Tablero de sostenibilidad de campus.', N'Postulacion', 0, CAST(N'2026-10-22T03:19:10.9923606' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (203, 119, N'Invitación a equipo', N'Has recibido una invitación para unirte al equipo Dashboard inteligente para oportunidades académicas.', N'InvitacionEquipo', 1, CAST(N'2026-10-22T15:25:19.7512694' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (204, 117, N'Invitación aceptada', N'El estudiante Tatiana Mazabel aceptó tu invitación.', N'InvitacionEquipo', 0, CAST(N'2026-10-22T15:27:05.9560286' AS DateTime2))
INSERT [dbo].[Notificaciones] ([Id], [UsuarioId], [Titulo], [Mensaje], [Tipo], [Leida], [FechaCreacion]) VALUES (205, 119, N'Postulación rechazada', N'Tu postulación al proyecto Dashboard inteligente para oportunidades académicas fue rechazada.', N'Postulacion', 0, CAST(N'2026-10-22T16:23:35.9391978' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Notificaciones] OFF
GO
SET IDENTITY_INSERT [dbo].[Perfiles] ON 

INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (1, 2, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (2, 3, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (3, 4, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (4, 5, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (5, 6, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (6, 7, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (7, 8, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (8, 9, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (9, 10, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (10, 11, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (11, 12, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (12, 13, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (13, 14, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (14, 15, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (15, 16, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (16, 17, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (17, 18, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (18, 19, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (19, 20, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (20, 21, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (21, 22, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (22, 23, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (23, 24, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (24, 25, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (25, 26, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (26, 27, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (27, 28, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (28, 29, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (29, 30, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (30, 31, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (31, 32, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (32, 33, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (33, 34, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (34, 35, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (35, 36, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (36, 37, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (37, 38, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (38, 39, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (39, 40, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (40, 41, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (41, 42, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (42, 43, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (43, 44, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (44, 45, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (45, 46, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (46, 47, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (47, 48, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (48, 49, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (49, 50, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (50, 51, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (51, 52, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (52, 53, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (53, 54, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (54, 55, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (55, 56, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (56, 57, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (57, 58, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (58, 59, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (59, 60, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (60, 61, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (61, 62, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (62, 63, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (63, 64, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (64, 65, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (65, 66, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (66, 67, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (67, 68, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (68, 69, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (69, 70, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (70, 71, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (71, 72, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (72, 73, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (73, 74, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (74, 75, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (75, 76, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (76, 77, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (77, 78, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (78, 79, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (79, 80, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (80, 81, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (81, 82, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (82, 83, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (83, 84, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (84, 85, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (85, 86, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (86, 87, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (87, 88, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (88, 89, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (89, 90, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (90, 91, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (91, 92, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (92, 93, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (93, 94, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (94, 95, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (95, 96, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (96, 97, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de sistemas. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (97, 98, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ciencia de datos. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Tardes entre semana', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (98, 99, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería de software. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Mañanas y sábados', NULL)
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (99, 100, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Diseño digital. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Fines de semana', NULL)
GO
INSERT [dbo].[Perfiles] ([Id], [UsuarioId], [Descripcion], [Disponibilidad], [FotoPerfil]) VALUES (100, 101, N'Estudiante interesado en proyectos de tecnología y trabajo interdisciplinario. Áreas destacadas: Ingeniería informática. Busca aplicar conocimientos en investigación, desarrollo y análisis de soluciones académicas.', N'Horario flexible', NULL)
SET IDENTITY_INSERT [dbo].[Perfiles] OFF
GO
SET IDENTITY_INSERT [dbo].[Postulaciones] ON 

INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (1, 1, 1, 1, N'Me interesa participar en «Analítica para prevenir la deserción universitaria». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (2, 2, 8, 2, N'Me interesa participar en «API de integración para información universitaria». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (3, 3, 15, 3, N'Me interesa participar en «Análisis de rutas de movilidad estudiantil». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (4, 4, 22, 1, N'Me interesa participar en «Evaluación de experiencia de trámites académicos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (5, 5, 29, 2, N'Me interesa participar en «Trazabilidad de entregables en investigación». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (6, 6, 36, 3, N'Me interesa participar en «Automatización de informes institucionales». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (7, 7, 43, 1, N'Me interesa participar en «Evaluación multicriterio de proyectos académicos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-14T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (8, 8, 50, 2, N'Me interesa participar en «Registro móvil de actividades de investigación». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (9, 9, 57, 3, N'Me interesa participar en «Red de colaboración interdisciplinaria». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (10, 10, 4, 1, N'Me interesa participar en «Recomendador de oportunidades de aprendizaje». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (11, 11, 11, 2, N'Me interesa participar en «Modelo de calidad de datos de matrículas». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (12, 12, 18, 3, N'Me interesa participar en «Indicadores de productividad investigativa». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (13, 13, 25, 1, N'Me interesa participar en «Sistema de reservas de salas universitarias». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (14, 14, 32, 2, N'Me interesa participar en «Control de prácticas y pasantías académicas». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (15, 15, 39, 3, N'Me interesa participar en «Herramientas de aprendizaje híbrido». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (16, 16, 46, 1, N'Me interesa participar en «Control de versiones de documentos académicos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (17, 17, 53, 2, N'Me interesa participar en «Gestor de convocatorias de investigación». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (18, 18, 60, 3, N'Me interesa participar en «Auditoría automatizada de calidad de datos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (19, 19, 7, 1, N'Me interesa participar en «Clasificador de documentos académicos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (20, 20, 14, 2, N'Me interesa participar en «Mapa interactivo de recursos educativos abiertos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-10-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (21, 21, 21, 3, N'Me interesa participar en «Biblioteca digital inclusiva». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (22, 22, 28, 1, N'Me interesa participar en «Portal de divulgación de proyectos científicos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (23, 23, 35, 2, N'Me interesa participar en «Panel de planificación para docentes». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (24, 24, 42, 3, N'Me interesa participar en «Clasificador de recursos de formación». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (25, 25, 49, 1, N'Me interesa participar en «Panel de metas para grupos estudiantiles». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (26, 26, 56, 2, N'Me interesa participar en «Recomendador de materiales de estudio». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (27, 27, 3, 3, N'Me interesa participar en «Asistente virtual de orientación académica». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (28, 28, 10, 1, N'Me interesa participar en «Aplicación móvil para seguimiento de equipos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (29, 29, 17, 2, N'Me interesa participar en «Repositorio de evidencias de aprendizaje». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (30, 30, 24, 3, N'Me interesa participar en «Monitoreo de consumo energético del campus». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-21T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (31, 31, 31, 1, N'Me interesa participar en «Servicio de acompañamiento a mentorías». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (32, 32, 38, 2, N'Me interesa participar en «Detección de inconsistencias en datos académicos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (33, 33, 45, 3, N'Me interesa participar en «Predicción de ocupación de espacios educativos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (34, 34, 52, 1, N'Me interesa participar en «Catálogo de competencias estudiantiles». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (35, 35, 59, 2, N'Me interesa participar en «Simulador remoto para prácticas de laboratorio». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (36, 36, 6, 3, N'Me interesa participar en «Auditoría de accesibilidad de portales educativos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (37, 37, 13, 1, N'Me interesa participar en «Plataforma de acompañamiento a tutorías». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-14T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (38, 38, 20, 2, N'Me interesa participar en «Clasificación de consultas de estudiantes». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (39, 39, 27, 3, N'Me interesa participar en «Validador automatizado de requisitos de software». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (40, 40, 34, 1, N'Me interesa participar en «Buscador de normativa académica». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (41, 41, 41, 2, N'Me interesa participar en «Agenda colaborativa para semilleros». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (42, 42, 48, 3, N'Me interesa participar en «Modelo predictivo de asistencia a clases». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (43, 43, 55, 1, N'Me interesa participar en «Portal de documentación de servicios API». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (44, 44, 2, 2, N'Me interesa participar en «Portal de seguimiento de semilleros de investigación». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (45, 45, 9, 3, N'Me interesa participar en «Mapa de redes de colaboración académica». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (46, 46, 16, 1, N'Me interesa participar en «Alertas tempranas de riesgo académico». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (47, 47, 23, 2, N'Me interesa participar en «Inventario inteligente de laboratorios». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (48, 48, 30, 3, N'Me interesa participar en «Priorización de propuestas de innovación». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (49, 49, 37, 1, N'Me interesa participar en «Accesibilidad de contenidos multimedia educativos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (50, 50, 44, 2, N'Me interesa participar en «Experiencia digital para nuevos estudiantes». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-09-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (51, 51, 51, 3, N'Me interesa participar en «Observatorio de tendencias tecnológicas». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-31T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (52, 52, 58, 1, N'Me interesa participar en «Control de indicadores ambientales universitarios». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (53, 53, 5, 2, N'Me interesa participar en «Tablero de sostenibilidad de campus». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (54, 54, 12, 3, N'Me interesa participar en «Pronóstico de demanda de asignaturas». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (55, 55, 19, 1, N'Me interesa participar en «Portal de proyectos con impacto comunitario». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (56, 56, 26, 2, N'Me interesa participar en «Análisis de comunidades de aprendizaje». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (57, 57, 33, 3, N'Me interesa participar en «Indicadores de participación estudiantil». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (58, 58, 40, 1, N'Me interesa participar en «Indicadores de bienestar y permanencia». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (59, 59, 47, 2, N'Me interesa participar en «Comunicación y seguimiento entre investigadores». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (60, 60, 54, 3, N'Me interesa participar en «Visualizador de encuestas institucionales». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (61, 61, 1, 1, N'Me interesa participar en «Analítica para prevenir la deserción universitaria». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-21T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (62, 62, 8, 2, N'Me interesa participar en «API de integración para información universitaria». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (63, 63, 15, 3, N'Me interesa participar en «Análisis de rutas de movilidad estudiantil». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (64, 64, 22, 1, N'Me interesa participar en «Evaluación de experiencia de trámites académicos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (65, 65, 29, 2, N'Me interesa participar en «Trazabilidad de entregables en investigación». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (66, 66, 36, 3, N'Me interesa participar en «Automatización de informes institucionales». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (67, 67, 43, 1, N'Me interesa participar en «Evaluación multicriterio de proyectos académicos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (68, 68, 50, 2, N'Me interesa participar en «Registro móvil de actividades de investigación». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-14T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (69, 69, 57, 3, N'Me interesa participar en «Red de colaboración interdisciplinaria». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (70, 70, 4, 1, N'Me interesa participar en «Recomendador de oportunidades de aprendizaje». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (71, 71, 11, 2, N'Me interesa participar en «Modelo de calidad de datos de matrículas». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (72, 72, 18, 3, N'Me interesa participar en «Indicadores de productividad investigativa». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (73, 73, 25, 1, N'Me interesa participar en «Sistema de reservas de salas universitarias». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (74, 74, 32, 2, N'Me interesa participar en «Control de prácticas y pasantías académicas». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (75, 75, 39, 3, N'Me interesa participar en «Herramientas de aprendizaje híbrido». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (76, 76, 46, 1, N'Me interesa participar en «Control de versiones de documentos académicos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (77, 77, 53, 2, N'Me interesa participar en «Gestor de convocatorias de investigación». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (78, 78, 60, 3, N'Me interesa participar en «Auditoría automatizada de calidad de datos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (79, 79, 7, 1, N'Me interesa participar en «Clasificador de documentos académicos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (80, 80, 14, 2, N'Me interesa participar en «Mapa interactivo de recursos educativos abiertos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (81, 81, 21, 3, N'Me interesa participar en «Biblioteca digital inclusiva». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-08-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (82, 82, 28, 1, N'Me interesa participar en «Portal de divulgación de proyectos científicos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-31T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (83, 83, 35, 2, N'Me interesa participar en «Panel de planificación para docentes». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (84, 84, 42, 3, N'Me interesa participar en «Clasificador de recursos de formación». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (85, 85, 49, 1, N'Me interesa participar en «Panel de metas para grupos estudiantiles». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (86, 86, 56, 2, N'Me interesa participar en «Recomendador de materiales de estudio». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (87, 87, 3, 3, N'Me interesa participar en «Asistente virtual de orientación académica». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (88, 88, 10, 1, N'Me interesa participar en «Aplicación móvil para seguimiento de equipos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (89, 89, 17, 2, N'Me interesa participar en «Repositorio de evidencias de aprendizaje». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (90, 90, 24, 3, N'Me interesa participar en «Monitoreo de consumo energético del campus». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (91, 91, 31, 1, N'Me interesa participar en «Servicio de acompañamiento a mentorías». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (92, 92, 38, 2, N'Me interesa participar en «Detección de inconsistencias en datos académicos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-21T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (93, 93, 45, 3, N'Me interesa participar en «Predicción de ocupación de espacios educativos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (94, 94, 52, 1, N'Me interesa participar en «Catálogo de competencias estudiantiles». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (95, 95, 59, 2, N'Me interesa participar en «Simulador remoto para prácticas de laboratorio». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (96, 96, 6, 3, N'Me interesa participar en «Auditoría de accesibilidad de portales educativos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (97, 97, 13, 1, N'Me interesa participar en «Plataforma de acompañamiento a tutorías». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (98, 98, 20, 2, N'Me interesa participar en «Clasificación de consultas de estudiantes». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (99, 99, 27, 3, N'Me interesa participar en «Validador automatizado de requisitos de software». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-14T00:00:00.0000000' AS DateTime2))
GO
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (100, 100, 34, 1, N'Me interesa participar en «Buscador de normativa académica». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (101, 1, 41, 2, N'Me interesa participar en «Agenda colaborativa para semilleros». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (102, 2, 48, 3, N'Me interesa participar en «Modelo predictivo de asistencia a clases». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (103, 3, 55, 1, N'Me interesa participar en «Portal de documentación de servicios API». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (104, 4, 2, 2, N'Me interesa participar en «Portal de seguimiento de semilleros de investigación». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (105, 5, 9, 3, N'Me interesa participar en «Mapa de redes de colaboración académica». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (106, 6, 16, 1, N'Me interesa participar en «Alertas tempranas de riesgo académico». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (107, 7, 23, 2, N'Me interesa participar en «Inventario inteligente de laboratorios». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (108, 8, 30, 3, N'Me interesa participar en «Priorización de propuestas de innovación». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (109, 9, 37, 1, N'Me interesa participar en «Accesibilidad de contenidos multimedia educativos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (110, 10, 44, 2, N'Me interesa participar en «Experiencia digital para nuevos estudiantes». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (111, 11, 51, 3, N'Me interesa participar en «Observatorio de tendencias tecnológicas». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (112, 12, 58, 1, N'Me interesa participar en «Control de indicadores ambientales universitarios». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-07-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (113, 13, 5, 2, N'Me interesa participar en «Tablero de sostenibilidad de campus». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (114, 14, 12, 3, N'Me interesa participar en «Pronóstico de demanda de asignaturas». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (115, 15, 19, 1, N'Me interesa participar en «Portal de proyectos con impacto comunitario». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (116, 16, 26, 2, N'Me interesa participar en «Análisis de comunidades de aprendizaje». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (117, 17, 33, 3, N'Me interesa participar en «Indicadores de participación estudiantil». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (118, 18, 40, 1, N'Me interesa participar en «Indicadores de bienestar y permanencia». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (119, 19, 47, 2, N'Me interesa participar en «Comunicación y seguimiento entre investigadores». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (120, 20, 54, 3, N'Me interesa participar en «Visualizador de encuestas institucionales». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (121, 21, 1, 1, N'Me interesa participar en «Analítica para prevenir la deserción universitaria». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (122, 22, 8, 2, N'Me interesa participar en «API de integración para información universitaria». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-21T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (123, 23, 15, 3, N'Me interesa participar en «Análisis de rutas de movilidad estudiantil». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (124, 24, 22, 1, N'Me interesa participar en «Evaluación de experiencia de trámites académicos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (125, 25, 29, 2, N'Me interesa participar en «Trazabilidad de entregables en investigación». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (126, 26, 36, 3, N'Me interesa participar en «Automatización de informes institucionales». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (127, 27, 43, 1, N'Me interesa participar en «Evaluación multicriterio de proyectos académicos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (128, 28, 50, 2, N'Me interesa participar en «Registro móvil de actividades de investigación». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (129, 29, 57, 3, N'Me interesa participar en «Red de colaboración interdisciplinaria». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-14T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (130, 30, 4, 1, N'Me interesa participar en «Recomendador de oportunidades de aprendizaje». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (131, 31, 11, 2, N'Me interesa participar en «Modelo de calidad de datos de matrículas». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (132, 32, 18, 3, N'Me interesa participar en «Indicadores de productividad investigativa». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (133, 33, 25, 1, N'Me interesa participar en «Sistema de reservas de salas universitarias». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (134, 34, 32, 2, N'Me interesa participar en «Control de prácticas y pasantías académicas». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (135, 35, 39, 3, N'Me interesa participar en «Herramientas de aprendizaje híbrido». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (136, 36, 46, 1, N'Me interesa participar en «Control de versiones de documentos académicos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (137, 37, 53, 2, N'Me interesa participar en «Gestor de convocatorias de investigación». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (138, 38, 60, 3, N'Me interesa participar en «Auditoría automatizada de calidad de datos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (139, 39, 7, 1, N'Me interesa participar en «Clasificador de documentos académicos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (140, 40, 14, 2, N'Me interesa participar en «Mapa interactivo de recursos educativos abiertos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (141, 41, 21, 3, N'Me interesa participar en «Biblioteca digital inclusiva». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (142, 42, 28, 1, N'Me interesa participar en «Portal de divulgación de proyectos científicos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-06-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (143, 43, 35, 2, N'Me interesa participar en «Panel de planificación para docentes». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-05-31T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (144, 44, 42, 3, N'Me interesa participar en «Clasificador de recursos de formación». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-05-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (145, 45, 49, 1, N'Me interesa participar en «Panel de metas para grupos estudiantiles». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-05-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (146, 46, 56, 2, N'Me interesa participar en «Recomendador de materiales de estudio». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-05-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (147, 47, 3, 3, N'Me interesa participar en «Asistente virtual de orientación académica». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-05-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (148, 48, 10, 1, N'Me interesa participar en «Aplicación móvil para seguimiento de equipos». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-05-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (149, 49, 17, 2, N'Me interesa participar en «Repositorio de evidencias de aprendizaje». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-05-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (150, 50, 24, 3, N'Me interesa participar en «Monitoreo de consumo energético del campus». Quiero aportar con mis conocimientos académicos, aprender de un equipo interdisciplinario y colaborar en el cumplimiento de sus entregables.', CAST(N'2026-05-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (151, 101, 1, 1, N'ahahhah', CAST(N'2026-10-22T00:58:55.7988488' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (152, 101, 5, 1, N'quiero entrar a este proyecto', CAST(N'2026-10-22T03:19:10.6742177' AS DateTime2))
INSERT [dbo].[Postulaciones] ([Id], [EstudianteId], [ProyectoId], [Estado], [Mensaje], [FechaPostulacion]) VALUES (153, 102, 61, 3, NULL, CAST(N'2026-10-22T15:20:49.7153302' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Postulaciones] OFF
GO
SET IDENTITY_INSERT [dbo].[Profesores] ON 

INSERT [dbo].[Profesores] ([Id], [UsuarioId], [CodigoProfesor], [Facultad]) VALUES (1, 102, N'SEED-PRO-000102', N'Ingeniería y Tecnología')
INSERT [dbo].[Profesores] ([Id], [UsuarioId], [CodigoProfesor], [Facultad]) VALUES (2, 103, N'SEED-PRO-002', N'Ciencias Aplicadas')
INSERT [dbo].[Profesores] ([Id], [UsuarioId], [CodigoProfesor], [Facultad]) VALUES (3, 104, N'SEED-PRO-003', N'Diseño y Comunicación')
INSERT [dbo].[Profesores] ([Id], [UsuarioId], [CodigoProfesor], [Facultad]) VALUES (4, 105, N'SEED-PRO-004', N'Ingeniería y Tecnología')
INSERT [dbo].[Profesores] ([Id], [UsuarioId], [CodigoProfesor], [Facultad]) VALUES (5, 106, N'SEED-PRO-005', N'Ciencias Aplicadas')
INSERT [dbo].[Profesores] ([Id], [UsuarioId], [CodigoProfesor], [Facultad]) VALUES (6, 107, N'SEED-PRO-006', N'Sistemas y Computación')
INSERT [dbo].[Profesores] ([Id], [UsuarioId], [CodigoProfesor], [Facultad]) VALUES (7, 108, N'SEED-PRO-007', N'Diseño y Comunicación')
INSERT [dbo].[Profesores] ([Id], [UsuarioId], [CodigoProfesor], [Facultad]) VALUES (8, 109, N'SEED-PRO-008', N'Ingeniería y Tecnología')
INSERT [dbo].[Profesores] ([Id], [UsuarioId], [CodigoProfesor], [Facultad]) VALUES (9, 110, N'SEED-PRO-009', N'Ciencias Aplicadas')
INSERT [dbo].[Profesores] ([Id], [UsuarioId], [CodigoProfesor], [Facultad]) VALUES (10, 111, N'SEED-PRO-010', N'Sistemas y Computación')
INSERT [dbo].[Profesores] ([Id], [UsuarioId], [CodigoProfesor], [Facultad]) VALUES (11, 112, N'SEED-PRO-011', N'Diseño y Comunicación')
INSERT [dbo].[Profesores] ([Id], [UsuarioId], [CodigoProfesor], [Facultad]) VALUES (12, 113, N'SEED-PRO-012', N'Ingeniería y Tecnología')
INSERT [dbo].[Profesores] ([Id], [UsuarioId], [CodigoProfesor], [Facultad]) VALUES (13, 114, N'SEED-PRO-013', N'Ciencias Aplicadas')
INSERT [dbo].[Profesores] ([Id], [UsuarioId], [CodigoProfesor], [Facultad]) VALUES (14, 115, N'SEED-PRO-014', N'Sistemas y Computación')
INSERT [dbo].[Profesores] ([Id], [UsuarioId], [CodigoProfesor], [Facultad]) VALUES (15, 116, N'SEED-PRO-015', N'Diseño y Comunicación')
INSERT [dbo].[Profesores] ([Id], [UsuarioId], [CodigoProfesor], [Facultad]) VALUES (16, 2, N'PRO-000002', N'No especificada')
INSERT [dbo].[Profesores] ([Id], [UsuarioId], [CodigoProfesor], [Facultad]) VALUES (1016, 118, N'PRO-000118', N'No especificada')
SET IDENTITY_INSERT [dbo].[Profesores] OFF
GO
SET IDENTITY_INSERT [dbo].[ProyectoHabilidades] ON 

INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (1, 1, 1)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (2, 1, 13)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (3, 2, 2)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (4, 2, 14)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (5, 3, 3)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (6, 3, 15)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (7, 4, 4)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (8, 4, 16)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (9, 5, 5)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (10, 5, 17)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (11, 6, 6)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (12, 6, 18)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (13, 7, 7)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (14, 7, 19)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (15, 8, 8)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (16, 8, 20)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (17, 9, 9)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (18, 9, 21)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (19, 10, 10)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (20, 10, 22)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (21, 11, 11)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (22, 11, 23)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (23, 12, 12)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (24, 12, 24)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (25, 13, 13)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (26, 13, 25)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (27, 14, 14)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (28, 14, 26)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (29, 15, 15)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (30, 15, 27)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (31, 16, 16)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (32, 16, 28)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (33, 17, 17)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (34, 17, 29)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (35, 18, 18)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (36, 18, 30)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (37, 19, 19)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (38, 19, 31)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (39, 20, 20)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (40, 20, 32)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (41, 21, 21)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (42, 21, 33)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (43, 22, 22)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (44, 22, 34)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (45, 23, 23)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (46, 23, 35)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (47, 24, 24)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (48, 24, 36)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (49, 25, 25)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (50, 25, 37)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (51, 26, 26)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (52, 26, 38)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (53, 27, 27)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (54, 27, 39)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (55, 28, 28)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (56, 28, 40)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (57, 29, 29)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (58, 29, 41)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (59, 30, 30)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (60, 30, 42)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (61, 31, 31)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (62, 31, 43)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (63, 32, 32)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (64, 32, 44)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (65, 33, 33)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (66, 33, 45)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (67, 34, 34)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (68, 34, 46)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (69, 35, 35)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (70, 35, 47)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (71, 36, 36)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (72, 36, 48)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (73, 37, 37)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (74, 37, 49)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (75, 38, 38)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (76, 38, 50)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (78, 39, 1)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (77, 39, 39)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (80, 40, 2)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (79, 40, 40)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (82, 41, 3)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (81, 41, 41)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (84, 42, 4)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (83, 42, 42)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (86, 43, 5)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (85, 43, 43)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (88, 44, 6)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (87, 44, 44)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (90, 45, 7)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (89, 45, 45)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (92, 46, 8)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (91, 46, 46)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (94, 47, 9)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (93, 47, 47)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (96, 48, 10)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (95, 48, 48)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (98, 49, 11)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (97, 49, 49)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (100, 50, 12)
GO
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (99, 50, 50)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (101, 51, 1)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (102, 51, 13)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (103, 52, 2)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (104, 52, 14)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (105, 53, 3)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (106, 53, 15)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (107, 54, 4)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (108, 54, 16)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (109, 55, 5)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (110, 55, 17)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (111, 56, 6)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (112, 56, 18)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (113, 57, 7)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (114, 57, 19)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (115, 58, 8)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (116, 58, 20)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (117, 59, 9)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (118, 59, 21)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (119, 60, 10)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (120, 60, 22)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (122, 61, 11)
INSERT [dbo].[ProyectoHabilidades] ([Id], [ProyectoId], [HabilidadId]) VALUES (121, 61, 14)
SET IDENTITY_INSERT [dbo].[ProyectoHabilidades] OFF
GO
SET IDENTITY_INSERT [dbo].[ProyectoIntereses] ON 

INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (1, 1, 1)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (2, 2, 2)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (3, 3, 3)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (4, 4, 4)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (5, 5, 5)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (6, 6, 6)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (7, 7, 7)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (8, 8, 8)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (9, 9, 9)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (10, 10, 10)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (11, 11, 11)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (12, 12, 12)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (13, 13, 13)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (14, 14, 14)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (15, 15, 15)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (16, 16, 16)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (17, 17, 17)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (18, 18, 18)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (19, 19, 19)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (20, 20, 20)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (21, 21, 1)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (22, 22, 2)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (23, 23, 3)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (24, 24, 4)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (25, 25, 5)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (26, 26, 6)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (27, 27, 7)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (28, 28, 8)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (29, 29, 9)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (30, 30, 10)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (31, 31, 11)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (32, 32, 12)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (33, 33, 13)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (34, 34, 14)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (35, 35, 15)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (36, 36, 16)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (37, 37, 17)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (38, 38, 18)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (39, 39, 19)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (40, 40, 20)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (41, 41, 1)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (42, 42, 2)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (43, 43, 3)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (44, 44, 4)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (45, 45, 5)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (46, 46, 6)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (47, 47, 7)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (48, 48, 8)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (49, 49, 9)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (50, 50, 10)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (51, 51, 11)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (52, 52, 12)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (53, 53, 13)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (54, 54, 14)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (55, 55, 15)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (56, 56, 16)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (57, 57, 17)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (58, 58, 18)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (59, 59, 19)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (60, 60, 20)
INSERT [dbo].[ProyectoIntereses] ([Id], [ProyectoId], [InteresId]) VALUES (61, 61, 6)
SET IDENTITY_INSERT [dbo].[ProyectoIntereses] OFF
GO
SET IDENTITY_INSERT [dbo].[Proyectos] ON 

INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (1, N'Analítica para prevenir la deserción universitaria', N'El proyecto busca diseñar y validar una solución de analítica para prevenir la deserción universitaria mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 1, CAST(N'2026-10-19T00:00:00.0000000' AS DateTime2), CAST(N'2026-11-20T00:00:00.0000000' AS DateTime2), 4, 1, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (2, N'Portal de seguimiento de semilleros de investigación', N'El proyecto busca diseñar y validar una solución de portal de seguimiento de semilleros de investigación mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 2, CAST(N'2026-10-18T00:00:00.0000000' AS DateTime2), CAST(N'2026-11-21T00:00:00.0000000' AS DateTime2), 5, 2, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (3, N'Asistente virtual de orientación académica', N'El proyecto busca diseñar y validar una solución de asistente virtual de orientación académica mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 3, CAST(N'2026-10-17T00:00:00.0000000' AS DateTime2), CAST(N'2026-11-22T00:00:00.0000000' AS DateTime2), 6, 3, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (4, N'Recomendador de oportunidades de aprendizaje', N'El proyecto busca diseñar y validar una solución de recomendador de oportunidades de aprendizaje mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 4, CAST(N'2026-10-16T00:00:00.0000000' AS DateTime2), CAST(N'2026-11-23T00:00:00.0000000' AS DateTime2), 7, 4, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (5, N'Tablero de sostenibilidad de campus', N'El proyecto busca diseñar y validar una solución de tablero de sostenibilidad de campus mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 1, CAST(N'2026-10-15T00:00:00.0000000' AS DateTime2), CAST(N'2026-11-24T00:00:00.0000000' AS DateTime2), 8, 5, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (6, N'Auditoría de accesibilidad de portales educativos', N'El proyecto busca diseñar y validar una solución de auditoría de accesibilidad de portales educativos mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 2, CAST(N'2026-10-14T00:00:00.0000000' AS DateTime2), CAST(N'2026-11-25T00:00:00.0000000' AS DateTime2), 9, 6, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (7, N'Clasificador de documentos académicos', N'El proyecto busca diseñar y validar una solución de clasificador de documentos académicos mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 3, CAST(N'2026-10-13T00:00:00.0000000' AS DateTime2), CAST(N'2026-11-26T00:00:00.0000000' AS DateTime2), 10, 7, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (8, N'API de integración para información universitaria', N'El proyecto busca diseñar y validar una solución de api de integración para información universitaria mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 4, CAST(N'2026-10-12T00:00:00.0000000' AS DateTime2), CAST(N'2026-11-27T00:00:00.0000000' AS DateTime2), 3, 8, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (9, N'Mapa de redes de colaboración académica', N'El proyecto busca diseñar y validar una solución de mapa de redes de colaboración académica mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 1, CAST(N'2026-10-11T00:00:00.0000000' AS DateTime2), CAST(N'2026-11-28T00:00:00.0000000' AS DateTime2), 4, 9, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (10, N'Aplicación móvil para seguimiento de equipos', N'El proyecto busca diseñar y validar una solución de aplicación móvil para seguimiento de equipos mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 2, CAST(N'2026-10-10T00:00:00.0000000' AS DateTime2), CAST(N'2026-11-29T00:00:00.0000000' AS DateTime2), 5, 10, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (11, N'Modelo de calidad de datos de matrículas', N'El proyecto busca diseñar y validar una solución de modelo de calidad de datos de matrículas mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 3, CAST(N'2026-10-09T00:00:00.0000000' AS DateTime2), CAST(N'2026-11-30T00:00:00.0000000' AS DateTime2), 6, 11, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (12, N'Pronóstico de demanda de asignaturas', N'El proyecto busca diseñar y validar una solución de pronóstico de demanda de asignaturas mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 4, CAST(N'2026-10-08T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-01T00:00:00.0000000' AS DateTime2), 7, 12, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (13, N'Plataforma de acompañamiento a tutorías', N'El proyecto busca diseñar y validar una solución de plataforma de acompañamiento a tutorías mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 1, CAST(N'2026-10-07T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-02T00:00:00.0000000' AS DateTime2), 8, 13, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (14, N'Mapa interactivo de recursos educativos abiertos', N'El proyecto busca diseñar y validar una solución de mapa interactivo de recursos educativos abiertos mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 2, CAST(N'2026-10-06T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-03T00:00:00.0000000' AS DateTime2), 9, 14, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (15, N'Análisis de rutas de movilidad estudiantil', N'El proyecto busca diseñar y validar una solución de análisis de rutas de movilidad estudiantil mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 3, CAST(N'2026-10-05T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-04T00:00:00.0000000' AS DateTime2), 10, 15, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (16, N'Alertas tempranas de riesgo académico', N'El proyecto busca diseñar y validar una solución de alertas tempranas de riesgo académico mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 4, CAST(N'2026-10-04T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-05T00:00:00.0000000' AS DateTime2), 3, 1, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (17, N'Repositorio de evidencias de aprendizaje', N'El proyecto busca diseñar y validar una solución de repositorio de evidencias de aprendizaje mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 1, CAST(N'2026-10-03T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-06T00:00:00.0000000' AS DateTime2), 4, 2, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (18, N'Indicadores de productividad investigativa', N'El proyecto busca diseñar y validar una solución de indicadores de productividad investigativa mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 2, CAST(N'2026-10-02T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-07T00:00:00.0000000' AS DateTime2), 5, 3, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (19, N'Portal de proyectos con impacto comunitario', N'El proyecto busca diseñar y validar una solución de portal de proyectos con impacto comunitario mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 3, CAST(N'2026-10-01T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-08T00:00:00.0000000' AS DateTime2), 6, 4, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (20, N'Clasificación de consultas de estudiantes', N'El proyecto busca diseñar y validar una solución de clasificación de consultas de estudiantes mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 4, CAST(N'2026-09-30T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-09T00:00:00.0000000' AS DateTime2), 7, 5, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (21, N'Biblioteca digital inclusiva', N'El proyecto busca diseñar y validar una solución de biblioteca digital inclusiva mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 1, CAST(N'2026-09-29T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-10T00:00:00.0000000' AS DateTime2), 8, 6, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (22, N'Evaluación de experiencia de trámites académicos', N'El proyecto busca diseñar y validar una solución de evaluación de experiencia de trámites académicos mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 2, CAST(N'2026-09-28T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-11T00:00:00.0000000' AS DateTime2), 9, 7, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (23, N'Inventario inteligente de laboratorios', N'El proyecto busca diseñar y validar una solución de inventario inteligente de laboratorios mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 3, CAST(N'2026-09-27T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-12T00:00:00.0000000' AS DateTime2), 10, 8, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (24, N'Monitoreo de consumo energético del campus', N'El proyecto busca diseñar y validar una solución de monitoreo de consumo energético del campus mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 4, CAST(N'2026-09-26T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-13T00:00:00.0000000' AS DateTime2), 3, 9, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (25, N'Sistema de reservas de salas universitarias', N'El proyecto busca diseñar y validar una solución de sistema de reservas de salas universitarias mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 1, CAST(N'2026-09-25T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-14T00:00:00.0000000' AS DateTime2), 4, 10, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (26, N'Análisis de comunidades de aprendizaje', N'El proyecto busca diseñar y validar una solución de análisis de comunidades de aprendizaje mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 2, CAST(N'2026-09-24T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-15T00:00:00.0000000' AS DateTime2), 5, 11, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (27, N'Validador automatizado de requisitos de software', N'El proyecto busca diseñar y validar una solución de validador automatizado de requisitos de software mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 3, CAST(N'2026-09-23T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-16T00:00:00.0000000' AS DateTime2), 6, 12, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (28, N'Portal de divulgación de proyectos científicos', N'El proyecto busca diseñar y validar una solución de portal de divulgación de proyectos científicos mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 4, CAST(N'2026-09-22T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-17T00:00:00.0000000' AS DateTime2), 7, 13, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (29, N'Trazabilidad de entregables en investigación', N'El proyecto busca diseñar y validar una solución de trazabilidad de entregables en investigación mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 1, CAST(N'2026-09-21T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-18T00:00:00.0000000' AS DateTime2), 8, 14, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (30, N'Priorización de propuestas de innovación', N'El proyecto busca diseñar y validar una solución de priorización de propuestas de innovación mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 2, CAST(N'2026-09-20T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-19T00:00:00.0000000' AS DateTime2), 9, 15, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (31, N'Servicio de acompañamiento a mentorías', N'El proyecto busca diseñar y validar una solución de servicio de acompañamiento a mentorías mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 3, CAST(N'2026-09-19T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-20T00:00:00.0000000' AS DateTime2), 10, 1, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (32, N'Control de prácticas y pasantías académicas', N'El proyecto busca diseñar y validar una solución de control de prácticas y pasantías académicas mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 4, CAST(N'2026-09-18T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-21T00:00:00.0000000' AS DateTime2), 3, 2, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (33, N'Indicadores de participación estudiantil', N'El proyecto busca diseñar y validar una solución de indicadores de participación estudiantil mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 1, CAST(N'2026-09-17T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-22T00:00:00.0000000' AS DateTime2), 4, 3, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (34, N'Buscador de normativa académica', N'El proyecto busca diseñar y validar una solución de buscador de normativa académica mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 2, CAST(N'2026-09-16T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-23T00:00:00.0000000' AS DateTime2), 5, 4, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (35, N'Panel de planificación para docentes', N'El proyecto busca diseñar y validar una solución de panel de planificación para docentes mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 3, CAST(N'2026-09-15T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-24T00:00:00.0000000' AS DateTime2), 6, 5, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (36, N'Automatización de informes institucionales', N'El proyecto busca diseñar y validar una solución de automatización de informes institucionales mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 4, CAST(N'2026-09-14T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-25T00:00:00.0000000' AS DateTime2), 7, 6, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (37, N'Accesibilidad de contenidos multimedia educativos', N'El proyecto busca diseñar y validar una solución de accesibilidad de contenidos multimedia educativos mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 1, CAST(N'2026-09-13T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-26T00:00:00.0000000' AS DateTime2), 8, 7, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (38, N'Detección de inconsistencias en datos académicos', N'El proyecto busca diseñar y validar una solución de detección de inconsistencias en datos académicos mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 2, CAST(N'2026-09-12T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-27T00:00:00.0000000' AS DateTime2), 9, 8, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (39, N'Herramientas de aprendizaje híbrido', N'El proyecto busca diseñar y validar una solución de herramientas de aprendizaje híbrido mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 3, CAST(N'2026-09-11T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-28T00:00:00.0000000' AS DateTime2), 10, 9, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (40, N'Indicadores de bienestar y permanencia', N'El proyecto busca diseñar y validar una solución de indicadores de bienestar y permanencia mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 4, CAST(N'2026-09-10T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-29T00:00:00.0000000' AS DateTime2), 3, 10, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (41, N'Agenda colaborativa para semilleros', N'El proyecto busca diseñar y validar una solución de agenda colaborativa para semilleros mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 1, CAST(N'2026-09-09T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-30T00:00:00.0000000' AS DateTime2), 4, 11, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (42, N'Clasificador de recursos de formación', N'El proyecto busca diseñar y validar una solución de clasificador de recursos de formación mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 2, CAST(N'2026-09-08T00:00:00.0000000' AS DateTime2), CAST(N'2026-12-31T00:00:00.0000000' AS DateTime2), 5, 12, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (43, N'Evaluación multicriterio de proyectos académicos', N'El proyecto busca diseñar y validar una solución de evaluación multicriterio de proyectos académicos mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 3, CAST(N'2026-09-07T00:00:00.0000000' AS DateTime2), CAST(N'2027-01-01T00:00:00.0000000' AS DateTime2), 6, 13, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (44, N'Experiencia digital para nuevos estudiantes', N'El proyecto busca diseñar y validar una solución de experiencia digital para nuevos estudiantes mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 4, CAST(N'2026-09-06T00:00:00.0000000' AS DateTime2), CAST(N'2027-01-02T00:00:00.0000000' AS DateTime2), 7, 14, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (45, N'Predicción de ocupación de espacios educativos', N'El proyecto busca diseñar y validar una solución de predicción de ocupación de espacios educativos mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 1, CAST(N'2026-09-05T00:00:00.0000000' AS DateTime2), CAST(N'2027-01-03T00:00:00.0000000' AS DateTime2), 8, 15, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (46, N'Control de versiones de documentos académicos', N'El proyecto busca diseñar y validar una solución de control de versiones de documentos académicos mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 2, CAST(N'2026-09-04T00:00:00.0000000' AS DateTime2), CAST(N'2027-01-04T00:00:00.0000000' AS DateTime2), 9, 1, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (47, N'Comunicación y seguimiento entre investigadores', N'El proyecto busca diseñar y validar una solución de comunicación y seguimiento entre investigadores mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 3, CAST(N'2026-09-03T00:00:00.0000000' AS DateTime2), CAST(N'2027-01-05T00:00:00.0000000' AS DateTime2), 10, 2, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (48, N'Modelo predictivo de asistencia a clases', N'El proyecto busca diseñar y validar una solución de modelo predictivo de asistencia a clases mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 4, CAST(N'2026-09-02T00:00:00.0000000' AS DateTime2), CAST(N'2027-01-06T00:00:00.0000000' AS DateTime2), 3, 3, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (49, N'Panel de metas para grupos estudiantiles', N'El proyecto busca diseñar y validar una solución de panel de metas para grupos estudiantiles mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 1, CAST(N'2026-09-01T00:00:00.0000000' AS DateTime2), CAST(N'2027-01-07T00:00:00.0000000' AS DateTime2), 4, 4, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (50, N'Registro móvil de actividades de investigación', N'El proyecto busca diseñar y validar una solución de registro móvil de actividades de investigación mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 2, CAST(N'2026-08-31T00:00:00.0000000' AS DateTime2), CAST(N'2027-01-08T00:00:00.0000000' AS DateTime2), 5, 5, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (51, N'Observatorio de tendencias tecnológicas', N'El proyecto busca diseñar y validar una solución de observatorio de tendencias tecnológicas mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 3, CAST(N'2026-08-30T00:00:00.0000000' AS DateTime2), CAST(N'2027-01-09T00:00:00.0000000' AS DateTime2), 6, 6, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (52, N'Catálogo de competencias estudiantiles', N'El proyecto busca diseñar y validar una solución de catálogo de competencias estudiantiles mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 4, CAST(N'2026-08-29T00:00:00.0000000' AS DateTime2), CAST(N'2027-01-10T00:00:00.0000000' AS DateTime2), 7, 7, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (53, N'Gestor de convocatorias de investigación', N'El proyecto busca diseñar y validar una solución de gestor de convocatorias de investigación mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 1, CAST(N'2026-08-28T00:00:00.0000000' AS DateTime2), CAST(N'2027-01-11T00:00:00.0000000' AS DateTime2), 8, 8, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (54, N'Visualizador de encuestas institucionales', N'El proyecto busca diseñar y validar una solución de visualizador de encuestas institucionales mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 2, CAST(N'2026-08-27T00:00:00.0000000' AS DateTime2), CAST(N'2027-01-12T00:00:00.0000000' AS DateTime2), 9, 9, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (55, N'Portal de documentación de servicios API', N'El proyecto busca diseñar y validar una solución de portal de documentación de servicios api mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 3, CAST(N'2026-08-26T00:00:00.0000000' AS DateTime2), CAST(N'2027-01-13T00:00:00.0000000' AS DateTime2), 10, 10, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (56, N'Recomendador de materiales de estudio', N'El proyecto busca diseñar y validar una solución de recomendador de materiales de estudio mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 4, CAST(N'2026-08-25T00:00:00.0000000' AS DateTime2), CAST(N'2027-01-14T00:00:00.0000000' AS DateTime2), 3, 11, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (57, N'Red de colaboración interdisciplinaria', N'El proyecto busca diseñar y validar una solución de red de colaboración interdisciplinaria mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 1, CAST(N'2026-08-24T00:00:00.0000000' AS DateTime2), CAST(N'2027-01-15T00:00:00.0000000' AS DateTime2), 4, 12, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (58, N'Control de indicadores ambientales universitarios', N'El proyecto busca diseñar y validar una solución de control de indicadores ambientales universitarios mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 2, CAST(N'2026-08-23T00:00:00.0000000' AS DateTime2), CAST(N'2027-01-16T00:00:00.0000000' AS DateTime2), 5, 13, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (59, N'Simulador remoto para prácticas de laboratorio', N'El proyecto busca diseñar y validar una solución de simulador remoto para prácticas de laboratorio mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 3, CAST(N'2026-08-22T00:00:00.0000000' AS DateTime2), CAST(N'2027-01-17T00:00:00.0000000' AS DateTime2), 6, 14, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (60, N'Auditoría automatizada de calidad de datos', N'El proyecto busca diseñar y validar una solución de auditoría automatizada de calidad de datos mediante levantamiento de requisitos, elaboración de un prototipo funcional, pruebas con usuarios y documentación de resultados. El equipo trabajará con evidencias y métricas de evaluación.', 4, CAST(N'2026-08-21T00:00:00.0000000' AS DateTime2), CAST(N'2027-01-18T00:00:00.0000000' AS DateTime2), 7, 15, 1, NULL, NULL)
INSERT [dbo].[Proyectos] ([Id], [Titulo], [Descripcion], [Estado], [FechaCreacion], [FechaLimite], [CuposDisponibles], [ProfesorId], [Tipo], [CreadorEstudianteId], [Objetivo]) VALUES (61, N'Dashboard inteligente para oportunidades académicas', N'Proyecto colaborativo para desarrollar una plataforma web que permita visualizar oportunidades académicas, proyectos universitarios y perfiles de estudiantes, facilitando la conformación de equipos según habilidades e intereses.', 1, CAST(N'2026-10-22T15:05:59.7310230' AS DateTime2), CAST(N'2026-10-22T00:00:00.0000000' AS DateTime2), 4, NULL, 2, 101, N'Diseñar y desarrollar un prototipo funcional que permita conectar estudiantes con oportunidades académicas y recomendar compañeros compatibles mediante sus habilidades e intereses.')
SET IDENTITY_INSERT [dbo].[Proyectos] OFF
GO
SET IDENTITY_INSERT [dbo].[Recomendaciones] ON 

INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (1, 1, 1, CAST(60.00 AS Decimal(5, 2)), CAST(N'2026-10-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (2, 2, 8, CAST(61.00 AS Decimal(5, 2)), CAST(N'2026-10-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (3, 3, 15, CAST(62.00 AS Decimal(5, 2)), CAST(N'2026-10-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (4, 4, 22, CAST(63.00 AS Decimal(5, 2)), CAST(N'2026-10-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (5, 5, 29, CAST(64.00 AS Decimal(5, 2)), CAST(N'2026-10-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (6, 6, 36, CAST(65.00 AS Decimal(5, 2)), CAST(N'2026-10-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (7, 7, 43, CAST(66.00 AS Decimal(5, 2)), CAST(N'2026-10-14T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (8, 8, 50, CAST(67.00 AS Decimal(5, 2)), CAST(N'2026-10-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (9, 9, 57, CAST(68.00 AS Decimal(5, 2)), CAST(N'2026-10-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (10, 10, 4, CAST(69.00 AS Decimal(5, 2)), CAST(N'2026-10-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (11, 11, 11, CAST(70.00 AS Decimal(5, 2)), CAST(N'2026-10-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (12, 12, 18, CAST(71.00 AS Decimal(5, 2)), CAST(N'2026-10-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (13, 13, 25, CAST(72.00 AS Decimal(5, 2)), CAST(N'2026-10-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (14, 14, 32, CAST(73.00 AS Decimal(5, 2)), CAST(N'2026-10-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (15, 15, 39, CAST(74.00 AS Decimal(5, 2)), CAST(N'2026-10-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (16, 16, 46, CAST(75.00 AS Decimal(5, 2)), CAST(N'2026-10-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (17, 17, 53, CAST(76.00 AS Decimal(5, 2)), CAST(N'2026-10-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (18, 18, 60, CAST(77.00 AS Decimal(5, 2)), CAST(N'2026-10-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (19, 19, 7, CAST(78.00 AS Decimal(5, 2)), CAST(N'2026-10-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (20, 20, 14, CAST(79.00 AS Decimal(5, 2)), CAST(N'2026-10-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (21, 21, 21, CAST(80.00 AS Decimal(5, 2)), CAST(N'2026-09-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (22, 22, 28, CAST(81.00 AS Decimal(5, 2)), CAST(N'2026-09-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (23, 23, 35, CAST(82.00 AS Decimal(5, 2)), CAST(N'2026-09-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (24, 24, 42, CAST(83.00 AS Decimal(5, 2)), CAST(N'2026-09-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (25, 25, 49, CAST(84.00 AS Decimal(5, 2)), CAST(N'2026-09-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (26, 26, 56, CAST(85.00 AS Decimal(5, 2)), CAST(N'2026-09-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (27, 27, 3, CAST(86.00 AS Decimal(5, 2)), CAST(N'2026-09-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (28, 28, 10, CAST(87.00 AS Decimal(5, 2)), CAST(N'2026-09-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (29, 29, 17, CAST(88.00 AS Decimal(5, 2)), CAST(N'2026-09-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (30, 30, 24, CAST(89.00 AS Decimal(5, 2)), CAST(N'2026-09-21T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (31, 31, 31, CAST(90.00 AS Decimal(5, 2)), CAST(N'2026-09-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (32, 32, 38, CAST(91.00 AS Decimal(5, 2)), CAST(N'2026-09-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (33, 33, 45, CAST(92.00 AS Decimal(5, 2)), CAST(N'2026-09-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (34, 34, 52, CAST(93.00 AS Decimal(5, 2)), CAST(N'2026-09-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (35, 35, 59, CAST(94.00 AS Decimal(5, 2)), CAST(N'2026-09-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (36, 36, 6, CAST(95.00 AS Decimal(5, 2)), CAST(N'2026-09-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (37, 37, 13, CAST(96.00 AS Decimal(5, 2)), CAST(N'2026-09-14T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (38, 38, 20, CAST(97.00 AS Decimal(5, 2)), CAST(N'2026-09-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (39, 39, 27, CAST(98.00 AS Decimal(5, 2)), CAST(N'2026-09-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (40, 40, 34, CAST(99.00 AS Decimal(5, 2)), CAST(N'2026-09-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (41, 41, 41, CAST(60.00 AS Decimal(5, 2)), CAST(N'2026-09-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (42, 42, 48, CAST(61.00 AS Decimal(5, 2)), CAST(N'2026-09-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (43, 43, 55, CAST(62.00 AS Decimal(5, 2)), CAST(N'2026-09-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (44, 44, 2, CAST(63.00 AS Decimal(5, 2)), CAST(N'2026-09-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (45, 45, 9, CAST(64.00 AS Decimal(5, 2)), CAST(N'2026-09-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (46, 46, 16, CAST(65.00 AS Decimal(5, 2)), CAST(N'2026-09-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (47, 47, 23, CAST(66.00 AS Decimal(5, 2)), CAST(N'2026-09-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (48, 48, 30, CAST(67.00 AS Decimal(5, 2)), CAST(N'2026-09-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (49, 49, 37, CAST(68.00 AS Decimal(5, 2)), CAST(N'2026-09-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (50, 50, 44, CAST(69.00 AS Decimal(5, 2)), CAST(N'2026-09-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (51, 51, 51, CAST(70.00 AS Decimal(5, 2)), CAST(N'2026-08-31T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (52, 52, 58, CAST(71.00 AS Decimal(5, 2)), CAST(N'2026-08-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (53, 53, 5, CAST(72.00 AS Decimal(5, 2)), CAST(N'2026-08-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (54, 54, 12, CAST(73.00 AS Decimal(5, 2)), CAST(N'2026-08-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (55, 55, 19, CAST(74.00 AS Decimal(5, 2)), CAST(N'2026-08-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (56, 56, 26, CAST(75.00 AS Decimal(5, 2)), CAST(N'2026-08-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (57, 57, 33, CAST(76.00 AS Decimal(5, 2)), CAST(N'2026-08-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (58, 58, 40, CAST(77.00 AS Decimal(5, 2)), CAST(N'2026-08-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (59, 59, 47, CAST(78.00 AS Decimal(5, 2)), CAST(N'2026-08-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (60, 60, 54, CAST(79.00 AS Decimal(5, 2)), CAST(N'2026-08-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (61, 61, 1, CAST(80.00 AS Decimal(5, 2)), CAST(N'2026-08-21T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (62, 62, 8, CAST(81.00 AS Decimal(5, 2)), CAST(N'2026-08-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (63, 63, 15, CAST(82.00 AS Decimal(5, 2)), CAST(N'2026-08-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (64, 64, 22, CAST(83.00 AS Decimal(5, 2)), CAST(N'2026-08-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (65, 65, 29, CAST(84.00 AS Decimal(5, 2)), CAST(N'2026-08-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (66, 66, 36, CAST(85.00 AS Decimal(5, 2)), CAST(N'2026-08-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (67, 67, 43, CAST(86.00 AS Decimal(5, 2)), CAST(N'2026-08-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (68, 68, 50, CAST(87.00 AS Decimal(5, 2)), CAST(N'2026-08-14T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (69, 69, 57, CAST(88.00 AS Decimal(5, 2)), CAST(N'2026-08-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (70, 70, 4, CAST(89.00 AS Decimal(5, 2)), CAST(N'2026-08-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (71, 71, 11, CAST(90.00 AS Decimal(5, 2)), CAST(N'2026-08-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (72, 72, 18, CAST(91.00 AS Decimal(5, 2)), CAST(N'2026-08-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (73, 73, 25, CAST(92.00 AS Decimal(5, 2)), CAST(N'2026-08-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (74, 74, 32, CAST(93.00 AS Decimal(5, 2)), CAST(N'2026-08-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (75, 75, 39, CAST(94.00 AS Decimal(5, 2)), CAST(N'2026-08-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (76, 76, 46, CAST(95.00 AS Decimal(5, 2)), CAST(N'2026-08-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (77, 77, 53, CAST(96.00 AS Decimal(5, 2)), CAST(N'2026-08-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (78, 78, 60, CAST(97.00 AS Decimal(5, 2)), CAST(N'2026-08-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (79, 79, 7, CAST(98.00 AS Decimal(5, 2)), CAST(N'2026-08-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (80, 80, 14, CAST(99.00 AS Decimal(5, 2)), CAST(N'2026-08-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (81, 81, 21, CAST(60.00 AS Decimal(5, 2)), CAST(N'2026-08-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (82, 82, 28, CAST(61.00 AS Decimal(5, 2)), CAST(N'2026-07-31T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (83, 83, 35, CAST(62.00 AS Decimal(5, 2)), CAST(N'2026-07-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (84, 84, 42, CAST(63.00 AS Decimal(5, 2)), CAST(N'2026-07-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (85, 85, 49, CAST(64.00 AS Decimal(5, 2)), CAST(N'2026-07-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (86, 86, 56, CAST(65.00 AS Decimal(5, 2)), CAST(N'2026-07-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (87, 87, 3, CAST(66.00 AS Decimal(5, 2)), CAST(N'2026-07-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (88, 88, 10, CAST(67.00 AS Decimal(5, 2)), CAST(N'2026-07-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (89, 89, 17, CAST(68.00 AS Decimal(5, 2)), CAST(N'2026-07-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (90, 90, 24, CAST(69.00 AS Decimal(5, 2)), CAST(N'2026-07-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (91, 91, 31, CAST(70.00 AS Decimal(5, 2)), CAST(N'2026-07-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (92, 92, 38, CAST(71.00 AS Decimal(5, 2)), CAST(N'2026-07-21T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (93, 93, 45, CAST(72.00 AS Decimal(5, 2)), CAST(N'2026-07-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (94, 94, 52, CAST(73.00 AS Decimal(5, 2)), CAST(N'2026-07-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (95, 95, 59, CAST(74.00 AS Decimal(5, 2)), CAST(N'2026-07-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (96, 96, 6, CAST(75.00 AS Decimal(5, 2)), CAST(N'2026-07-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (97, 97, 13, CAST(76.00 AS Decimal(5, 2)), CAST(N'2026-07-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (98, 98, 20, CAST(77.00 AS Decimal(5, 2)), CAST(N'2026-07-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (99, 99, 27, CAST(78.00 AS Decimal(5, 2)), CAST(N'2026-07-14T00:00:00.0000000' AS DateTime2))
GO
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (100, 100, 34, CAST(79.00 AS Decimal(5, 2)), CAST(N'2026-07-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (101, 1, 41, CAST(80.00 AS Decimal(5, 2)), CAST(N'2026-07-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (102, 2, 48, CAST(81.00 AS Decimal(5, 2)), CAST(N'2026-07-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (103, 3, 55, CAST(82.00 AS Decimal(5, 2)), CAST(N'2026-07-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (104, 4, 2, CAST(83.00 AS Decimal(5, 2)), CAST(N'2026-07-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (105, 5, 9, CAST(84.00 AS Decimal(5, 2)), CAST(N'2026-07-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (106, 6, 16, CAST(85.00 AS Decimal(5, 2)), CAST(N'2026-07-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (107, 7, 23, CAST(86.00 AS Decimal(5, 2)), CAST(N'2026-07-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (108, 8, 30, CAST(87.00 AS Decimal(5, 2)), CAST(N'2026-07-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (109, 9, 37, CAST(88.00 AS Decimal(5, 2)), CAST(N'2026-07-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (110, 10, 44, CAST(89.00 AS Decimal(5, 2)), CAST(N'2026-07-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (111, 11, 51, CAST(90.00 AS Decimal(5, 2)), CAST(N'2026-07-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (112, 12, 58, CAST(91.00 AS Decimal(5, 2)), CAST(N'2026-07-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (113, 13, 5, CAST(92.00 AS Decimal(5, 2)), CAST(N'2026-06-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (114, 14, 12, CAST(93.00 AS Decimal(5, 2)), CAST(N'2026-06-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (115, 15, 19, CAST(94.00 AS Decimal(5, 2)), CAST(N'2026-06-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (116, 16, 26, CAST(95.00 AS Decimal(5, 2)), CAST(N'2026-06-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (117, 17, 33, CAST(96.00 AS Decimal(5, 2)), CAST(N'2026-06-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (118, 18, 40, CAST(97.00 AS Decimal(5, 2)), CAST(N'2026-06-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (119, 19, 47, CAST(98.00 AS Decimal(5, 2)), CAST(N'2026-06-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (120, 20, 54, CAST(99.00 AS Decimal(5, 2)), CAST(N'2026-06-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (121, 21, 1, CAST(60.00 AS Decimal(5, 2)), CAST(N'2026-06-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (122, 22, 8, CAST(61.00 AS Decimal(5, 2)), CAST(N'2026-06-21T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (123, 23, 15, CAST(62.00 AS Decimal(5, 2)), CAST(N'2026-06-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (124, 24, 22, CAST(63.00 AS Decimal(5, 2)), CAST(N'2026-06-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (125, 25, 29, CAST(64.00 AS Decimal(5, 2)), CAST(N'2026-06-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (126, 26, 36, CAST(65.00 AS Decimal(5, 2)), CAST(N'2026-06-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (127, 27, 43, CAST(66.00 AS Decimal(5, 2)), CAST(N'2026-06-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (128, 28, 50, CAST(67.00 AS Decimal(5, 2)), CAST(N'2026-06-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (129, 29, 57, CAST(68.00 AS Decimal(5, 2)), CAST(N'2026-06-14T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (130, 30, 4, CAST(69.00 AS Decimal(5, 2)), CAST(N'2026-06-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (131, 31, 11, CAST(70.00 AS Decimal(5, 2)), CAST(N'2026-06-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (132, 32, 18, CAST(71.00 AS Decimal(5, 2)), CAST(N'2026-06-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (133, 33, 25, CAST(72.00 AS Decimal(5, 2)), CAST(N'2026-06-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (134, 34, 32, CAST(73.00 AS Decimal(5, 2)), CAST(N'2026-06-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (135, 35, 39, CAST(74.00 AS Decimal(5, 2)), CAST(N'2026-06-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (136, 36, 46, CAST(75.00 AS Decimal(5, 2)), CAST(N'2026-06-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (137, 37, 53, CAST(76.00 AS Decimal(5, 2)), CAST(N'2026-06-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (138, 38, 60, CAST(77.00 AS Decimal(5, 2)), CAST(N'2026-06-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (139, 39, 7, CAST(78.00 AS Decimal(5, 2)), CAST(N'2026-06-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (140, 40, 14, CAST(79.00 AS Decimal(5, 2)), CAST(N'2026-06-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (141, 41, 21, CAST(80.00 AS Decimal(5, 2)), CAST(N'2026-06-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (142, 42, 28, CAST(81.00 AS Decimal(5, 2)), CAST(N'2026-06-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (143, 43, 35, CAST(82.00 AS Decimal(5, 2)), CAST(N'2026-05-31T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (144, 44, 42, CAST(83.00 AS Decimal(5, 2)), CAST(N'2026-05-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (145, 45, 49, CAST(84.00 AS Decimal(5, 2)), CAST(N'2026-05-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (146, 46, 56, CAST(85.00 AS Decimal(5, 2)), CAST(N'2026-05-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (147, 47, 3, CAST(86.00 AS Decimal(5, 2)), CAST(N'2026-05-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (148, 48, 10, CAST(87.00 AS Decimal(5, 2)), CAST(N'2026-05-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (149, 49, 17, CAST(88.00 AS Decimal(5, 2)), CAST(N'2026-05-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Recomendaciones] ([Id], [EstudianteId], [ProyectoId], [PorcentajeCompatibilidad], [FechaGeneracion]) VALUES (150, 50, 24, CAST(89.00 AS Decimal(5, 2)), CAST(N'2026-05-24T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Recomendaciones] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (1, N'Sonia', N'Molina', N'soni1999@hotmail.es', N'$2a$11$doSbKS6qVBd6fdRu3QZPNuA6M/WJsRB8YdxcVbzd5873tUc4QqM/6', 3, 1, CAST(N'2026-10-20T22:40:02.0915967' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (2, N'Valentina', N'Sánchez Valderrama', N'seed.estudiante@talentmatch.local', N'$2a$11$K8LC.8Pd7.edTFawuGMSiO8GQPG54x0eagcwGApKacz8I9Xt1P7.K', 2, 1, CAST(N'2026-10-20T23:00:09.5363251' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (3, N'Mateo', N'Guzmán Parra', N'seed.estudiante.002@talentmatch.local', N'$2a$11$onkksW1Xxj9.7id92v3H2Olnk5VRyErFvXSbdp7C7vZBUq/fAxkj2', 1, 1, CAST(N'2026-10-20T23:00:09.8177135' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (4, N'Camila', N'Moreno Castillo', N'seed.estudiante.003@talentmatch.local', N'$2a$11$i4oJ//90i71hrpBoONu.NOy1t7UdnLYZM8sp/UdAba2cxJGUazX4u', 1, 1, CAST(N'2026-10-20T23:00:10.0279293' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (5, N'Santiago', N'Reyes Bermúdez', N'seed.estudiante.004@talentmatch.local', N'$2a$11$9Ot8qTTYXGZR0cfNgFXXquiL6ic7ajogGxH19wC8wD/ECRS9D757W', 1, 1, CAST(N'2026-10-20T23:00:10.2460590' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (6, N'Sofía', N'Ospina Rincón', N'seed.estudiante.005@talentmatch.local', N'$2a$11$PnE3Nej8vuAx376WZXqcSuacAY.guF3OaSNDbxfyWD2QcIp9RGrr6', 1, 1, CAST(N'2026-10-20T23:00:10.4288675' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (7, N'Nicolás', N'Navarro Peña', N'seed.estudiante.006@talentmatch.local', N'$2a$11$5QsirChlEKkTXUUcfEo5j.MpJ1CkDUcieyfyVLsWA.TNYmxljlhoa', 1, 1, CAST(N'2026-10-20T23:00:10.6274159' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (8, N'Mariana', N'Díaz Escobar', N'seed.estudiante.007@talentmatch.local', N'$2a$11$eIYf4iFoqXDI8lIBas8SE.ThHaqNsVHbPuAjPwIvG2dqZ/QQA27gm', 1, 1, CAST(N'2026-10-20T23:00:10.8200754' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (9, N'Samuel', N'Bermúdez Mejía', N'seed.estudiante.008@talentmatch.local', N'$2a$11$Y4.S4tUGiiTvcxNOQfSsDOKBVts//Y549uOUHMoPz0fIIGGX9BpLy', 1, 1, CAST(N'2026-10-20T23:00:11.0401806' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (10, N'Isabela', N'Suárez Cárdenas', N'seed.estudiante.009@talentmatch.local', N'$2a$11$8lLquP5oH38reBLcuzxFkeh/5ug2KVR0AdxHSzF5or2uVs9PLJdd2', 1, 1, CAST(N'2026-10-20T23:00:11.2358304' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (11, N'Daniel', N'Vargas Cifuentes', N'seed.estudiante.010@talentmatch.local', N'$2a$11$47WTeU8xMaPMVSfHnxVy0ODK/oR2aIyZalEWfXF4WsUDzySguzJz.', 1, 1, CAST(N'2026-10-20T23:00:11.4365166' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (12, N'Luciana', N'Quintero Rojas', N'seed.estudiante.011@talentmatch.local', N'$2a$11$l4wFYre5gmbbeDDkO5dlIOb6UTNIjZdWyhm4kfolS95icry/WCuAK', 1, 1, CAST(N'2026-10-20T23:00:11.6218824' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (13, N'Tomás', N'Castro Vargas', N'seed.estudiante.012@talentmatch.local', N'$2a$11$aq9kaVM9TPp3ougO2nd3ceCph3leLYCfOV6FD/gzSFStAn/WGc23S', 1, 1, CAST(N'2026-10-20T23:00:11.8057391' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (14, N'Antonella', N'Lozano Acosta', N'seed.estudiante.013@talentmatch.local', N'$2a$11$NY5TmSM/Qq17bED2s1N1u.m/D7NJAaBL1VXpzVVn/nUJugz2OahMK', 1, 1, CAST(N'2026-10-20T23:00:12.0355472' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (15, N'Andrés', N'Rueda Bustos', N'seed.estudiante.014@talentmatch.local', N'$2a$11$72xEakOcNR4fM5nJitkoLeRmMK5Id9erk5VmFjrWut8NHEwO9mdWe', 1, 1, CAST(N'2026-10-20T23:00:12.2377022' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (16, N'Julieta', N'Pérez Molina', N'seed.estudiante.015@talentmatch.local', N'$2a$11$SLWqxWAZMBFn7jMfEjuGDehGcmr4q8y0b7/Jh429DCm96xUDvNWKC', 1, 1, CAST(N'2026-10-20T23:00:12.4328535' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (17, N'Emiliano', N'Jiménez Correa', N'seed.estudiante.016@talentmatch.local', N'$2a$11$S4kB1at5A55afkkZ9EDavuIghOxgHwQuIPbTPTABtJlszZods/63O', 1, 1, CAST(N'2026-10-20T23:00:12.6258423' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (18, N'Laura', N'Cruz Tovar', N'seed.estudiante.017@talentmatch.local', N'$2a$11$7vbJmI933FwyXZ7LeCD/K.R6T3QHxeBdRv5P1.f39EIEHbq9A5vKq', 1, 1, CAST(N'2026-10-20T23:00:12.8182088' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (19, N'Gabriel', N'Gómez Londoño', N'seed.estudiante.018@talentmatch.local', N'$2a$11$ZVU6CIUb6RRuoySLfsPe8.2KCH6Xu/BiXHOsUZXJjma8ByKepwY/.', 1, 1, CAST(N'2026-10-20T23:00:13.0055581' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (20, N'Paula', N'Silva Montoya', N'seed.estudiante.019@talentmatch.local', N'$2a$11$txOb4OjjsjyWEyLBYuRgR.9k9Dy0RfAoRluBBXeo.u9VTzyy.uBrK', 1, 1, CAST(N'2026-10-20T23:00:13.2141149' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (21, N'David', N'Escobar Niño', N'seed.estudiante.020@talentmatch.local', N'$2a$11$fq8RnMHPH7CMjwrMM6qGsOP04J.LNPE1qO8qiZKfSB1Ig66qTy4gS', 1, 1, CAST(N'2026-10-20T23:00:13.4165542' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (22, N'Valentina', N'Ramírez Duarte', N'seed.estudiante.021@talentmatch.local', N'$2a$11$R2YjSHqmvEmFlXV31fHDduDd/o6dENLvHxwzl2Fl5ooDJ3JJ4LAZ.', 1, 1, CAST(N'2026-10-20T23:00:13.6379752' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (23, N'Mateo', N'Cardona Guerrero', N'seed.estudiante.022@talentmatch.local', N'$2a$11$j9VVFoeD6y9mNSBcexlspuz14e7YJpNxkWj1Ue1Ryy3uhsF5hII5a', 1, 1, CAST(N'2026-10-20T23:00:13.8691960' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (24, N'Camila', N'Valencia Duarte', N'seed.estudiante.023@talentmatch.local', N'$2a$11$RI1/ToRWVv6Dnv/ic2j4yeI.BtHKzkX73kuWUtscQY4K3TVRvpm12', 1, 1, CAST(N'2026-10-20T23:00:14.0652135' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (25, N'Santiago', N'Vega Beltrán', N'seed.estudiante.024@talentmatch.local', N'$2a$11$pwxCObO2zJ6yJkBqucPmMuLMu.vmFAo7u9fDoNNoku72l23pOEMjC', 1, 1, CAST(N'2026-10-20T23:00:14.2688825' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (26, N'Sofía', N'Bautista Salcedo', N'seed.estudiante.025@talentmatch.local', N'$2a$11$POg5bg.eZEfoBvDjpR3AsO4/3KbVGMGa2452x15Nwgm18R7rVX/zi', 1, 1, CAST(N'2026-10-20T23:00:14.4996738' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (27, N'Nicolás', N'Maldonado Prieto', N'seed.estudiante.026@talentmatch.local', N'$2a$11$cS/SZcB..5N1Z4in9v7IKuu32Nae8aDIFq0pk9fu1r1ScEkGA9Gqa', 1, 1, CAST(N'2026-10-20T23:00:14.6971563' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (28, N'Mariana', N'Mendoza Pardo', N'seed.estudiante.027@talentmatch.local', N'$2a$11$U2XBjNRHnj8YJumOcOypnO6iIogsnkbE0PimCh68M3BpfyVj9H39a', 1, 1, CAST(N'2026-10-20T23:00:14.8950575' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (29, N'Samuel', N'Fonseca Ibarra', N'seed.estudiante.028@talentmatch.local', N'$2a$11$GTHnOaiiUIKgCEhhunEvDuJA6cmK6Tkfze/AoovXc3A1jGeNQI1Q6', 1, 1, CAST(N'2026-10-20T23:00:15.0887528' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (30, N'Isabela', N'Castañeda Ochoa', N'seed.estudiante.029@talentmatch.local', N'$2a$11$AzpgWK6yUatwqlQhPOIB7e7ZBGsVs8JnaNyUJFyLm3K2w6.YTDjtC', 1, 1, CAST(N'2026-10-20T23:00:15.3112763' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (31, N'Daniel', N'García Restrepo', N'seed.estudiante.030@talentmatch.local', N'$2a$11$y.MuvUbPHb1YbsZm48RGnO9iiFF6dGqT9q.1ZjeFafYKH3uHQJSqG', 1, 1, CAST(N'2026-10-20T23:00:15.5282838' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (32, N'Luciana', N'Ariza Palacios', N'seed.estudiante.031@talentmatch.local', N'$2a$11$tgJ/M3x.QrC.vlTSSi92C.iYOjDhOG/IXOWSXueF8yup5Kwq8G1bO', 1, 1, CAST(N'2026-10-20T23:00:15.7238419' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (33, N'Tomás', N'León Barrera', N'seed.estudiante.032@talentmatch.local', N'$2a$11$VE3NeqoXFEy0QyCvtaIqAegLyrDI996VEu75cRBUjCVZeXa5tOaha', 1, 1, CAST(N'2026-10-20T23:00:15.9333968' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (34, N'Antonella', N'Cortés Pineda', N'seed.estudiante.033@talentmatch.local', N'$2a$11$0ZsqLcwOJIaxin6Pmkw1befrg/m92xiZmlvSUipwX9JYRtCnJ7hia', 1, 1, CAST(N'2026-10-20T23:00:16.1458677' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (35, N'Andrés', N'Cárdenas Quiroga', N'seed.estudiante.034@talentmatch.local', N'$2a$11$.JtcN7cH4gP80s/UjlgjWegUL54qBFjrQTVfn4KNJKKk3Xbd6SfHm', 1, 1, CAST(N'2026-10-20T23:00:16.3628911' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (36, N'Julieta', N'Pineda Cárdenas', N'seed.estudiante.035@talentmatch.local', N'$2a$11$6LX88MicTTQHwCbD64qyveNNvhsfrTah4kb/cmAd76MwG1LeKisqu', 1, 1, CAST(N'2026-10-20T23:00:16.5425696' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (37, N'Emiliano', N'Ortiz Villamil', N'seed.estudiante.036@talentmatch.local', N'$2a$11$qo6.mIYfhrVuX2gG6B0gRutyF3AydJEkSMV4R7I8rsai7CdcfAZqm', 1, 1, CAST(N'2026-10-20T23:00:16.7397360' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (38, N'Laura', N'Serrano Flórez', N'seed.estudiante.037@talentmatch.local', N'$2a$11$MKbM71eyOU0fbtGJuv8Y5.YVwHDGpEmPL4FEsZaI9iuTXIzakJLNW', 1, 1, CAST(N'2026-10-20T23:00:16.9729784' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (39, N'Gabriel', N'Robles Caicedo', N'seed.estudiante.038@talentmatch.local', N'$2a$11$.m9l4y.NSo4mPAEidtLO0eZqLyNp8Rss/Lu6EAEnGy0.3wBm2E3Sm', 1, 1, CAST(N'2026-10-20T23:00:17.1532467' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (40, N'Paula', N'Herrera Robledo', N'seed.estudiante.039@talentmatch.local', N'$2a$11$A5/OdX3p.mbzlkNp.sA5eOQz51C5aHf6cPOD4D0AaPHaiuw0kl8Me', 1, 1, CAST(N'2026-10-20T23:00:17.3511969' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (41, N'David', N'Mora Calderón', N'seed.estudiante.040@talentmatch.local', N'$2a$11$E67jj8drtZTsLssAv2E1guyLx/IH/yBR8.IfyLnNq2tNeG9RTIYO.', 1, 1, CAST(N'2026-10-20T23:00:17.5471188' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (42, N'Valentina', N'Nieto Corredor', N'seed.estudiante.041@talentmatch.local', N'$2a$11$Ofi26B9WxNIdz2X2LIkkxuC/5B4nFQDnHVT8qL6v89kuyyuhR.XGK', 1, 1, CAST(N'2026-10-20T23:00:17.7654819' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (43, N'Mateo', N'Álvarez Castaño', N'seed.estudiante.042@talentmatch.local', N'$2a$11$9ElLmQIVDQwgXoOTanaBx.ySQLZoMJb/54IZDnQBQ.7jJMWyAFFt6', 1, 1, CAST(N'2026-10-20T23:00:17.9620680' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (44, N'Camila', N'Arias Trujillo', N'seed.estudiante.043@talentmatch.local', N'$2a$11$Q2BtlTB5BCwwvGqSwZCJXuwIBu0PNmZClVgW7CtRIKvJ2YRChCCui', 1, 1, CAST(N'2026-10-20T23:00:18.1665516' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (45, N'Santiago', N'Ríos Salazar', N'seed.estudiante.044@talentmatch.local', N'$2a$11$PoCsNABh.RvkYzyG8LT3COaa4j9G0x4VRlFvDs5F3tySEWix5umde', 1, 1, CAST(N'2026-10-20T23:00:18.4084289' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (46, N'Sofía', N'Sánchez Valderrama', N'seed.estudiante.045@talentmatch.local', N'$2a$11$PXADypMjAj374.aCUtixzewBzOO9/lCk5PJ7tebXE0xhEXe/I.Rvi', 1, 1, CAST(N'2026-10-20T23:00:18.5977896' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (47, N'Nicolás', N'Guzmán Parra', N'seed.estudiante.046@talentmatch.local', N'$2a$11$TlfzIlTUZqL4uO2usF4h5OW/lLjAITmJk/y9gUGzNB193o663Tu3u', 1, 1, CAST(N'2026-10-20T23:00:18.7857113' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (48, N'Mariana', N'Moreno Castillo', N'seed.estudiante.047@talentmatch.local', N'$2a$11$siMTKA2AKb0rXob3Ik4TLO/EkOxdUW/pIiVVRtH3zrd7HCal74otq', 1, 1, CAST(N'2026-10-20T23:00:18.9668594' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (49, N'Samuel', N'Reyes Bermúdez', N'seed.estudiante.048@talentmatch.local', N'$2a$11$Q4zfocJXiPb2sFXC8jfvt.YOKtHZY4HAAYIZ4bMcSM/mF3PN10KUK', 1, 1, CAST(N'2026-10-20T23:00:19.1503954' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (50, N'Isabela', N'Ospina Rincón', N'seed.estudiante.049@talentmatch.local', N'$2a$11$uxl.RrdQz3pKlg251hPL5OL7jq2RxkKkGAKtSWcAz70x7VlwZvbfy', 1, 1, CAST(N'2026-10-20T23:00:19.3668666' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (51, N'Daniel', N'Navarro Peña', N'seed.estudiante.050@talentmatch.local', N'$2a$11$TTTT.k1jwUubbUIWO.Wfy.SeHcolrLKYyUmBKvFI4n/wSANFCmaQO', 1, 1, CAST(N'2026-10-20T23:00:19.6725667' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (52, N'Luciana', N'Díaz Escobar', N'seed.estudiante.051@talentmatch.local', N'$2a$11$rEDVx99PFxzF/pPwY5rnpuR./g9.QMJdE8IplvmbMZKycrqIM11Me', 1, 1, CAST(N'2026-10-20T23:00:19.8994715' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (53, N'Tomás', N'Bermúdez Mejía', N'seed.estudiante.052@talentmatch.local', N'$2a$11$YO/vhYkUw4CV6SdnhEO0/OT0lxUfzTYufIP/j7JL0NWdQc5Cok9G2', 1, 1, CAST(N'2026-10-20T23:00:20.0836572' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (54, N'Antonella', N'Suárez Cárdenas', N'seed.estudiante.053@talentmatch.local', N'$2a$11$06xJ8ZSsq2XfxLwvQJnC2eEwT1dHSEIkIRum3J9Km7S6UN0LgtjaK', 1, 1, CAST(N'2026-10-20T23:00:20.2832170' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (55, N'Andrés', N'Vargas Cifuentes', N'seed.estudiante.054@talentmatch.local', N'$2a$11$E0efSXkigILTM7byAcaJje6mmCLsFg8L1ua9arC5Idn8udYSaAifm', 1, 1, CAST(N'2026-10-20T23:00:20.5232254' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (56, N'Julieta', N'Quintero Rojas', N'seed.estudiante.055@talentmatch.local', N'$2a$11$4j3.WqmzDLSiDd5U1jKaaOoMYj4VHn3B0ksFwdxU/WAIy5mARbD9u', 1, 1, CAST(N'2026-10-20T23:00:20.7205342' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (57, N'Emiliano', N'Castro Vargas', N'seed.estudiante.056@talentmatch.local', N'$2a$11$jKebVaAN/7v0FQm9ZdJEWegOWT4Wk91LoL9CfuuxPqDca2xL3IHh6', 1, 1, CAST(N'2026-10-20T23:00:20.9242239' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (58, N'Laura', N'Lozano Acosta', N'seed.estudiante.057@talentmatch.local', N'$2a$11$ZpoxPHKXabedm1uojpkD7OFVVr28hILJuAFgQkzUIMgvXA6Ci09ci', 1, 1, CAST(N'2026-10-20T23:00:21.1379808' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (59, N'Gabriel', N'Rueda Bustos', N'seed.estudiante.058@talentmatch.local', N'$2a$11$AmuMwgqmcUEWGqFvAtcO3u26wDE1RWNVehZu0RApuj1552w2FnOuW', 1, 1, CAST(N'2026-10-20T23:00:21.3946555' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (60, N'Paula', N'Pérez Molina', N'seed.estudiante.059@talentmatch.local', N'$2a$11$9HzNnt02eM/hwG18yMqZuuU78OnPx6iE2WL1rx8jGGvUfpZS76F36', 1, 1, CAST(N'2026-10-20T23:00:21.6181567' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (61, N'David', N'Silva Montoya', N'seed.estudiante.060@talentmatch.local', N'$2a$11$ZO.me9aAKfItpT4LhLMvVeebVts.gopNNSvkaujfR8YMBmbsbLCQG', 1, 1, CAST(N'2026-10-20T23:00:21.8373143' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (62, N'Valentina', N'Campos Ordóñez', N'seed.estudiante.061@talentmatch.local', N'$2a$11$/tG7gByXQ3GXfr3R.L.Hme2.gR0..OFH.hFYLbJQOeE92FrPRBzGa', 1, 1, CAST(N'2026-10-20T23:00:22.0298420' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (63, N'Mateo', N'Torres Quintero', N'seed.estudiante.062@talentmatch.local', N'$2a$11$x5IktQyOsrTI3FUB.K3PfOTH5uVMP5jGqD8xOcpYoxICzVlOHI6Da', 1, 1, CAST(N'2026-10-20T23:00:22.2361662' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (64, N'Camila', N'Patiño Galindo', N'seed.estudiante.063@talentmatch.local', N'$2a$11$6VkJsDYH0urMHJTLIJQr.uGEIUqxdSpWDZQzCwmWWstAbISx4wpV.', 1, 1, CAST(N'2026-10-20T23:00:22.4539695' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (65, N'Santiago', N'Escobar Niño', N'seed.estudiante.064@talentmatch.local', N'$2a$11$CqaMmziMdFMkbq9On/nfyef5AK6zK4eVLiXDsOZesN1yEmuQK0W8C', 1, 1, CAST(N'2026-10-20T23:00:22.6977164' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (66, N'Sofía', N'Ramírez Duarte', N'seed.estudiante.065@talentmatch.local', N'$2a$11$TuLi6K..70CYBcQ8goam5Os6hemwKHrArPQ0V/enw5nYv3vf9WA1q', 1, 1, CAST(N'2026-10-20T23:00:22.9082682' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (67, N'Nicolás', N'Cardona Guerrero', N'seed.estudiante.066@talentmatch.local', N'$2a$11$vgKj.yFNXcgEsxLmaqWM7eFOYUsiwlzOaTxgQXl.vYxaMy2UYkyNC', 1, 1, CAST(N'2026-10-20T23:00:23.1193898' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (68, N'Mariana', N'Valencia Duarte', N'seed.estudiante.067@talentmatch.local', N'$2a$11$CBtXQiQjR3UKvLMtN6X0QOy4S70mXS/JPk7dsNRPGjLYs/iu7Wr9.', 1, 1, CAST(N'2026-10-20T23:00:23.3088093' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (69, N'Samuel', N'Vega Beltrán', N'seed.estudiante.068@talentmatch.local', N'$2a$11$BgnFUrMvEBo6G9fFgUFKWOnFfJDqiw5gjAUKTHf6e0xsOvhHh6PHi', 1, 1, CAST(N'2026-10-20T23:00:23.5261010' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (70, N'Isabela', N'Bautista Salcedo', N'seed.estudiante.069@talentmatch.local', N'$2a$11$xhxfLPHKyfdS/nW./V3qCu70LNLx8fpMU9uw8oXn.sX/ihjMOvrai', 1, 1, CAST(N'2026-10-20T23:00:23.7204167' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (71, N'Daniel', N'Maldonado Prieto', N'seed.estudiante.070@talentmatch.local', N'$2a$11$8fX9OtBW0vKhho4i470lJOHZmU.zQcmNr4/NoTDpvGOyf88VkqZ7m', 1, 1, CAST(N'2026-10-20T23:00:23.9050573' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (72, N'Luciana', N'Mendoza Pardo', N'seed.estudiante.071@talentmatch.local', N'$2a$11$8V.GmyFWBlWvNyXiTd0ASeTSPQ20WqX0mvq0Zy0BP1vWZn/IZLUcC', 1, 1, CAST(N'2026-10-20T23:00:24.1249727' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (73, N'Tomás', N'Fonseca Ibarra', N'seed.estudiante.072@talentmatch.local', N'$2a$11$6KgqaiGmIhKfNbZIsW0Xou3TqQDeuEEy6cdf6TfTo9W636.W5Y.J.', 1, 1, CAST(N'2026-10-20T23:00:24.3230033' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (74, N'Antonella', N'Castañeda Ochoa', N'seed.estudiante.073@talentmatch.local', N'$2a$11$Fj1QBu3AGkfB4wiNNoxeNukdK4P9Rr56mnrNJkTTStUVGrPmGqXmW', 1, 1, CAST(N'2026-10-20T23:00:24.5202281' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (75, N'Andrés', N'García Restrepo', N'seed.estudiante.074@talentmatch.local', N'$2a$11$qEKovHubH0u6i0ukB5wLP.4Yih1.FONABKwZiK3k33sxO1ZloAwHi', 1, 1, CAST(N'2026-10-20T23:00:24.7250892' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (76, N'Julieta', N'Ariza Palacios', N'seed.estudiante.075@talentmatch.local', N'$2a$11$djZFUTAbio15pIdmQ.bpS.zZuQrP4DPUPOJ9WEe1T6gLvG0WBIOyO', 1, 1, CAST(N'2026-10-20T23:00:24.9234460' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (77, N'Emiliano', N'León Barrera', N'seed.estudiante.076@talentmatch.local', N'$2a$11$Ik4BOegV5JMryOfD9Yt5j.FAucx8wO6wHBGyvbVGNgFxVrrwfvYIi', 1, 1, CAST(N'2026-10-20T23:00:25.1324058' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (78, N'Laura', N'Cortés Pineda', N'seed.estudiante.077@talentmatch.local', N'$2a$11$am9xQQ54I3cH2oKZRTIklejl3PQcz37vMBbh/ZAEUT02jlGIkQLK2', 1, 1, CAST(N'2026-10-20T23:00:25.3363384' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (79, N'Gabriel', N'Cárdenas Quiroga', N'seed.estudiante.078@talentmatch.local', N'$2a$11$1mIw8Zms.WZ8rO9k7wlYEepDrzKhdmDiY2fwQ5.b1Wf31eg3b2X7S', 1, 1, CAST(N'2026-10-20T23:00:25.5230094' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (80, N'Paula', N'Pineda Cárdenas', N'seed.estudiante.079@talentmatch.local', N'$2a$11$vz4HjBBXTC2UBUcZGTxx1.nWZFpjn5h0WJmpk3w6Iw.5uKma4WOwC', 1, 1, CAST(N'2026-10-20T23:00:25.7164976' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (81, N'David', N'Herrera Robledo', N'seed.estudiante.080@talentmatch.local', N'$2a$11$xtAZ3c38/Rkd9A2VLhsMg.I2xqSPinkq6fTWLJQ.sdXuc6el3kMaS', 1, 1, CAST(N'2026-10-20T23:00:25.9094062' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (82, N'Valentina', N'Salazar Medina', N'seed.estudiante.081@talentmatch.local', N'$2a$11$icDroCcj0WvLmr4xmaSKZOWCGpcX8tgBVLDVxnhh0sSsWJ8Tnv5ua', 1, 1, CAST(N'2026-10-20T23:00:26.1284745' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (83, N'Mateo', N'Mejía Ceballos', N'seed.estudiante.082@talentmatch.local', N'$2a$11$9I.biQEXf8brCmeQwbA4.uiiTkL/mMEU3wWf1qPKXvHBPDiZ3qFfq', 1, 1, CAST(N'2026-10-20T23:00:26.3541865' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (84, N'Camila', N'Muñoz Roldán', N'seed.estudiante.083@talentmatch.local', N'$2a$11$ForABmREqTt3GMixSHRgvecA59bPzaPhuwE0MMyLjgYadHbRF0l.G', 1, 1, CAST(N'2026-10-20T23:00:26.5416195' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (85, N'Santiago', N'Mora Calderón', N'seed.estudiante.084@talentmatch.local', N'$2a$11$e4b7/vPWCmGxPaOK3padZ.qZXgGunZLvpViZnZXxTKFd9U4zOEqr6', 1, 1, CAST(N'2026-10-20T23:00:26.7408507' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (86, N'Sofía', N'Nieto Corredor', N'seed.estudiante.085@talentmatch.local', N'$2a$11$aYF2uURuio3yL58GqzauzuA4/EoY0i1GNtqvC0GU9ZzzVrdRto6AW', 1, 1, CAST(N'2026-10-20T23:00:26.9602697' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (87, N'Nicolás', N'Álvarez Castaño', N'seed.estudiante.086@talentmatch.local', N'$2a$11$cW6fTnPbb3l/v/sHXQSQfevw2jt2kwLVwZZb2Qho0PDt92K1dwnlS', 1, 1, CAST(N'2026-10-20T23:00:27.1690573' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (88, N'Mariana', N'Arias Trujillo', N'seed.estudiante.087@talentmatch.local', N'$2a$11$iXQQvnDeBt6imOys2wfTVe6F2hdBSX0jouPMg81qspawePRuh2FT2', 1, 1, CAST(N'2026-10-20T23:00:27.3619936' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (89, N'Samuel', N'Ríos Salazar', N'seed.estudiante.088@talentmatch.local', N'$2a$11$mms/MKAP/bx6jzsiGoG88OEaTfdcyn66lV8Dw0VKTMsMCVja6K.PW', 1, 1, CAST(N'2026-10-20T23:00:27.5855795' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (90, N'Isabela', N'Sánchez Valderrama', N'seed.estudiante.089@talentmatch.local', N'$2a$11$O2TiXEOaJc5.BLhUEg6Pb.qaHPMLL05JJhLx4hUWATW6wtXuFWfJ6', 1, 1, CAST(N'2026-10-20T23:00:27.8000114' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (91, N'Daniel', N'Guzmán Parra', N'seed.estudiante.090@talentmatch.local', N'$2a$11$atgr/AExwz8o7FsiFO14OuVg2GNeHxm6QleIl6lpoxg04Ry8KOJZu', 1, 1, CAST(N'2026-10-20T23:00:27.9871363' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (92, N'Luciana', N'Moreno Castillo', N'seed.estudiante.091@talentmatch.local', N'$2a$11$Te9NKybE3od/whu31Cxcp./J72lOIyBrv1nsuR7S8YeC7wlsYAiOC', 1, 1, CAST(N'2026-10-20T23:00:28.1926374' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (93, N'Tomás', N'Reyes Bermúdez', N'seed.estudiante.092@talentmatch.local', N'$2a$11$xTHUIpJCojKjiuq6H8oUX.oyX1Cgm4KPeRyytwt639qxrerxMpoTK', 1, 1, CAST(N'2026-10-20T23:00:28.4066878' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (94, N'Antonella', N'Ospina Rincón', N'seed.estudiante.093@talentmatch.local', N'$2a$11$lUwBXi8XokMElxcrMpU38OCxTGx1ItYzNqr9dt1qi5Cabd3J0/vti', 1, 1, CAST(N'2026-10-20T23:00:28.6012952' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (95, N'Andrés', N'Navarro Peña', N'seed.estudiante.094@talentmatch.local', N'$2a$11$b/JcR.bKbQpiDfRKr5LiQ.y3f602nreEHpYxwhTunIh4CR0neF1MK', 1, 1, CAST(N'2026-10-20T23:00:28.8054811' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (96, N'Julieta', N'Díaz Escobar', N'seed.estudiante.095@talentmatch.local', N'$2a$11$DL7rGoRrodxt8cBDxSq8KeZInSVssiicUcmXoiYeHhgeLxYjnjUk6', 1, 1, CAST(N'2026-10-20T23:00:29.0210332' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (97, N'Emiliano', N'Bermúdez Mejía', N'seed.estudiante.096@talentmatch.local', N'$2a$11$bsvTgP/YdiV/tGRJ9T4xWuM1VXMbkyZzgPDQ48GteyLWUMSpZKuhe', 1, 1, CAST(N'2026-10-20T23:00:29.2531368' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (98, N'Laura', N'Suárez Cárdenas', N'seed.estudiante.097@talentmatch.local', N'$2a$11$A/WmTonGTu9N0/ZarjGwYukQ3NJH0Eeal8DqnAiS/7Dlz91.2dCSW', 1, 1, CAST(N'2026-10-20T23:00:29.4652542' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (99, N'Gabriel', N'Vargas Cifuentes', N'seed.estudiante.098@talentmatch.local', N'$2a$11$tNwqycTHMuCvZLg5MKE56ex1sFKuPu0bNjx9IJXiayYK9pR9hM7sa', 1, 1, CAST(N'2026-10-20T23:00:29.6601375' AS DateTime2))
GO
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (100, N'Paula', N'Quintero Rojas', N'seed.estudiante.099@talentmatch.local', N'$2a$11$wx3Vt.J0QBC0B5JofDXSUuhsjMxHHCi6qZnjIbgKAVgJEuHZbuML6', 1, 1, CAST(N'2026-10-20T23:00:29.8590274' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (101, N'David', N'Pérez Molina', N'seed.estudiante.100@talentmatch.local', N'$2a$11$jgctthucABRCDvvgIaQTJ.pLTZbeEIJOAPjdi2jcYNKU9fV3ctb0W', 1, 1, CAST(N'2026-10-20T23:00:30.0704258' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (102, N'Adriana', N'Miranda', N'seed.profesor@talentmatch.local', N'$2a$11$OMYWRqzPwQmPgsXHHxjQdehG9W9EM6Tt./5Lojeo.1f9gmq0SR1YS', 2, 1, CAST(N'2026-10-20T23:00:30.2690805' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (103, N'Rafael', N'Velasco', N'seed.profesor.002@talentmatch.local', N'$2a$11$HeIs.9hnKF.Q1O1QSSf03eDbf7FlGdPRLlIff7GLEYdfWp0AbCjOG', 2, 1, CAST(N'2026-10-20T23:00:30.5251644' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (104, N'Elena', N'Bermúdez', N'seed.profesor.003@talentmatch.local', N'$2a$11$.6aOFJYtHWF21qUbxmEH4eSoXIoAdHxlVMLldBwxyYKfZ/7zvumNO', 2, 1, CAST(N'2026-10-20T23:00:30.7332486' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (105, N'Ignacio', N'Serrano', N'seed.profesor.004@talentmatch.local', N'$2a$11$35UMGHpyJgTXib73D93HqemsZcclJHIeHDIMi2alATinopCeRCetC', 2, 1, CAST(N'2026-10-20T23:00:30.9604391' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (106, N'Mariana', N'Cortés', N'seed.profesor.005@talentmatch.local', N'$2a$11$.VZCVSKrbf8eoJTk6naVkOZ/xh.69js4Bgx7v1g4m9OAKk7cuwSs6', 2, 1, CAST(N'2026-10-20T23:00:31.1555137' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (107, N'Federico', N'Pinto', N'seed.profesor.006@talentmatch.local', N'$2a$11$lgHY7t3ab03RhUkt5t.jfukMfTcqONoxrX3uMWhc5RpWox.gKrsNm', 2, 1, CAST(N'2026-10-20T23:00:31.3702929' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (108, N'Natalia', N'Robledo', N'seed.profesor.007@talentmatch.local', N'$2a$11$PTxjaQb7J2jb8WFZJp91JOMIDNo/mLTwcRr3.iwg7x0YIutDajh.y', 2, 1, CAST(N'2026-10-20T23:00:31.5629118' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (109, N'Álvaro', N'Peña', N'seed.profesor.008@talentmatch.local', N'$2a$11$b88iYGyHtVLitbcz4xWGZ.qpQQGsx8kOb24Tuvda3v9YU431sf3le', 2, 1, CAST(N'2026-10-20T23:00:31.7737289' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (110, N'Beatriz', N'Londoño', N'seed.profesor.009@talentmatch.local', N'$2a$11$j83VG5XQ2JeZRvuXG3GdhOIRZDZJsmcxDSYVuc3Mf3qZBwaRi6Byi', 2, 1, CAST(N'2026-10-20T23:00:31.9805702' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (111, N'Sergio', N'Valdés', N'seed.profesor.010@talentmatch.local', N'$2a$11$DZyIxVYlQVX/QI4AMqkzZ.F4.I0lNeTqwGP.t00JffC2O0N2BbBe2', 2, 1, CAST(N'2026-10-20T23:00:32.1897180' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (112, N'Claudia', N'Parra', N'seed.profesor.011@talentmatch.local', N'$2a$11$pBt6of0ejyhqawaMi4oeVe/qJxP0Q/vNXMj55IxwSLCqEaL5Iv4eG', 2, 1, CAST(N'2026-10-20T23:00:32.4199031' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (113, N'Hernán', N'Ibáñez', N'seed.profesor.012@talentmatch.local', N'$2a$11$DLbf3mBEOhOl/J49bs3epe.DZvcZINDHO/xQuQMocL538SV5llI6O', 2, 1, CAST(N'2026-10-20T23:00:32.6400149' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (114, N'Patricia', N'Roldán', N'seed.profesor.013@talentmatch.local', N'$2a$11$EnSWQuaDyL8NrzESQmVAS.nwIZUqCRgltNRf0iSoyBs09joDwVFAi', 2, 1, CAST(N'2026-10-20T23:00:32.8447014' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (115, N'Mauricio', N'Correa', N'seed.profesor.014@talentmatch.local', N'$2a$11$7kRpjTysQFKUMoynWd9Tp.0LFf2nbcm/U3qBX9/CU14ToQ0jgXwA.', 2, 1, CAST(N'2026-10-20T23:00:33.0529262' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (116, N'Lorena', N'Buitrago', N'seed.profesor.015@talentmatch.local', N'$2a$11$F2N8p4hjyljeg/lr16CEHOXQzcrWZn8lulzha34mqgZiNR6UM7rla', 2, 1, CAST(N'2026-10-20T23:00:33.2596001' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (117, N'yuliana', N'mazabel', N'yulianaamq@gmail.com', N'$2a$11$xbMdk4gcg7qU5om1t5XpUufz.laLiPDVpE1MnP3DOBbsIOKyik1sG', 1, 1, CAST(N'2026-10-22T00:56:40.3723916' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (118, N'Wilmer', N'rodriguez', N'wilmer@jajajja.com', N'$2a$11$LQMVCJC4DyKMrRH1K9YpuObCSvvaN7Fef6LBECPjjzxpUqjuvnUQO', 2, 1, CAST(N'2026-10-22T01:01:57.5986390' AS DateTime2))
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Apellido], [Correo], [PasswordHash], [Rol], [Activo], [FechaRegistro]) VALUES (119, N'Tatiana', N'Mazabel', N'tatianamazabel@estudiante.com', N'$2a$11$nQnNlCCqcrTSGvN/ZjziWuSToYwAJLhweYGeDsu8GKWkvjcdSJ/AC', 1, 1, CAST(N'2026-10-22T15:19:49.9115874' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
ALTER TABLE [dbo].[InvitacionesEquipo] ADD  CONSTRAINT [DF_InvitacionesEquipo_Estado]  DEFAULT ((1)) FOR [Estado]
GO
ALTER TABLE [dbo].[InvitacionesEquipo] ADD  CONSTRAINT [DF_InvitacionesEquipo_FechaCreacion]  DEFAULT (sysutcdatetime()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Proyectos] ADD  CONSTRAINT [DF_Proyectos_Tipo]  DEFAULT ((1)) FOR [Tipo]
GO
ALTER TABLE [dbo].[Usuarios] ADD  DEFAULT (CONVERT([bit],(1))) FOR [Activo]
GO
ALTER TABLE [dbo].[Conversaciones]  WITH CHECK ADD  CONSTRAINT [FK_Conversaciones_Usuarios_UsuarioAId] FOREIGN KEY([UsuarioAId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[Conversaciones] CHECK CONSTRAINT [FK_Conversaciones_Usuarios_UsuarioAId]
GO
ALTER TABLE [dbo].[Conversaciones]  WITH CHECK ADD  CONSTRAINT [FK_Conversaciones_Usuarios_UsuarioBId] FOREIGN KEY([UsuarioBId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[Conversaciones] CHECK CONSTRAINT [FK_Conversaciones_Usuarios_UsuarioBId]
GO
ALTER TABLE [dbo].[Equipos]  WITH CHECK ADD  CONSTRAINT [FK_Equipos_Estudiantes_LiderEstudianteId] FOREIGN KEY([LiderEstudianteId])
REFERENCES [dbo].[Estudiantes] ([Id])
GO
ALTER TABLE [dbo].[Equipos] CHECK CONSTRAINT [FK_Equipos_Estudiantes_LiderEstudianteId]
GO
ALTER TABLE [dbo].[Equipos]  WITH CHECK ADD  CONSTRAINT [FK_Equipos_Proyectos_ProyectoId] FOREIGN KEY([ProyectoId])
REFERENCES [dbo].[Proyectos] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Equipos] CHECK CONSTRAINT [FK_Equipos_Proyectos_ProyectoId]
GO
ALTER TABLE [dbo].[EstudianteHabilidades]  WITH CHECK ADD  CONSTRAINT [FK_EstudianteHabilidades_Estudiantes_EstudianteId] FOREIGN KEY([EstudianteId])
REFERENCES [dbo].[Estudiantes] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EstudianteHabilidades] CHECK CONSTRAINT [FK_EstudianteHabilidades_Estudiantes_EstudianteId]
GO
ALTER TABLE [dbo].[EstudianteHabilidades]  WITH CHECK ADD  CONSTRAINT [FK_EstudianteHabilidades_Habilidades_HabilidadId] FOREIGN KEY([HabilidadId])
REFERENCES [dbo].[Habilidades] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EstudianteHabilidades] CHECK CONSTRAINT [FK_EstudianteHabilidades_Habilidades_HabilidadId]
GO
ALTER TABLE [dbo].[EstudianteIntereses]  WITH CHECK ADD  CONSTRAINT [FK_EstudianteIntereses_Estudiantes_EstudianteId] FOREIGN KEY([EstudianteId])
REFERENCES [dbo].[Estudiantes] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EstudianteIntereses] CHECK CONSTRAINT [FK_EstudianteIntereses_Estudiantes_EstudianteId]
GO
ALTER TABLE [dbo].[EstudianteIntereses]  WITH CHECK ADD  CONSTRAINT [FK_EstudianteIntereses_Intereses_InteresId] FOREIGN KEY([InteresId])
REFERENCES [dbo].[Intereses] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EstudianteIntereses] CHECK CONSTRAINT [FK_EstudianteIntereses_Intereses_InteresId]
GO
ALTER TABLE [dbo].[Estudiantes]  WITH CHECK ADD  CONSTRAINT [FK_Estudiantes_Usuarios_UsuarioId] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuarios] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Estudiantes] CHECK CONSTRAINT [FK_Estudiantes_Usuarios_UsuarioId]
GO
ALTER TABLE [dbo].[InvitacionesEquipo]  WITH CHECK ADD  CONSTRAINT [FK_InvitacionesEquipo_Destinatario] FOREIGN KEY([DestinatarioUsuarioId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[InvitacionesEquipo] CHECK CONSTRAINT [FK_InvitacionesEquipo_Destinatario]
GO
ALTER TABLE [dbo].[InvitacionesEquipo]  WITH CHECK ADD  CONSTRAINT [FK_InvitacionesEquipo_Equipos] FOREIGN KEY([EquipoId])
REFERENCES [dbo].[Equipos] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[InvitacionesEquipo] CHECK CONSTRAINT [FK_InvitacionesEquipo_Equipos]
GO
ALTER TABLE [dbo].[InvitacionesEquipo]  WITH CHECK ADD  CONSTRAINT [FK_InvitacionesEquipo_Remitente] FOREIGN KEY([RemitenteUsuarioId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[InvitacionesEquipo] CHECK CONSTRAINT [FK_InvitacionesEquipo_Remitente]
GO
ALTER TABLE [dbo].[Mensajes]  WITH CHECK ADD  CONSTRAINT [FK_Mensajes_Conversaciones_ConversacionId] FOREIGN KEY([ConversacionId])
REFERENCES [dbo].[Conversaciones] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Mensajes] CHECK CONSTRAINT [FK_Mensajes_Conversaciones_ConversacionId]
GO
ALTER TABLE [dbo].[Mensajes]  WITH CHECK ADD  CONSTRAINT [FK_Mensajes_Usuarios_RemitenteId] FOREIGN KEY([RemitenteId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[Mensajes] CHECK CONSTRAINT [FK_Mensajes_Usuarios_RemitenteId]
GO
ALTER TABLE [dbo].[MiembrosEquipo]  WITH CHECK ADD  CONSTRAINT [FK_MiembrosEquipo_Equipos_EquipoId] FOREIGN KEY([EquipoId])
REFERENCES [dbo].[Equipos] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MiembrosEquipo] CHECK CONSTRAINT [FK_MiembrosEquipo_Equipos_EquipoId]
GO
ALTER TABLE [dbo].[MiembrosEquipo]  WITH CHECK ADD  CONSTRAINT [FK_MiembrosEquipo_Estudiantes_EstudianteId] FOREIGN KEY([EstudianteId])
REFERENCES [dbo].[Estudiantes] ([Id])
GO
ALTER TABLE [dbo].[MiembrosEquipo] CHECK CONSTRAINT [FK_MiembrosEquipo_Estudiantes_EstudianteId]
GO
ALTER TABLE [dbo].[Notificaciones]  WITH CHECK ADD  CONSTRAINT [FK_Notificaciones_Usuarios_UsuarioId] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuarios] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Notificaciones] CHECK CONSTRAINT [FK_Notificaciones_Usuarios_UsuarioId]
GO
ALTER TABLE [dbo].[Perfiles]  WITH CHECK ADD  CONSTRAINT [FK_Perfiles_Usuarios_UsuarioId] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuarios] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Perfiles] CHECK CONSTRAINT [FK_Perfiles_Usuarios_UsuarioId]
GO
ALTER TABLE [dbo].[Postulaciones]  WITH CHECK ADD  CONSTRAINT [FK_Postulaciones_Estudiantes_EstudianteId] FOREIGN KEY([EstudianteId])
REFERENCES [dbo].[Estudiantes] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Postulaciones] CHECK CONSTRAINT [FK_Postulaciones_Estudiantes_EstudianteId]
GO
ALTER TABLE [dbo].[Postulaciones]  WITH CHECK ADD  CONSTRAINT [FK_Postulaciones_Proyectos_ProyectoId] FOREIGN KEY([ProyectoId])
REFERENCES [dbo].[Proyectos] ([Id])
GO
ALTER TABLE [dbo].[Postulaciones] CHECK CONSTRAINT [FK_Postulaciones_Proyectos_ProyectoId]
GO
ALTER TABLE [dbo].[Profesores]  WITH CHECK ADD  CONSTRAINT [FK_Profesores_Usuarios_UsuarioId] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuarios] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Profesores] CHECK CONSTRAINT [FK_Profesores_Usuarios_UsuarioId]
GO
ALTER TABLE [dbo].[ProyectoHabilidades]  WITH CHECK ADD  CONSTRAINT [FK_ProyectoHabilidades_Habilidades_HabilidadId] FOREIGN KEY([HabilidadId])
REFERENCES [dbo].[Habilidades] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProyectoHabilidades] CHECK CONSTRAINT [FK_ProyectoHabilidades_Habilidades_HabilidadId]
GO
ALTER TABLE [dbo].[ProyectoHabilidades]  WITH CHECK ADD  CONSTRAINT [FK_ProyectoHabilidades_Proyectos_ProyectoId] FOREIGN KEY([ProyectoId])
REFERENCES [dbo].[Proyectos] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProyectoHabilidades] CHECK CONSTRAINT [FK_ProyectoHabilidades_Proyectos_ProyectoId]
GO
ALTER TABLE [dbo].[ProyectoIntereses]  WITH CHECK ADD  CONSTRAINT [FK_ProyectoIntereses_Intereses_InteresId] FOREIGN KEY([InteresId])
REFERENCES [dbo].[Intereses] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProyectoIntereses] CHECK CONSTRAINT [FK_ProyectoIntereses_Intereses_InteresId]
GO
ALTER TABLE [dbo].[ProyectoIntereses]  WITH CHECK ADD  CONSTRAINT [FK_ProyectoIntereses_Proyectos_ProyectoId] FOREIGN KEY([ProyectoId])
REFERENCES [dbo].[Proyectos] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProyectoIntereses] CHECK CONSTRAINT [FK_ProyectoIntereses_Proyectos_ProyectoId]
GO
ALTER TABLE [dbo].[Proyectos]  WITH CHECK ADD  CONSTRAINT [FK_Proyectos_Estudiantes_CreadorEstudianteId] FOREIGN KEY([CreadorEstudianteId])
REFERENCES [dbo].[Estudiantes] ([Id])
GO
ALTER TABLE [dbo].[Proyectos] CHECK CONSTRAINT [FK_Proyectos_Estudiantes_CreadorEstudianteId]
GO
ALTER TABLE [dbo].[Proyectos]  WITH CHECK ADD  CONSTRAINT [FK_Proyectos_Profesores_ProfesorId] FOREIGN KEY([ProfesorId])
REFERENCES [dbo].[Profesores] ([Id])
GO
ALTER TABLE [dbo].[Proyectos] CHECK CONSTRAINT [FK_Proyectos_Profesores_ProfesorId]
GO
ALTER TABLE [dbo].[Recomendaciones]  WITH CHECK ADD  CONSTRAINT [FK_Recomendaciones_Estudiantes_EstudianteId] FOREIGN KEY([EstudianteId])
REFERENCES [dbo].[Estudiantes] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Recomendaciones] CHECK CONSTRAINT [FK_Recomendaciones_Estudiantes_EstudianteId]
GO
ALTER TABLE [dbo].[Recomendaciones]  WITH CHECK ADD  CONSTRAINT [FK_Recomendaciones_Proyectos_ProyectoId] FOREIGN KEY([ProyectoId])
REFERENCES [dbo].[Proyectos] ([Id])
GO
ALTER TABLE [dbo].[Recomendaciones] CHECK CONSTRAINT [FK_Recomendaciones_Proyectos_ProyectoId]
GO
ALTER TABLE [dbo].[Conversaciones]  WITH CHECK ADD  CONSTRAINT [CK_Conversaciones_Usuarios_Orden] CHECK  (([UsuarioAId]<[UsuarioBId]))
GO
ALTER TABLE [dbo].[Conversaciones] CHECK CONSTRAINT [CK_Conversaciones_Usuarios_Orden]
GO
ALTER TABLE [dbo].[InvitacionesEquipo]  WITH CHECK ADD  CONSTRAINT [CK_InvitacionesEquipo_Estado] CHECK  (([Estado]=(4) OR [Estado]=(3) OR [Estado]=(2) OR [Estado]=(1)))
GO
ALTER TABLE [dbo].[InvitacionesEquipo] CHECK CONSTRAINT [CK_InvitacionesEquipo_Estado]
GO
ALTER TABLE [dbo].[Proyectos]  WITH CHECK ADD  CONSTRAINT [CK_Proyectos_Tipo] CHECK  (([Tipo]=(2) OR [Tipo]=(1)))
GO
ALTER TABLE [dbo].[Proyectos] CHECK CONSTRAINT [CK_Proyectos_Tipo]
GO
