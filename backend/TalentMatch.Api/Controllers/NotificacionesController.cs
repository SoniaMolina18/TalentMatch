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

    [HttpGet("mias")]
    public async Task<IActionResult> GetMine()
    {
        var (currentUserId, currentUserRole) = GetCurrentUser();
        return Ok(await _notificacionService.GetByUsuarioIdAsync(currentUserId, currentUserId, currentUserRole));
    }

    [HttpGet("usuario/{usuarioId:int}")]
    public async Task<IActionResult> GetByUsuarioId(int usuarioId)
    {
        var (currentUserId, currentUserRole) = GetCurrentUser();
        var notificaciones = await _notificacionService.GetByUsuarioIdAsync(usuarioId, currentUserId, currentUserRole);
        return Ok(notificaciones);
    }

    [HttpPut("{id:int}/leer")]
    public async Task<IActionResult> MarkAsRead(int id)
    {
        var (currentUserId, currentUserRole) = GetCurrentUser();
        var notificacion = await _notificacionService.MarkAsReadAsync(id, currentUserId, currentUserRole);
        return Ok(notificacion);
    }

    private (int Id, string Role) GetCurrentUser() =>
        (int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value ?? "0"),
         User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value ?? "");
}
