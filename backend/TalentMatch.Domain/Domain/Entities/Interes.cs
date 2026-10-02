using System.ComponentModel.DataAnnotations;

namespace TalentMatch.Domain.Domain.Entities;

public class Interes
{
    public int Id { get; set; }

    [Required]
    [MaxLength(100)]
    public string Nombre { get; set; } = string.Empty;

    public ICollection<EstudianteInteres> Estudiantes { get; set; } = new List<EstudianteInteres>();
    public ICollection<ProyectoInteres> Proyectos { get; set; } = new List<ProyectoInteres>();
}
