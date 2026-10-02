using TalentMatch.Api.Domain.Enums;

namespace TalentMatch.Api.DTOs.Proyectos;

public class ProyectoResponseDto
{
    public int Id { get; set; }
    public string Titulo { get; set; } = string.Empty;
    public string Descripcion { get; set; } = string.Empty;
    public EstadoProyecto Estado { get; set; }
    public DateTime FechaCreacion { get; set; }
    public DateTime FechaLimite { get; set; }
    public int CuposDisponibles { get; set; }
    public int ProfesorId { get; set; }
}
