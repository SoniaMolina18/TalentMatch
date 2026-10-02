namespace TalentMatch.Api.Domain.Entities;

public class ProyectoHabilidad
{
    public int Id { get; set; }

    public int ProyectoId { get; set; }
    public Proyecto Proyecto { get; set; } = null!;

    public int HabilidadId { get; set; }
    public Habilidad Habilidad { get; set; } = null!;
}
