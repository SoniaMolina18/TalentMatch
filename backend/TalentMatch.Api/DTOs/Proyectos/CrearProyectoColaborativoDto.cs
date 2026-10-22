using System.ComponentModel.DataAnnotations;

namespace TalentMatch.Api.DTOs.Proyectos;

public class CrearProyectoColaborativoDto
{
    [Required]
    public string Titulo { get; set; } = string.Empty;

    [Required]
    public string Descripcion { get; set; } = string.Empty;

    public string? Objetivo { get; set; }

    [Range(1, int.MaxValue)]
    public int CuposDisponibles { get; set; }

    public DateTime? FechaLimite { get; set; }
    public string? Disponibilidad { get; set; }
    public IReadOnlyCollection<int> HabilidadesIds { get; set; } = Array.Empty<int>();
    public IReadOnlyCollection<int> InteresesIds { get; set; } = Array.Empty<int>();
}