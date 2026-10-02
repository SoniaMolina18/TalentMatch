namespace TalentMatch.Api.Domain.Entities;

public class ProyectoInteres
{
    public int Id { get; set; }

    public int ProyectoId { get; set; }
    public Proyecto Proyecto { get; set; } = null!;

    public int InteresId { get; set; }
    public Interes Interes { get; set; } = null!;
}
