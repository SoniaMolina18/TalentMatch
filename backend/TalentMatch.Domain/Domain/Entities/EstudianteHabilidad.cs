namespace TalentMatch.Domain.Domain.Entities;

public class EstudianteHabilidad
{
    public int Id { get; set; }

    public int EstudianteId { get; set; }
    public Estudiante Estudiante { get; set; } = null!;

    public int HabilidadId { get; set; }
    public Habilidad Habilidad { get; set; } = null!;
}
