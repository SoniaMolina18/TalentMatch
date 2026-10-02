using System.ComponentModel.DataAnnotations;

namespace TalentMatch.Api.DTOs.Usuarios;

public class ActualizarUsuarioDto
{
    [Required]
    public string Nombre { get; set; } = string.Empty;

    [Required]
    public string Apellido { get; set; } = string.Empty;

    [Required]
    [EmailAddress]
    public string Correo { get; set; } = string.Empty;
}
