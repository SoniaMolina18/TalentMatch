using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TalentMatch.Api.DTOs.InvitacionesEquipo;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Controllers;

[ApiController]
[Route("api/v1/[controller]")]
[Authorize(Roles = "Estudiante")]
public class InvitacionesEquipoController : ControllerBase
{
    private readonly IInvitacionEquipoService _service;

    public InvitacionesEquipoController(IInvitacionEquipoService service)
    {
        _service = service;
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CrearInvitacionEquipoDto dto)
    {
        var invitation = await _service.CreateAsync(dto, CurrentUserId, CurrentUserRole);
        return Ok(invitation);
    }

    [HttpGet("recibidas")]
    public async Task<IActionResult> GetReceived()
    {
        return Ok(await _service.GetReceivedAsync(CurrentUserId, CurrentUserRole));
    }

    [HttpGet("enviadas")]
    public async Task<IActionResult> GetSent()
    {
        return Ok(await _service.GetSentAsync(CurrentUserId, CurrentUserRole));
    }

    [HttpPut("{id:int}/aceptar")]
    public async Task<IActionResult> Accept(int id)
    {
        return Ok(await _service.AcceptAsync(id, CurrentUserId, CurrentUserRole));
    }

    [HttpPut("{id:int}/rechazar")]
    public async Task<IActionResult> Reject(int id)
    {
        return Ok(await _service.RejectAsync(id, CurrentUserId, CurrentUserRole));
    }

    [HttpPut("{id:int}/cancelar")]
    public async Task<IActionResult> Cancel(int id)
    {
        return Ok(await _service.CancelAsync(id, CurrentUserId, CurrentUserRole));
    }

    private int CurrentUserId => int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier) ?? "0");
    private string CurrentUserRole => User.FindFirstValue(ClaimTypes.Role) ?? string.Empty;
}
