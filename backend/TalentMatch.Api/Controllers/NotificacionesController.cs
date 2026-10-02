using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Controllers;

[ApiController]
[Route("api/v1/[controller]")]
[Authorize]
public class NotificacionesController : ControllerBase
{
    private readonly INotificacionService _notificacionService;

    public NotificacionesController(INotificacionService notificacionService)
    {
        _notificacionService = notificacionService;
    }

    [HttpGet("usuario/{usuarioId:int}")]
    public async Task<IActionResult> GetByUsuarioId(int usuarioId)
    {
        var notificaciones = await _notificacionService.GetByUsuarioIdAsync(usuarioId);
        return Ok(notificaciones);
    }

    [HttpPut("{id:int}/leer")]
    public async Task<IActionResult> MarkAsRead(int id)
    {
        var notificacion = await _notificacionService.MarkAsReadAsync(id);
        return Ok(notificacion);
    }
}
