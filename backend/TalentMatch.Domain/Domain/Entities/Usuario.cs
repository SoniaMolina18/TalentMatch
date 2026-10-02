using System.ComponentModel.DataAnnotations;
using TalentMatch.Domain.Domain.Enums;

namespace TalentMatch.Domain.Domain.Entities;

public class Usuario
{
    public int Id { get; set; }

    [Required]
    [MaxLength(100)]
    public string Nombre { get; set; } = string.Empty;

    [Required]
    [MaxLength(100)]
    public string Apellido { get; set; } = string.Empty;

    [Required]
    [EmailAddress]
    [MaxLength(200)]
    public string Correo { get; set; } = string.Empty;

    [Required]
    public string PasswordHash { get; set; } = string.Empty;

    public RolUsuario Rol { get; set; }

    public bool Activo { get; set; } = true;

    public DateTime FechaRegistro { get; set; } = DateTime.UtcNow;

    public Estudiante? Estudiante { get; set; }
    public Profesor? Profesor { get; set; }
    public Perfil? Perfil { get; set; }
    public ICollection<Notificacion> Notificaciones { get; set; } = new List<Notificacion>();
}
