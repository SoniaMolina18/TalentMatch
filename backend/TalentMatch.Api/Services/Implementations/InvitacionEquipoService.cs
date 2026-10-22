using Microsoft.EntityFrameworkCore;
using TalentMatch.Api.Data;
using TalentMatch.Api.Domain.Entities;
using TalentMatch.Api.Domain.Enums;
using TalentMatch.Api.Domain.Exceptions;
using TalentMatch.Api.DTOs.InvitacionesEquipo;
using TalentMatch.Api.Repositories.Interfaces;
using TalentMatch.Api.Services.Interfaces;

namespace TalentMatch.Api.Services.Implementations;

public class InvitacionEquipoService : IInvitacionEquipoService
{
    private readonly IInvitacionEquipoRepository _invitacionRepository;
    private readonly IEquipoRepository _equipoRepository;
    private readonly IUsuarioRepository _usuarioRepository;
    private readonly TalentMatchDbContext _context;

    public InvitacionEquipoService(
        IInvitacionEquipoRepository invitacionRepository,
        IEquipoRepository equipoRepository,
        IUsuarioRepository usuarioRepository,
        TalentMatchDbContext context)
    {
        _invitacionRepository = invitacionRepository;
        _equipoRepository = equipoRepository;
        _usuarioRepository = usuarioRepository;
        _context = context;
    }

    public async Task<InvitacionEquipoResponseDto> CreateAsync(CrearInvitacionEquipoDto dto, int currentUserId, string currentUserRole)
    {
        EnsureStudent(currentUserRole);
        var equipo = await _equipoRepository.GetByIdAsync(dto.EquipoId)
            ?? throw new TalentMatchException("Equipo no encontrado.", 404);
        var currentUser = await _usuarioRepository.GetByIdAsync(currentUserId)
            ?? throw new TalentMatchException("Usuario no encontrado.", 404);
        var currentStudent = currentUser.Estudiante
            ?? throw new TalentMatchException("El usuario no tiene perfil de estudiante.", 403);

        EnsureLeader(equipo, currentStudent.Id);
        if (dto.DestinatarioUsuarioId == currentUserId)
            throw new TalentMatchException("No puedes invitarte a ti mismo.", 400);
        if (equipo.Estado != EstadoEquipo.Activo)
            throw new TalentMatchException("El equipo no está activo.", 409);
        if (equipo.Proyecto.CuposDisponibles <= equipo.Miembros.Count)
            throw new TalentMatchException("El equipo no tiene cupos disponibles.", 409);

        var destinatario = await _usuarioRepository.GetByIdAsync(dto.DestinatarioUsuarioId)
            ?? throw new TalentMatchException("Destinatario no encontrado.", 404);
        if (destinatario.Rol != RolUsuario.Estudiante)
            throw new TalentMatchException("El destinatario no es un estudiante.", 400);
        var estudiante = destinatario.Estudiante
            ?? throw new TalentMatchException("El destinatario no es un estudiante.", 400);
        if (equipo.Miembros.Any(m => m.EstudianteId == estudiante.Id))
            throw new TalentMatchException("El estudiante ya pertenece al equipo.", 409);
        if (await _invitacionRepository.GetPendingAsync(dto.EquipoId, dto.DestinatarioUsuarioId) is not null)
            throw new TalentMatchException("Ya existe una invitación pendiente para este equipo.", 409);

        await using var transaction = await _context.Database.BeginTransactionAsync();
        var invitacion = new InvitacionEquipo
        {
            EquipoId = equipo.Id,
            RemitenteUsuarioId = currentUserId,
            DestinatarioUsuarioId = dto.DestinatarioUsuarioId,
            Mensaje = dto.Mensaje,
            Estado = EstadoInvitacionEquipo.Pendiente,
            FechaCreacion = DateTime.UtcNow
        };
        await _context.InvitacionesEquipo.AddAsync(invitacion);
        await _context.Notificaciones.AddAsync(new Notificacion
        {
            UsuarioId = dto.DestinatarioUsuarioId,
            Titulo = "Invitación a equipo",
            Mensaje = $"Has recibido una invitación para unirte al equipo {equipo.Nombre}.",
            Tipo = "InvitacionEquipo",
            Leida = false,
            FechaCreacion = DateTime.UtcNow
        });
        await _context.SaveChangesAsync();
        await transaction.CommitAsync();
        return Map(invitacion);
    }

    public async Task<IEnumerable<InvitacionEquipoResponseDto>> GetReceivedAsync(int currentUserId, string currentUserRole)
    {
        EnsureStudent(currentUserRole);
        var invitations = await _invitacionRepository.GetReceivedAsync(currentUserId);
        return invitations.Select(Map);
    }

    public async Task<IEnumerable<InvitacionEquipoResponseDto>> GetSentAsync(int currentUserId, string currentUserRole)
    {
        EnsureStudent(currentUserRole);
        var invitations = await _invitacionRepository.GetSentAsync(currentUserId);
        return invitations.Select(Map);
    }

