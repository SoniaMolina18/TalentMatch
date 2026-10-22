using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TalentMatch.Api.Repositories.Interfaces;

namespace TalentMatch.Api.Controllers;

[ApiController]
[Route("api/v1/[controller]")]
[Authorize]
public class InteresesController : ControllerBase
{
    private readonly IInteresRepository _repository;

    public InteresesController(IInteresRepository repository) => _repository = repository;

    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        var intereses = await _repository.GetAllAsync();
        return Ok(intereses.Select(i => new { i.Id, i.Nombre }));
    }
}
