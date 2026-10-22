using System.ComponentModel.DataAnnotations;

namespace TalentMatch.Api.DTOs.Usuarios;

public class CrearUsuarioAdministrativoDto
{
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
    [MinLength(8)]
    [RegularExpression(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d]).+$", ErrorMessage = "La contraseña debe incluir mayúscula, minúscula, número y símbolo.")]
    public string Password { get; set; } = string.Empty;

    [Required]
    [RegularExpression("^(Estudiante|Profesor)$", ErrorMessage = "El rol debe ser Estudiante o Profesor.")]
    public string Rol { get; set; } = string.Empty;
}
