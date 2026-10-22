using TalentMatch.Api.Domain.Enums;

namespace TalentMatch.Api.DTOs.Postulaciones;

public class PostulacionResponseDto
{
    public int Id { get; set; }
    public int EstudianteId { get; set; }
    public string EstudianteNombre { get; set; } = string.Empty;
    public string EstudianteApellido { get; set; } = string.Empty;
    public string? EstudianteCarrera { get; set; }
    public int? EstudianteSemestre { get; set; }
    public int ProyectoId { get; set; }
    public EstadoPostulacion Estado { get; set; }
    public string? Mensaje { get; set; }
    public DateTime FechaPostulacion { get; set; }
    public ProyectoPostulacionDto? Proyecto { get; set; }
}

public class ProyectoPostulacionDto
{
    public int Id { get; set; }
    public string Titulo { get; set; } = string.Empty;
    public string Descripcion { get; set; } = string.Empty;
    public DateTime? FechaLimite { get; set; }
}
