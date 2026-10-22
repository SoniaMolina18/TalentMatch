namespace TalentMatch.Api.DTOs.InvitacionesEquipo;

public class CrearInvitacionEquipoDto
{
    public int EquipoId { get; set; }
    public int DestinatarioUsuarioId { get; set; }
    public string? Mensaje { get; set; }
}