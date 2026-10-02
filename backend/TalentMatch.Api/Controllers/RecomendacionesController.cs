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
        var recomendaciones = await _recomendacionService.GetRecomendacionesPorProyectoAsync(proyectoId);
        return Ok(recomendaciones);
    }
}
