namespace TalentMatch.Api.DTOs.Usuarios;

public class BusquedaEstudiantesDto
{
    public IReadOnlyCollection<EstudianteTalentoDto> Items { get; set; } = Array.Empty<EstudianteTalentoDto>();
    public int Page { get; set; }
    public int PageSize { get; set; }
    public int Total { get; set; }
}

public class EstudianteTalentoDto
{
    public int EstudianteId { get; set; }
    public int UsuarioId { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public string Apellido { get; set; } = string.Empty;
    public string Carrera { get; set; } = string.Empty;
    public int Semestre { get; set; }
    public string? Descripcion { get; set; }
    public string? Disponibilidad { get; set; }
    public IReadOnlyCollection<string> Habilidades { get; set; } = Array.Empty<string>();
    public IReadOnlyCollection<string> Intereses { get; set; } = Array.Empty<string>();
}