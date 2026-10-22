# Pruebas funcionales manuales de TalentMatch

Estas pruebas deben ejecutarse manualmente después de disponer de la API, el frontend y una base de datos respaldada. No incluyen migraciones, seeders ni modificaciones directas de datos.

## Preparación

- Usar una cuenta existente de cada rol: `Administrador`, `Profesor` y `Estudiante`.
- Confirmar que el token se conserva en la sesión del navegador.
- Registrar los identificadores de un proyecto, una postulación, un equipo y un estudiante de prueba.
- Verificar que la base de datos contiene los datos esperados antes y después de las pruebas.

## Administrador

1. Iniciar sesión y confirmar acceso a `/admin`.
2. Confirmar que `/talentos` es accesible y que muestra resultados filtrables.
3. Consultar usuarios y proyectos desde el panel administrativo.
4. Crear un usuario Estudiante y otro Profesor con datos válidos.
5. Editar un usuario y asignar el rol Profesor a un usuario Estudiante.
7. Marcar como leída una notificación propia y comprobar que el contador cambia.
8. Consultar las postulaciones desde Solicitudes, probar filtros por proyecto, estudiante y estado, y confirmar que no aparecen acciones de aceptar o rechazar.
9. Intentar acceder a una ruta inexistente o a recursos ajenos y comprobar una respuesta segura (`403` o redirección).

## Profesor

1. Iniciar sesión y confirmar acceso a `/profesor` y `/talentos`.
2. Crear, editar y eliminar un proyecto propio.
3. Consultar las postulaciones del proyecto propio.
4. Aceptar y rechazar postulaciones del proyecto propio.
5. Crear un equipo para un proyecto propio y añadir un estudiante.
6. En el panel del Profesor, seleccionar un equipo, comprobar sus integrantes y asignar como líder a uno de ellos.
7. Confirmar que el líder aparece actualizado y que el equipo queda disponible para la gestión de invitaciones del estudiante líder.
8. Intentar asignar como líder a un estudiante que no pertenece al equipo; debe devolver `400`.
9. Iniciar una conversación desde Encontrar talentos, abrir `/mensajes`, enviar un mensaje y comprobar que la conversación se marca como leída.
10. Intentar modificar o eliminar el proyecto de otro profesor; debe devolver `403`.
11. Intentar consultar o asignar líder en un equipo de otro profesor; debe devolver `403`.
12. Intentar consultar postulaciones de un proyecto de otro profesor; debe devolver `403`.

## Estudiante

1. Registrarse o iniciar sesión y confirmar acceso a `/dashboard`, `/proyectos`, `/perfil`, `/equipo`, `/solicitudes` y `/mensajes`.
2. Consultar proyectos y actualizar el perfil propio.
3. Crear una postulación propia y comprobarla en `/solicitudes`.
4. Confirmar que una postulación aceptada o rechazada refleja el estado correcto.
5. Consultar los equipos propios y sus integrantes.
6. Abrir una conversación iniciada por un profesor, enviar un mensaje y verificar su contenido y fecha.
7. Acceder a `/talentos` y comprobar que la búsqueda de estudiantes funciona; `/admin` y `/profesor` deben redirigir a `/dashboard`.
8. Abrir Encontrar talentos, comprobar que solo aparecen equipos activos cuyo `liderUsuarioId` coincide con el usuario y que los equipos sin líder no aparecen.
9. Enviar una invitación con mensaje opcional y comprobar la notificación recibida.
10. En Solicitudes, aceptar una invitación pendiente y comprobar que aparece en Mi equipo mediante `GET /api/v1/Equipos/mios`.
11. Rechazar una invitación y comprobar la notificación al remitente; cancelar una enviada y comprobar que deja de estar pendiente.
12. Intentar crear, aceptar, rechazar o cancelar invitaciones con usuario no autorizado, destinatario distinto o invitación no pendiente; debe devolver `403` o `409`.
13. Intentar crear, aceptar o rechazar postulaciones con permisos incorrectos; debe devolver `403`.
14. Intentar consultar o modificar el perfil de otro usuario; debe devolver `403`.

## Mensajes y migración pendiente

- La migración `backend/TalentMatch.Api/Migrations/20261022000100_AddMessaging.sql` se mantiene sin ejecutar.
- Antes de aplicarla manualmente, revisar respaldo, existencia de las tablas `Usuarios`, nombres de índices y claves foráneas.
- Tras la aplicación manual, repetir las pruebas de conversaciones, envío y marcado de lectura.
- Si las tablas todavía no existen, las pantallas de Mensajes deben mostrar el error del API sin alterar otros datos.

## Solicitudes e invitaciones

- `GET /api/v1/Postulaciones/mias` es exclusivo de `Estudiante`; Profesor y Administrador no deben invocarlo.
- Profesor consulta `GET /api/v1/Postulaciones/proyecto/{proyectoId}` únicamente para proyectos propios; la API debe responder `403` para un proyecto de otro Profesor.
- Administrador muestra que la supervisión no está disponible mientras no exista un contrato administrativo explícito; no realiza llamadas de postulaciones ni dispone de aceptar/rechazar ordinario.
- Las invitaciones de equipo usan un contrato independiente de postulaciones y solo están disponibles para Estudiante.
- Los equipos existentes sin líder explícito no son gestionables. Se requiere asignación explícita de líder mediante una operación autorizada.
- La asignación de líder no modifica automáticamente ningún equipo; cada asignación debe realizarla el Profesor propietario y el candidato debe ser miembro actual.
- Antes de probar el flujo real debe aplicarse, con aprobación y respaldo, `20261101000100_AddTeamInvitations.sql`; no se ejecuta ninguna migración como parte de estas pruebas.
