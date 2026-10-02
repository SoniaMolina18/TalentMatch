using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TalentMatch.Api.DTOs.Perfiles;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Controllers;

[ApiController]
[Route("api/v1/[controller]")]
[Authorize]
public class PerfilesController : ControllerBase
{
    private readonly IPerfilService _perfilService;

    public PerfilesController(IPerfilService perfilService)
    {
        _perfilService = perfilService;
    }

    [HttpGet("{usuarioId:int}")]
    public async Task<IActionResult> GetByUsuarioId(int usuarioId)
    {
        var perfil = await _perfilService.GetByUsuarioIdAsync(usuarioId);
        return perfil is null ? NotFound() : Ok(perfil);
    }

    [HttpPut("{usuarioId:int}")]
    public async Task<IActionResult> Update(int usuarioId, [FromBody] ActualizarPerfilDto dto)
    {
        var currentUserId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value ?? "0");
        var currentUserRole = User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value ?? "";

        var perfil = await _perfilService.UpdateAsync(usuarioId, dto, currentUserId, currentUserRole);
        return Ok(perfil);
    }
}
