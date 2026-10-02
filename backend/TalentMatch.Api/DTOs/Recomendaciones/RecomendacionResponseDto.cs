namespace TalentMatch.Api.DTOs.Recomendaciones;

public class RecomendacionResponseDto
{
    public int EstudianteId { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public decimal PorcentajeCompatibilidad { get; set; }
}
