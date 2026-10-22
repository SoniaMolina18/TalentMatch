using System.ComponentModel.DataAnnotations;

namespace TalentMatch.Api.Domain.Entities;

public class Mensaje
{
    public int Id { get; set; }
    public int ConversacionId { get; set; }
    public Conversacion Conversacion { get; set; } = null!;
    public int RemitenteId { get; set; }
    public Usuario Remitente { get; set; } = null!;
    [Required, MaxLength(2000)]
    public string Contenido { get; set; } = string.Empty;
    public DateTime FechaEnvio { get; set; } = DateTime.UtcNow;
    public bool Leido { get; set; }
}