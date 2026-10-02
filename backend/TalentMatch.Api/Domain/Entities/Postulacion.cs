using System.ComponentModel.DataAnnotations;
using TalentMatch.Api.Domain.Enums;

namespace TalentMatch.Api.Domain.Entities;

public class Postulacion
{
    public int Id { get; set; }

    public int EstudianteId { get; set; }
    public Estudiante Estudiante { get; set; } = null!;

    public int ProyectoId { get; set; }
    public Proyecto Proyecto { get; set; } = null!;

    public EstadoPostulacion Estado { get; set; } = EstadoPostulacion.Pendiente;

    [MaxLength(1000)]
    public string? Mensaje { get; set; }

    public DateTime FechaPostulacion { get; set; } = DateTime.UtcNow;
}
