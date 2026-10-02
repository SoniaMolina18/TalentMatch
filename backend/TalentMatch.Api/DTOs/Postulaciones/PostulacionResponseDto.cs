using TalentMatch.Api.Domain.Enums;

namespace TalentMatch.Api.DTOs.Postulaciones;

public class PostulacionResponseDto
{
    public int Id { get; set; }
    public int EstudianteId { get; set; }
    public int ProyectoId { get; set; }
    public EstadoPostulacion Estado { get; set; }
    public string? Mensaje { get; set; }
    public DateTime FechaPostulacion { get; set; }
}
