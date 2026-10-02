using System.ComponentModel.DataAnnotations;

namespace TalentMatch.Api.Domain.Entities;

public class Habilidad
{
    public int Id { get; set; }

    [Required]
    [MaxLength(100)]
    public string Nombre { get; set; } = string.Empty;

    [Required]
    [MaxLength(100)]
    public string Categoria { get; set; } = string.Empty;

    public ICollection<EstudianteHabilidad> Estudiantes { get; set; } = new List<EstudianteHabilidad>();
    public ICollection<ProyectoHabilidad> Proyectos { get; set; } = new List<ProyectoHabilidad>();
}
