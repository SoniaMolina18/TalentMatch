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

    [HttpGet("{id:int}")]
    public async Task<IActionResult> GetById(int id)
    {
        var equipo = await _equipoService.GetByIdAsync(id);
        return equipo is null ? NotFound() : Ok(equipo);
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CrearEquipoDto dto)
    {
        var equipo = await _equipoService.CreateAsync(dto);
        return CreatedAtAction(nameof(GetById), new { id = equipo.Id }, equipo);
    }

    [HttpPost("{equipoId:int}/miembros/{estudianteId:int}")]
    public async Task<IActionResult> AddMiembro(int equipoId, int estudianteId)
    {
        var equipo = await _equipoService.AddMiembroAsync(equipoId, estudianteId);
        return Ok(equipo);
    }
}
