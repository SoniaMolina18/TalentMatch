using System.ComponentModel.DataAnnotations;

namespace TalentMatch.Api.Domain.Entities;

public class Estudiante
{
    public int Id { get; set; }

    public int UsuarioId { get; set; }
    public Usuario Usuario { get; set; } = null!;

    [Required]
    [MaxLength(50)]
    public string CodigoEstudiante { get; set; } = string.Empty;

    [Required]
    [MaxLength(200)]
    public string Carrera { get; set; } = string.Empty;

    public int Semestre { get; set; }

    public ICollection<EstudianteHabilidad> EstudianteHabilidades { get; set; } = new List<EstudianteHabilidad>();
    public ICollection<EstudianteInteres> EstudianteIntereses { get; set; } = new List<EstudianteInteres>();
    public ICollection<Postulacion> Postulaciones { get; set; } = new List<Postulacion>();
    public ICollection<Recomendacion> Recomendaciones { get; set; } = new List<Recomendacion>();
    public ICollection<MiembroEquipo> MiembrosEquipo { get; set; } = new List<MiembroEquipo>();
}
