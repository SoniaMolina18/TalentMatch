using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;

namespace TalentMatch.Api.Data;

public sealed class TalentMatchDbContextFactory : IDesignTimeDbContextFactory<TalentMatchDbContext>
{
    public TalentMatchDbContext CreateDbContext(string[] args)
    {
        var basePath = Directory.GetCurrentDirectory();
        var configuration = new ConfigurationBuilder()
            .SetBasePath(basePath)
            .AddJsonFile("appsettings.json", optional: true)
            .AddJsonFile("appsettings.Development.json", optional: true)
            .AddUserSecrets("TalentMatch.Api-Development")
            .AddEnvironmentVariables()
            .Build();

        var connectionString = configuration.GetConnectionString("TalentMatchDatabase");
        if (string.IsNullOrWhiteSpace(connectionString))
        {
            throw new InvalidOperationException(
                "No se encontró ConnectionStrings:TalentMatchDatabase. Configure el valor mediante user-secrets antes de ejecutar Entity Framework.");
        }

        var optionsBuilder = new DbContextOptionsBuilder<TalentMatchDbContext>();
        optionsBuilder.UseSqlServer(connectionString);
        return new TalentMatchDbContext(optionsBuilder.Options);
    }
}
