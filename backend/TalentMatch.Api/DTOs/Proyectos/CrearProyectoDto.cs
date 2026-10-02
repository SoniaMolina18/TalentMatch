using System.ComponentModel.DataAnnotations;

namespace TalentMatch.Api.DTOs.Proyectos;

public class CrearProyectoDto
{
    [Required]
    public string Titulo { get; set; } = string.Empty;

    [Required]
    public string Descripcion { get; set; } = string.Empty;

    [Required]
    public DateTime FechaLimite { get; set; }

    [Range(1, int.MaxValue)]
    public int CuposDisponibles { get; set; }

    public int ProfesorId { get; set; }
}