    public async Task<InvitacionEquipoResponseDto> AcceptAsync(int id, int currentUserId, string currentUserRole)
    {
        EnsureStudent(currentUserRole);
        var invitation = await GetPendingInvitation(id);
        EnsureRecipient(invitation, currentUserId);
        var equipo = invitation.Equipo;
        var estudiante = invitation.DestinatarioUsuario.Estudiante
            ?? throw new TalentMatchException("El destinatario no es un estudiante.", 400);
        if (equipo.Estado != EstadoEquipo.Activo)
            throw new TalentMatchException("El equipo no está activo.", 409);
        if (equipo.Miembros.Any(m => m.EstudianteId == estudiante.Id))
            throw new TalentMatchException("El estudiante ya pertenece al equipo.", 409);
        if (equipo.Proyecto.CuposDisponibles <= equipo.Miembros.Count)
            throw new TalentMatchException("El equipo no tiene cupos disponibles.", 409);

        await using var transaction = await _context.Database.BeginTransactionAsync();
        equipo.Miembros.Add(new MiembroEquipo
        {
            EquipoId = equipo.Id,
            EstudianteId = estudiante.Id,
            FechaIngreso = DateTime.UtcNow
        });
        invitation.Estado = EstadoInvitacionEquipo.Aceptada;
        invitation.FechaRespuesta = DateTime.UtcNow;
        await _context.Notificaciones.AddAsync(new Notificacion
        {
            UsuarioId = invitation.RemitenteUsuarioId,
            Titulo = "Invitación aceptada",
            Mensaje = $"El estudiante {invitation.DestinatarioUsuario.Nombre} {invitation.DestinatarioUsuario.Apellido} aceptó tu invitación.",
            Tipo = "InvitacionEquipo",
            Leida = false,
            FechaCreacion = DateTime.UtcNow
        });
        await _context.SaveChangesAsync();
        await transaction.CommitAsync();
        return Map(invitation);
    }

    public Task<InvitacionEquipoResponseDto> RejectAsync(int id, int currentUserId, string currentUserRole)
        => ResolveAsync(id, currentUserId, currentUserRole, EstadoInvitacionEquipo.Rechazada, "Invitación rechazada", "rechazó");

    public Task<InvitacionEquipoResponseDto> CancelAsync(int id, int currentUserId, string currentUserRole)
        => ResolveAsync(id, currentUserId, currentUserRole, EstadoInvitacionEquipo.Cancelada, null, null);

    private async Task<InvitacionEquipoResponseDto> ResolveAsync(int id, int currentUserId, string currentUserRole, EstadoInvitacionEquipo state, string? title, string? action)
    {
        EnsureStudent(currentUserRole);
        var invitation = await GetPendingInvitation(id);
        if (state == EstadoInvitacionEquipo.Cancelada)
            EnsureSender(invitation, currentUserId);
        else
            EnsureRecipient(invitation, currentUserId);
        invitation.Estado = state;
        invitation.FechaRespuesta = DateTime.UtcNow;
        if (title is not null && action is not null)
        {
            await _context.Notificaciones.AddAsync(new Notificacion
            {
                UsuarioId = invitation.RemitenteUsuarioId,
                Titulo = title,
                Mensaje = $"El estudiante {invitation.DestinatarioUsuario.Nombre} {invitation.DestinatarioUsuario.Apellido} {action} tu invitación.",
                Tipo = "InvitacionEquipo",
                Leida = false,
                FechaCreacion = DateTime.UtcNow
            });
        }
        await _context.SaveChangesAsync();
        return Map(invitation);
    }

    private async Task<InvitacionEquipo> GetPendingInvitation(int id)
    {
        var invitation = await _invitacionRepository.GetByIdAsync(id)
            ?? throw new TalentMatchException("Invitación no encontrada.", 404);
        if (invitation.Estado != EstadoInvitacionEquipo.Pendiente)
            throw new TalentMatchException("La invitación ya fue procesada.", 409);
        return invitation;
    }

    private static void EnsureStudent(string role)
    {
        if (role != "Estudiante")
            throw new TalentMatchException("Solo un estudiante puede gestionar invitaciones de equipo.", 403);
    }

    private static void EnsureLeader(Equipo equipo, int estudianteId)
    {
        if (equipo.LiderEstudianteId is null || equipo.LiderEstudianteId != estudianteId)
            throw new TalentMatchException("No tienes permiso para gestionar invitaciones de este equipo.", 403);
    }

    private static void EnsureRecipient(InvitacionEquipo invitation, int userId)
    {
        if (invitation.DestinatarioUsuarioId != userId)
            throw new TalentMatchException("Solo el destinatario puede responder esta invitación.", 403);
    }

    private static void EnsureSender(InvitacionEquipo invitation, int userId)
    {
        if (invitation.RemitenteUsuarioId != userId
            || invitation.Equipo.LiderEstudianteId != invitation.RemitenteUsuario.Estudiante?.Id)
            throw new TalentMatchException("Solo el remitente puede cancelar esta invitación.", 403);
    }

    private static InvitacionEquipoResponseDto Map(InvitacionEquipo invitation) => new()
    {
        Id = invitation.Id,
        EquipoId = invitation.EquipoId,
        Equipo = invitation.Equipo.Nombre,
        ProyectoId = invitation.Equipo.ProyectoId,
        Proyecto = invitation.Equipo.Proyecto.Titulo,
        RemitenteUsuarioId = invitation.RemitenteUsuarioId,
        Remitente = $"{invitation.RemitenteUsuario.Nombre} {invitation.RemitenteUsuario.Apellido}",
        DestinatarioUsuarioId = invitation.DestinatarioUsuarioId,
        Destinatario = $"{invitation.DestinatarioUsuario.Nombre} {invitation.DestinatarioUsuario.Apellido}",
        Mensaje = invitation.Mensaje,
        Estado = invitation.Estado,
        FechaCreacion = invitation.FechaCreacion,
        FechaRespuesta = invitation.FechaRespuesta
    };
}
