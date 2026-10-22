using TalentMatch.Api.DTOs.InvitacionesEquipo;

namespace TalentMatch.Api.Services.Interfaces;

public interface IInvitacionEquipoService
{
    Task<InvitacionEquipoResponseDto> CreateAsync(CrearInvitacionEquipoDto dto, int currentUserId, string currentUserRole);
    Task<IEnumerable<InvitacionEquipoResponseDto>> GetReceivedAsync(int currentUserId, string currentUserRole);
    Task<IEnumerable<InvitacionEquipoResponseDto>> GetSentAsync(int currentUserId, string currentUserRole);
    Task<InvitacionEquipoResponseDto> AcceptAsync(int id, int currentUserId, string currentUserRole);
    Task<InvitacionEquipoResponseDto> RejectAsync(int id, int currentUserId, string currentUserRole);
    Task<InvitacionEquipoResponseDto> CancelAsync(int id, int currentUserId, string currentUserRole);
}