using System.ComponentModel.DataAnnotations;
using TalentMatch.Domain.Domain.Enums;

namespace TalentMatch.Domain.Domain.Entities;

public class Proyecto
{
    public int Id { get; set; }

    [Required]
    [MaxLength(200)]
    public string Titulo { get; set; } = string.Empty;

    [Required]
    [MaxLength(2000)]
    public string Descripcion { get; set; } = string.Empty;

    public EstadoProyecto Estado { get; set; } = EstadoProyecto.Borrador;

    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;

    public DateTime FechaLimite { get; set; }

    public int CuposDisponibles { get; set; }

    public int ProfesorId { get; set; }
    public Profesor Profesor { get; set; } = null!;

    public ICollection<ProyectoHabilidad> ProyectoHabilidades { get; set; } = new List<ProyectoHabilidad>();
    public ICollection<ProyectoInteres> ProyectoIntereses { get; set; } = new List<ProyectoInteres>();
    public ICollection<Postulacion> Postulaciones { get; set; } = new List<Postulacion>();
    public ICollection<Equipo> Equipos { get; set; } = new List<Equipo>();
    public ICollection<Recomendacion> Recomendaciones { get; set; } = new List<Recomendacion>();
}
