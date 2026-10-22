using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TalentMatch.Api.DTOs.Postulaciones;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Controllers;

[ApiController]
[Route("api/v1/[controller]")]
[Authorize]
public class PostulacionesController : ControllerBase
{
    private readonly IPostulacionService _postulacionService;

    public PostulacionesController(IPostulacionService postulacionService)
    {
        _postulacionService = postulacionService;
    }

    [HttpGet("mias")]
    [Authorize(Roles = "Estudiante")]
    public async Task<IActionResult> GetMine()
    {
        var (currentUserId, currentUserRole) = GetCurrentUser();
        return Ok(await _postulacionService.GetMineAsync(currentUserId, currentUserRole));
    }

    [HttpGet("proyecto/{proyectoId:int}")]
    [Authorize(Roles = "Profesor,Estudiante,Administrador")]
    public async Task<IActionResult> GetByProyectoId(int proyectoId)
    {
        var (currentUserId, currentUserRole) = GetCurrentUser();
        var postulaciones = await _postulacionService.GetByProyectoIdAsync(proyectoId, currentUserId, currentUserRole);
        return Ok(postulaciones);
    }

    [HttpPost]
    [Authorize(Roles = "Estudiante")]
    public async Task<IActionResult> Create([FromBody] CrearPostulacionDto dto)
    {
        var (currentUserId, currentUserRole) = GetCurrentUser();
        var postulacion = await _postulacionService.CreateAsync(dto, currentUserId, currentUserRole);
        return CreatedAtAction(nameof(GetByProyectoId), new { proyectoId = postulacion.ProyectoId }, postulacion);
    }

    [HttpPut("{id:int}/aceptar")]
    [Authorize(Roles = "Profesor,Estudiante")]
    public async Task<IActionResult> Accept(int id)
    {
        var (currentUserId, currentUserRole) = GetCurrentUser();
        var postulacion = await _postulacionService.AcceptAsync(id, currentUserId, currentUserRole);
        return Ok(postulacion);
    }

    [HttpPut("{id:int}/rechazar")]
    [Authorize(Roles = "Profesor,Estudiante")]
    public async Task<IActionResult> Reject(int id)
    {
        var (currentUserId, currentUserRole) = GetCurrentUser();
        var postulacion = await _postulacionService.RejectAsync(id, currentUserId, currentUserRole);
        return Ok(postulacion);
    }

    private (int Id, string Role) GetCurrentUser() =>
        (int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value ?? "0"),
         User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value ?? "");
}
