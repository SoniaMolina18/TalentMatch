namespace TalentMatch.Api.DTOs.Mensajes;

public class CrearConversacionDto
{
    public int UsuarioId { get; set; }
}

public class CrearMensajeDto
{
    public string Contenido { get; set; } = string.Empty;
}

public class ConversacionDto
{
    public int Id { get; set; }
    public int OtroUsuarioId { get; set; }
    public string OtroNombre { get; set; } = string.Empty;
    public string OtroApellido { get; set; } = string.Empty;
    public DateTime FechaCreacion { get; set; }
    public IReadOnlyCollection<MensajeDto> Mensajes { get; set; } = Array.Empty<MensajeDto>();
}

public class MensajeDto
{
    public int Id { get; set; }
    public int RemitenteId { get; set; }
    public string RemitenteNombre { get; set; } = string.Empty;
    public string Contenido { get; set; } = string.Empty;
    public DateTime FechaEnvio { get; set; }
    public bool Leido { get; set; }
}