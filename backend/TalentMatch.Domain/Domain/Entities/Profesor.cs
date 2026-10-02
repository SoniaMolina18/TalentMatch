using System.ComponentModel.DataAnnotations;

namespace TalentMatch.Domain.Domain.Entities;

public class Profesor
{
    public int Id { get; set; }

    public int UsuarioId { get; set; }
    public Usuario Usuario { get; set; } = null!;

    [Required]
    [MaxLength(50)]
    public string CodigoProfesor { get; set; } = string.Empty;

    [Required]
    [MaxLength(200)]
    public string Facultad { get; set; } = string.Empty;

    public ICollection<Proyecto> Proyectos { get; set; } = new List<Proyecto>();
}
