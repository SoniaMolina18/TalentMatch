using System.ComponentModel.DataAnnotations;

namespace TalentMatch.Api.DTOs.Equipos;

public class CrearEquipoDto
{
    [Required]
    public string Nombre { get; set; } = string.Empty;

    [Required]
    public int ProyectoId { get; set; }
}
