using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TalentMatch.Api.Repositories.Interfaces;

namespace TalentMatch.Api.Controllers;

[ApiController]
[Route("api/v1/[controller]")]
[Authorize]
public class HabilidadesController : ControllerBase
{
    private readonly IHabilidadRepository _repository;

    public HabilidadesController(IHabilidadRepository repository) => _repository = repository;

    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        var habilidades = await _repository.GetAllAsync();
        return Ok(habilidades.Select(h => new { h.Id, h.Nombre, h.Categoria }));
    }
}
