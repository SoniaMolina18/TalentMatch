using System.ComponentModel.DataAnnotations;

namespace TalentMatch.Api.DTOs.Perfiles;

public class ActualizarPerfilDto
{
    [Required]
    public int UsuarioId { get; set; }

    public string? Descripcion { get; set; }
    public string? Disponibilidad { get; set; }
    public string? FotoPerfil { get; set; }
}
