using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TalentMatch.Api.DTOs.Mensajes;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Controllers;

[ApiController, Authorize, Route("api/v1/[controller]")]
public class MensajesController : ControllerBase
{
    private readonly IMensajeService _service;
    public MensajesController(IMensajeService service) => _service = service;
    private int CurrentUserId => int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier) ?? "0");
    [HttpGet("conversaciones")] public async Task<IActionResult> Get() => Ok(await _service.GetConversacionesAsync(CurrentUserId));
    [HttpPost("conversaciones")] public async Task<IActionResult> Create([FromBody] CrearConversacionDto dto) => Ok(await _service.CreateConversacionAsync(CurrentUserId, dto.UsuarioId));
    [HttpPost("conversaciones/{id:int}/mensajes")] public async Task<IActionResult> Send(int id, [FromBody] CrearMensajeDto dto) => Ok(await _service.AddMensajeAsync(id, dto.Contenido, CurrentUserId));
    [HttpPut("conversaciones/{id:int}/leidos")] public async Task<IActionResult> Read(int id) { await _service.MarkReadAsync(id, CurrentUserId); return NoContent(); }
}