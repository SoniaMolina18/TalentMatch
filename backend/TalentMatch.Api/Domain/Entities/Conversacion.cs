using System.ComponentModel.DataAnnotations;

namespace TalentMatch.Api.Domain.Entities;

public class Conversacion
{
    public int Id { get; set; }
    public int UsuarioAId { get; set; }
    public Usuario UsuarioA { get; set; } = null!;
    public int UsuarioBId { get; set; }
    public Usuario UsuarioB { get; set; } = null!;
    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;
    public ICollection<Mensaje> Mensajes { get; set; } = new List<Mensaje>();
}