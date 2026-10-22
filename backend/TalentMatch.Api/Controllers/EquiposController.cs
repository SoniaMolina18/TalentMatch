using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TalentMatch.Api.DTOs.Equipos;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Controllers;

[ApiController]
[Route("api/v1/[controller]")]
[Authorize]
public class EquiposController : ControllerBase
{
    private readonly IEquipoService _equipoService;

    public EquiposController(IEquipoService equipoService)
    {
        _equipoService = equipoService;
    }

    [HttpGet("mios")]
    public async Task<IActionResult> GetMine()
    {
        var (currentUserId, currentUserRole) = GetCurrentUser();
        return Ok(await _equipoService.GetByUsuarioAsync(currentUserId, currentUserRole));
    }

    [HttpGet("{id:int}")]
    public async Task<IActionResult> GetById(int id)
    {
        var (currentUserId, currentUserRole) = GetCurrentUser();
        var equipo = await _equipoService.GetByIdAsync(id, currentUserId, currentUserRole);
        return equipo is null ? NotFound() : Ok(equipo);
    }

    [HttpPost]
    [Authorize(Roles = "Profesor,Administrador")]
    public async Task<IActionResult> Create([FromBody] CrearEquipoDto dto)
    {
        var (currentUserId, currentUserRole) = GetCurrentUser();
        var equipo = await _equipoService.CreateAsync(dto, currentUserId, currentUserRole);
        return CreatedAtAction(nameof(GetById), new { id = equipo.Id }, equipo);
    }

    [HttpPost("{equipoId:int}/miembros/{estudianteId:int}")]
    [Authorize(Roles = "Profesor,Administrador")]
    public async Task<IActionResult> AddMiembro(int equipoId, int estudianteId)
    {
        var (currentUserId, currentUserRole) = GetCurrentUser();
        var equipo = await _equipoService.AddMiembroAsync(equipoId, estudianteId, currentUserId, currentUserRole);
        return Ok(equipo);
    }

    [HttpPut("{equipoId:int}/lider")]
    [Authorize(Roles = "Profesor")]
    public async Task<IActionResult> AssignLeader(int equipoId, [FromBody] AsignarLiderEquipoDto dto)
    {
        var (currentUserId, currentUserRole) = GetCurrentUser();
        var equipo = await _equipoService.AssignLeaderAsync(equipoId, dto.EstudianteId, currentUserId, currentUserRole);
        return Ok(equipo);
    }

    private (int Id, string Role) GetCurrentUser() =>
        (int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value ?? "0"),
         User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value ?? "");
}
