using TalentMatch.Api.Domain.Enums;

namespace TalentMatch.Api.DTOs.Equipos;

public class EquipoResponseDto
{
    public int Id { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public int ProyectoId { get; set; }
    public EstadoEquipo Estado { get; set; }
    public DateTime FechaCreacion { get; set; }
}
