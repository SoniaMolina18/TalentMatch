using System.ComponentModel.DataAnnotations;

namespace TalentMatch.Api.Domain.Entities;

public class Perfil
{
    public int Id { get; set; }

    public int UsuarioId { get; set; }
    public Usuario Usuario { get; set; } = null!;

    [MaxLength(2000)]
    public string? Descripcion { get; set; }

    [MaxLength(200)]
    public string? Disponibilidad { get; set; }

    [MaxLength(500)]
    public string? FotoPerfil { get; set; }
}
