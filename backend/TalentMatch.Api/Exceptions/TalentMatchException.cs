using System;
using Microsoft.AspNetCore.Http;

namespace TalentMatch.Api.Exceptions
{
    public class TalentMatchException : Exception
    {
        public int StatusCode { get; }

        public TalentMatchException(string message, int statusCode = StatusCodes.Status500InternalServerError)
            : base(message)
        {
            StatusCode = statusCode;
        }

        public TalentMatchException(string message, Exception innerException, int statusCode = StatusCodes.Status500InternalServerError)
            : base(message, innerException)
        {
            StatusCode = statusCode;
        }
    }
}
