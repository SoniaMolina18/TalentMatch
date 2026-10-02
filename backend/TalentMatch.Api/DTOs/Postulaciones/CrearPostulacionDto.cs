using System.ComponentModel.DataAnnotations;

namespace TalentMatch.Api.DTOs.Postulaciones;

public class CrearPostulacionDto
{
    [Required]
    public int EstudianteId { get; set; }

    [Required]
    public int ProyectoId { get; set; }

    [MaxLength(1000)]
    public string? Mensaje { get; set; }
}
