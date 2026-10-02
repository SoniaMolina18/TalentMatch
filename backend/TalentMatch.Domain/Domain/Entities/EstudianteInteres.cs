namespace TalentMatch.Domain.Domain.Entities;

public class EstudianteInteres
{
    public int Id { get; set; }

    public int EstudianteId { get; set; }
    public Estudiante Estudiante { get; set; } = null!;

    public int InteresId { get; set; }
    public Interes Interes { get; set; } = null!;
}
