using System.Net;
using System.Text.Json;
using Microsoft.AspNetCore.Mvc;

namespace TalentMatch.Api.Middleware;

public class GlobalExceptionMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<GlobalExceptionMiddleware> _logger;

    public GlobalExceptionMiddleware(RequestDelegate next, ILogger<GlobalExceptionMiddleware> logger)
    {
        _next = next;
        _logger = logger;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Unhandled exception");
            await HandleExceptionAsync(context, ex);
        }
    }

    private static async Task HandleExceptionAsync(HttpContext context, Exception exception)
    {
        var statusCode = exception switch
        {
            TalentMatchException ex => ex.StatusCode,
            ArgumentException => StatusCodes.Status400BadRequest,
            InvalidOperationException => StatusCodes.Status400BadRequest,
            UnauthorizedAccessException => StatusCodes.Status401Unauthorized,
            KeyNotFoundException => StatusCodes.Status404NotFound,
            _ => StatusCodes.Status500InternalServerError
        };

        var problemDetails = new ProblemDetails
        {
            Type = statusCode switch
            {
                StatusCodes.Status400BadRequest => "https://talentmatch.com/errors/validation",
                StatusCodes.Status401Unauthorized => "https://talentmatch.com/errors/unauthorized",
                StatusCodes.Status403Forbidden => "https://talentmatch.com/errors/forbidden",
                StatusCodes.Status404NotFound => "https://talentmatch.com/errors/not-found",
                StatusCodes.Status409Conflict => "https://talentmatch.com/errors/conflict",
                _ => "https://talentmatch.com/errors/server"
            },
            Title = GetTitle(statusCode),
            Status = statusCode,
            Detail = exception.Message,
            Instance = context.Request.Path
        };

        context.Response.ContentType = "application/problem+json";
        context.Response.StatusCode = statusCode;

        var json = JsonSerializer.Serialize(problemDetails);
        await context.Response.WriteAsync(json);
    }

    private static string GetTitle(int statusCode) => statusCode switch
    {
        StatusCodes.Status400BadRequest => "Error de validación",
        StatusCodes.Status401Unauthorized => "No autorizado",
        StatusCodes.Status403Forbidden => "Acceso prohibido",
        StatusCodes.Status404NotFound => "No encontrado",
        StatusCodes.Status409Conflict => "Conflicto",
        _ => "Error interno del servidor"
    };
}
