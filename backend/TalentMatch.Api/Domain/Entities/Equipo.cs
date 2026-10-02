using System.ComponentModel.DataAnnotations;
using TalentMatch.Api.Domain.Enums;

namespace TalentMatch.Api.Domain.Entities;

public class Equipo
{
    public int Id { get; set; }

    [Required]
    [MaxLength(200)]
    public string Nombre { get; set; } = string.Empty;

    public int ProyectoId { get; set; }
    public Proyecto Proyecto { get; set; } = null!;

    public EstadoEquipo Estado { get; set; } = EstadoEquipo.Activo;

    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;

    public ICollection<MiembroEquipo> Miembros { get; set; } = new List<MiembroEquipo>();
}
