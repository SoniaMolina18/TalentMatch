# TalentMatch — modelo de datos de la Fase B

## DbContext definitivo

La migración inicial utilizará exclusivamente `TalentMatch.Api.Data.TalentMatchDbContext` y las entidades de `TalentMatch.Api.Domain.Entities`.

`TalentMatch.Infrastructure.Data.TalentMatchDbContext` y `TalentMatch.Domain.Domain.Entities` se conservan sin eliminar, pero no están registrados por `TalentMatch.Api` y no participan en la migración.

## Entidades incluidas

- Usuarios, estudiantes, profesores y perfiles.
- Habilidades e intereses.
- Proyectos y equipos.
- Integrantes de equipos.
- Postulaciones.
- Recomendaciones.
- Notificaciones.
- Tablas puente de habilidades e intereses de estudiantes y proyectos.

## Restricciones e índices

Se mantienen las claves primarias y foráneas existentes, además de índices únicos para correos, códigos de estudiante/profesor, nombres de habilidades/intereses y combinaciones de tablas puente. También se mantiene la unicidad de estudiante-proyecto en postulaciones y equipo-estudiante en integrantes.

## Cascadas SQL Server

Las relaciones que podían crear múltiples rutas de eliminación en cascada se configuran con `DeleteBehavior.NoAction`:

- `Proyecto -> Postulacion`.
- `Proyecto -> Recomendacion`.
- `Estudiante -> MiembroEquipo`.

Esto mantiene la integridad referencial y evita que SQL Server rechace la migración por múltiples rutas de cascada. Las eliminaciones de estas entidades dependientes deberán gestionarse explícitamente en operaciones posteriores.

## Persistencia en Development

`Persistence:UseRealServices` controla la implementación de `IUsuarioService` e `IEquipoService`:

- `false`: servicios simulados de Development.
- `true`: servicios reales y repositorios con SQL Server.

`Persistence:SeedDevelopment` habilita el seed únicamente cuando el entorno es Development y los servicios reales están activos. El seed no ejecuta migraciones automáticamente y nunca se ejecuta en Production.
