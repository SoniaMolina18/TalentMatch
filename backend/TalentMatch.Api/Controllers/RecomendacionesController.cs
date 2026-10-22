using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Controllers;

[ApiController]
[Route("api/v1/[controller]")]
[Authorize]
public class RecomendacionesController : ControllerBase
{
    private readonly IRecomendacionService _recomendacionService;

    public RecomendacionesController(IRecomendacionService recomendacionService)
    {
        _recomendacionService = recomendacionService;
    }

    [HttpGet("proyectos/{proyectoId:int}")]
    public async Task<IActionResult> GetRecomendacionesPorProyecto(int proyectoId)
    {
        var currentUserId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value ?? "0");
        var currentUserRole = User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value ?? "";
        var recomendaciones = await _recomendacionService.GetRecomendacionesPorProyectoAsync(proyectoId, currentUserId, currentUserRole);
        return Ok(recomendaciones);
    }
}
