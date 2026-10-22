# Invitaciones a equipos

El vertical de invitaciones está preparado en la API y el frontend, pero requiere aplicar manualmente la migración SQL antes de operar contra la base de datos actual. No se han creado datos ficticios ni se ha ejecutado la migración.

## Modelo propuesto

- `Id`
- `EquipoId`
- `RemitenteUsuarioId`
- `DestinatarioUsuarioId`
- `Mensaje`
- `Estado`
- `FechaCreacion`
- `FechaRespuesta`

`Equipo.LiderEstudianteId` es nullable. Los equipos existentes sin `LiderEstudianteId` no son gestionables para invitaciones. Se requiere asignación explícita de líder mediante una operación autorizada.

Estados: `Pendiente`, `Aceptada`, `Rechazada`, `Cancelada`.

## Endpoints propuestos

- `GET /api/v1/InvitacionesEquipo/recibidas` — Estudiante autenticado.
- `GET /api/v1/InvitacionesEquipo/enviadas` — Estudiante autenticado.
- `POST /api/v1/InvitacionesEquipo` — estudiante que es el líder explícito del equipo.
- `PUT /api/v1/InvitacionesEquipo/{id}/aceptar` — destinatario autenticado.
- `PUT /api/v1/InvitacionesEquipo/{id}/rechazar` — destinatario autenticado.
- `PUT /api/v1/InvitacionesEquipo/{id}/cancelar` — remitente autenticado mientras esté pendiente.

## Reglas obligatorias

- Impedir invitarse a sí mismo y destinatarios que no sean Estudiantes.
- Validar que el remitente controla el equipo y que el destinatario no pertenece ya al equipo.
- Impedir invitaciones pendientes duplicadas y validar cupos.
- Al aceptar, agregar el miembro de forma transaccional y respetar el índice único de `MiembrosEquipo`.
- Notificar al destinatario al crear la invitación y al remitente al aceptar o rechazarla.
- La migración de estas tablas debe prepararse y revisarse con backup antes de ejecutarse; no forma parte de esta corrección.

## Liderazgo y creación de equipos

El flujo actual de creación de equipos pertenece al Profesor y no establece automáticamente `LiderEstudianteId`. Por seguridad, no se infiere el líder por pertenencia, primer miembro, usuario autenticado, rol Profesor ni propietario del proyecto. Hasta contar con una operación autorizada para asignarlo, los equipos nuevos creados por ese flujo tampoco son gestionables por estudiantes.

El Profesor propietario puede asignar o cambiar explícitamente el líder mediante:

- `PUT /api/v1/Equipos/{equipoId}/lider`
- Body: `{ "estudianteId": 25 }`

La operación exige que el usuario autenticado tenga rol `Profesor`, sea propietario del proyecto asociado y que el estudiante ya pertenezca a `MiembrosEquipo`. El Administrador no dispone de este endpoint.

## Estado de migración

La migración preparada es `backend/TalentMatch.Api/Migrations/20261101000100_AddTeamInvitations.sql`. Requiere aprobación, respaldo y revisión de nombres de tablas, claves foráneas e índices antes de tocar SQL Server.
