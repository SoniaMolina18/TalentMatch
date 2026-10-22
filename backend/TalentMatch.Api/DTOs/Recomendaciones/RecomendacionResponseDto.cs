namespace TalentMatch.Api.DTOs.Recomendaciones;

public class RecomendacionResponseDto
{
    public int EstudianteId { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public string Carrera { get; set; } = string.Empty;
    public int Semestre { get; set; }
    public string? Disponibilidad { get; set; }
    public decimal PorcentajeCompatibilidad { get; set; }
    public IReadOnlyCollection<string> HabilidadesCoincidentes { get; set; } = Array.Empty<string>();
    public IReadOnlyCollection<string> InteresesCoincidentes { get; set; } = Array.Empty<string>();
}
