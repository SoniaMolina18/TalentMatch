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
}
