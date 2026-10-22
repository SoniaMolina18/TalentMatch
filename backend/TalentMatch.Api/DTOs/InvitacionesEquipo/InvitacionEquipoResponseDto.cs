using TalentMatch.Api.Domain.Enums;

namespace TalentMatch.Api.DTOs.InvitacionesEquipo;

public class InvitacionEquipoResponseDto
{
    public int Id { get; set; }
    public int EquipoId { get; set; }
    public string Equipo { get; set; } = string.Empty;
    public int ProyectoId { get; set; }
    public string Proyecto { get; set; } = string.Empty;
    public int RemitenteUsuarioId { get; set; }
    public string Remitente { get; set; } = string.Empty;
    public int DestinatarioUsuarioId { get; set; }
    public string Destinatario { get; set; } = string.Empty;
    public string? Mensaje { get; set; }
    public EstadoInvitacionEquipo Estado { get; set; }
    public DateTime FechaCreacion { get; set; }
    public DateTime? FechaRespuesta { get; set; }
}