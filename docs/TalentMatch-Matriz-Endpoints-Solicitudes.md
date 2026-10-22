# Matriz real de endpoints: Solicitudes

Esta matriz se basa únicamente en los contratos encontrados en el código fuente actual. No representa endpoints propuestos.

| Rol | Acción | Endpoint | Autorización | Estado |
|---|---|---|---|---|
| Estudiante | Ver mis postulaciones | `GET /api/v1/Postulaciones/mias` | `[Authorize(Roles = "Estudiante")]` y validación de rol en servicio | Reutilizado |
| Estudiante | Crear postulación | `POST /api/v1/Postulaciones` | `[Authorize(Roles = "Estudiante")]`; el servicio valida identidad propia | Existente, fuera de la carga de Solicitudes |
| Profesor | Ver postulaciones de proyecto | `GET /api/v1/Postulaciones/proyecto/{proyectoId}` | `[Authorize(Roles = "Profesor,Administrador")]`; el servicio valida propietario para Profesor | Reutilizado para Profesor |
| Profesor | Aceptar postulación | `PUT /api/v1/Postulaciones/{id}/aceptar` | `[Authorize(Roles = "Profesor")]`; el servicio valida propietario y estado Pendiente | Verificado |
| Profesor | Rechazar postulación | `PUT /api/v1/Postulaciones/{id}/rechazar` | `[Authorize(Roles = "Profesor")]`; el servicio valida propietario y estado Pendiente | Verificado |
| Administrador | Supervisar postulaciones | No existe endpoint global encontrado | No existe contrato administrativo específico | Documentado como ausente |
| Estudiante | Invitaciones recibidas | No existe contrato encontrado | No aplica | Pendiente |
| Estudiante | Invitaciones enviadas | No existe contrato encontrado | No aplica | Pendiente |
| Administrador | Supervisar invitaciones | No existe contrato encontrado | No aplica | Pendiente |

## Estrategia actual de carga

- Estudiante: una llamada a `myApplications()`.
- Profesor: `projects()`, filtrado por `profesorId === user.id` y una llamada `applicationsByProject(project.id)` por cada proyecto propio.
- Administrador: no existe un endpoint global administrativo. La pantalla no realiza llamadas de postulaciones y muestra un estado informativo en lugar de simular supervisión.

## Contratos ausentes

No se encontraron `InvitacionEquipo`, controller, service, repository, DTO ni métodos frontend. No se muestran tabs funcionales ni se realizan llamadas ficticias.

El DTO real de postulaciones expone `EstudianteId`, `ProyectoId`, `Estado`, `Mensaje`, `FechaPostulacion` y `Proyecto`. No expone nombre, carrera ni semestre del estudiante.
