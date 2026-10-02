namespace TalentMatch.Domain.Domain.Entities;

public class MiembroEquipo
{
    public int Id { get; set; }

    public int EquipoId { get; set; }
    public Equipo Equipo { get; set; } = null!;

    public int EstudianteId { get; set; }
    public Estudiante Estudiante { get; set; } = null!;

    public DateTime FechaIngreso { get; set; } = DateTime.UtcNow;
}
