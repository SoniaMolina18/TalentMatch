using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TalentMatch.Api.Domain.Exceptions;
using TalentMatch.Api.DTOs.Usuarios;
using TalentMatch.Api.Security;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Controllers;

[ApiController]
[Route("api/v1/[controller]")]
public class AuthController : ControllerBase
{
    private readonly IUsuarioService _usuarioService;
    private readonly JwtService _jwtService;

    public AuthController(IUsuarioService usuarioService, JwtService jwtService)
    {
        _usuarioService = usuarioService;
        _jwtService = jwtService;
    }

    [AllowAnonymous]
    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] LoginDto dto)
    {
        var usuario = await _usuarioService.AuthenticateAsync(dto.Correo, dto.Password);
        if (usuario is null)
            throw new TalentMatchException("Credenciales inválidas.", 401);

        var token = _jwtService.GenerateToken(usuario);
        return Ok(new { token, usuario = new { usuario.Id, usuario.Nombre, usuario.Apellido, usuario.Correo, Rol = usuario.Rol.ToString() } });
    }
}
