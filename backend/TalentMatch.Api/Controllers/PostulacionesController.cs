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

    [HttpGet("proyecto/{proyectoId:int}")]
    public async Task<IActionResult> GetByProyectoId(int proyectoId)
    {
        var postulaciones = await _postulacionService.GetByProyectoIdAsync(proyectoId);
        return Ok(postulaciones);
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CrearPostulacionDto dto)
    {
        var postulacion = await _postulacionService.CreateAsync(dto);
        return CreatedAtAction(nameof(GetByProyectoId), new { proyectoId = postulacion.ProyectoId }, postulacion);
    }

    [HttpPut("{id:int}/aceptar")]
    public async Task<IActionResult> Accept(int id)
    {
        var postulacion = await _postulacionService.AcceptAsync(id);
        return Ok(postulacion);
    }

    [HttpPut("{id:int}/rechazar")]
    public async Task<IActionResult> Reject(int id)
    {
        var postulacion = await _postulacionService.RejectAsync(id);
        return Ok(postulacion);
    }
}
