using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TalentMatch.Api.DTOs.Proyectos;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Controllers;

[ApiController]
[Route("api/v1/[controller]")]
[Authorize]
public class ProyectosController : ControllerBase
{
    private readonly IProyectoService _proyectoService;

    public ProyectosController(IProyectoService proyectoService)
    {
        _proyectoService = proyectoService;
    }

    [HttpPost("colaborativos")]
    [Authorize(Roles = "Estudiante")]
    public async Task<IActionResult> CreateCollaborative([FromBody] CrearProyectoColaborativoDto dto)
    {
        var (currentUserId, currentUserRole) = GetCurrentUser();
        var proyecto = await _proyectoService.CreateCollaborativeAsync(dto, currentUserId, currentUserRole);
        return CreatedAtAction(nameof(GetById), new { id = proyecto.Id }, proyecto);
    }

    [HttpGet("colaborativos/mios")]
    [Authorize(Roles = "Estudiante")]
    public async Task<IActionResult> GetMyCollaborative()
    {
        var (currentUserId, currentUserRole) = GetCurrentUser();
        return Ok(await _proyectoService.GetMyCollaborativeAsync(currentUserId, currentUserRole));
    }

    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        var proyectos = await _proyectoService.GetAllAsync();
        return Ok(proyectos);
    }

    [HttpGet("{id:int}")]
    public async Task<IActionResult> GetById(int id)
    {
        var proyecto = await _proyectoService.GetByIdAsync(id);
        return proyecto is null ? NotFound() : Ok(proyecto);
    }

    [HttpPost]
    [Authorize(Roles = "Profesor")]
    public async Task<IActionResult> Create([FromBody] CrearProyectoDto dto)
    {
        var currentUserId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value ?? "0");
        var currentUserRole = User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value ?? "";

        var proyecto = await _proyectoService.CreateAsync(dto, currentUserId, currentUserRole);
        return CreatedAtAction(nameof(GetById), new { id = proyecto.Id }, proyecto);
    }

    [HttpPut("{id:int}")]
    [Authorize(Roles = "Profesor")]
    public async Task<IActionResult> Update(int id, [FromBody] ActualizarProyectoDto dto)
    {
        var currentUserId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value ?? "0");
        var currentUserRole = User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value ?? "";

        var proyecto = await _proyectoService.UpdateAsync(id, dto, currentUserId, currentUserRole);
        return Ok(proyecto);
    }

    [HttpDelete("{id:int}")]
    [Authorize(Roles = "Profesor")]
    public async Task<IActionResult> Delete(int id)
    {
        var currentUserId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value ?? "0");
        var currentUserRole = User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value ?? "";

        await _proyectoService.DeleteAsync(id, currentUserId, currentUserRole);
        return NoContent();
    }

    private (int Id, string Role) GetCurrentUser() =>
        (int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value ?? "0"),
         User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value ?? "");
}
