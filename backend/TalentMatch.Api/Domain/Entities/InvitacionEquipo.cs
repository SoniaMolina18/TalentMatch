using System.ComponentModel.DataAnnotations;
using TalentMatch.Api.Domain.Enums;

namespace TalentMatch.Api.Domain.Entities;

public class InvitacionEquipo
{
    public int Id { get; set; }
    public int EquipoId { get; set; }
    public Equipo Equipo { get; set; } = null!;
    public int RemitenteUsuarioId { get; set; }
    public Usuario RemitenteUsuario { get; set; } = null!;
    public int DestinatarioUsuarioId { get; set; }
    public Usuario DestinatarioUsuario { get; set; } = null!;
    [MaxLength(1000)]
    public string? Mensaje { get; set; }
    public EstadoInvitacionEquipo Estado { get; set; } = EstadoInvitacionEquipo.Pendiente;
    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;
    public DateTime? FechaRespuesta { get; set; }
}