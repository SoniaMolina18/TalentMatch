namespace TalentMatch.Domain.Domain.Entities;

public class Recomendacion
{
    public int Id { get; set; }

    public int EstudianteId { get; set; }
    public Estudiante Estudiante { get; set; } = null!;

    public int ProyectoId { get; set; }
    public Proyecto Proyecto { get; set; } = null!;

    public decimal PorcentajeCompatibilidad { get; set; }

    public DateTime FechaGeneracion { get; set; } = DateTime.UtcNow;
}
