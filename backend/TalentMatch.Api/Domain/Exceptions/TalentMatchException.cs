namespace TalentMatch.Api.Domain.Exceptions;

public class TalentMatchException : Exception
{
    public int StatusCode { get; }

    public TalentMatchException(string message, int statusCode = 400) : base(message)
    {
        StatusCode = statusCode;
    }
}
