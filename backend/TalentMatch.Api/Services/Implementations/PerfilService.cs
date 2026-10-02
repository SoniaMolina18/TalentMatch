using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Exceptions;
using TalentMatch.Api.DTOs.Perfiles;
using TalentMatch.Api.Repositories.Interfaces;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Services.Implementations;

public class PerfilService : IPerfilService
{
    private readonly IPerfilRepository _perfilRepository;
    private readonly IUsuarioRepository _usuarioRepository;

    public PerfilService(IPerfilRepository perfilRepository, IUsuarioRepository usuarioRepository)
    {
        _perfilRepository = perfilRepository;
        _usuarioRepository = usuarioRepository;
    }

    public async Task<PerfilResponseDto?> GetByUsuarioIdAsync(int usuarioId)
    {
        var perfil = await _perfilRepository.GetByUsuarioIdAsync(usuarioId);
        if (perfil is null) return null;

        return new PerfilResponseDto
        {
            Id = perfil.Id,
            UsuarioId = perfil.UsuarioId,
            Descripcion = perfil.Descripcion,
            Disponibilidad = perfil.Disponibilidad,
            FotoPerfil = perfil.FotoPerfil
        };
    }

    public async Task<PerfilResponseDto> UpdateAsync(int usuarioId, ActualizarPerfilDto dto, int currentUserId, string currentUserRole)
    {
        if (usuarioId != currentUserId && currentUserRole != "Administrador")
            throw new TalentMatchException("Solo puedes actualizar tu propio perfil, salvo el Administrador.", 403);

        var usuario = await _usuarioRepository.GetByIdAsync(usuarioId)
            ?? throw new TalentMatchException("Usuario no encontrado.", 404);

        var perfil = await _perfilRepository.GetByUsuarioIdAsync(usuarioId);

        if (perfil is null)
        {
            perfil = new Perfil
            {
                UsuarioId = usuarioId,
                Descripcion = dto.Descripcion,
                Disponibilidad = dto.Disponibilidad,
                FotoPerfil = dto.FotoPerfil
            };

            await _perfilRepository.AddAsync(perfil);
        }
        else
        {
            perfil.Descripcion = dto.Descripcion;
            perfil.Disponibilidad = dto.Disponibilidad;
            perfil.FotoPerfil = dto.FotoPerfil;
            await _perfilRepository.UpdateAsync(perfil);
        }

        return new PerfilResponseDto
        {
            Id = perfil.Id,
            UsuarioId = perfil.UsuarioId,
            Descripcion = perfil.Descripcion,
            Disponibilidad = perfil.Disponibilidad,
            FotoPerfil = perfil.FotoPerfil
        };
    }
}
