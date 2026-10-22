using TalentMatch.Api.Domain.Enums;
using TalentMatch.Api.DTOs.Equipos;

namespace TalentMatch.Api.DTOs.Proyectos;

public class ProyectoColaborativoResponseDto
{
    public int Id { get; set; }
    public string Titulo { get; set; } = string.Empty;
    public string Descripcion { get; set; } = string.Empty;
    public string? Objetivo { get; set; }
    public TipoProyecto Tipo { get; set; }
    public EstadoProyecto Estado { get; set; }
    public DateTime FechaCreacion { get; set; }
    public DateTime? FechaLimite { get; set; }
    public int CuposDisponibles { get; set; }
    public int CreadorEstudianteId { get; set; }
    public int LiderUsuarioId { get; set; }
    public EquipoResponseDto Equipo { get; set; } = null!;
    public IReadOnlyCollection<int> HabilidadesIds { get; set; } = Array.Empty<int>();
    public IReadOnlyCollection<int> InteresesIds { get; set; } = Array.Empty<int>();
}