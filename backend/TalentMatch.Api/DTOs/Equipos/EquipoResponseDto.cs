using TalentMatch.Api.Domain.Enums;

namespace TalentMatch.Api.DTOs.Equipos;

public class EquipoResponseDto
{
    public int Id { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public int ProyectoId { get; set; }
    public int? LiderUsuarioId { get; set; }
    public EstadoEquipo Estado { get; set; }
    public DateTime FechaCreacion { get; set; }
    public ProyectoEquipoDto? Proyecto { get; set; }
    public IReadOnlyCollection<MiembroEquipoDto> Miembros { get; set; } = Array.Empty<MiembroEquipoDto>();
}

public class ProyectoEquipoDto
{
    public int Id { get; set; }
    public string Titulo { get; set; } = string.Empty;
    public string Descripcion { get; set; } = string.Empty;
    public DateTime? FechaLimite { get; set; }
    public int? ProfesorId { get; set; }
    public int CuposDisponibles { get; set; }
}

public class MiembroEquipoDto
{
    public int EstudianteId { get; set; }
    public int UsuarioId { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public string Apellido { get; set; } = string.Empty;
    public DateTime FechaIngreso { get; set; }
}
