using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using TalentMatch.Api.Data;
using Xunit;

namespace TalentMatch.Api.Tests;

public sealed class DatabaseSeederGuardTests
{
    [Fact]
    public async Task Seeder_rejects_non_development_without_touching_database()
    {
        await using var context = CreateContext();
        var services = new ServiceCollection()
            .AddSingleton(context)
            .AddSingleton<Microsoft.AspNetCore.Hosting.IWebHostEnvironment>(new TestEnvironment { EnvironmentName = "Production" })
            .BuildServiceProvider();
        var configuration = Configuration(new Dictionary<string, string?>
        {
            ["Persistence:UseRealServices"] = "true",
            ["Persistence:SeedDevelopment"] = "true",
            ["Seed:Password"] = "isolated-test-password"
        });

        await Assert.ThrowsAsync<InvalidOperationException>(() => DatabaseSeeder.SeedAsync(services, configuration));
        Assert.Empty(context.Usuarios);
    }

    [Fact]
    public async Task Seeder_requires_explicit_seed_flag_in_development()
    {
        await using var context = CreateContext();
        var services = new ServiceCollection()
            .AddSingleton(context)
            .AddSingleton<Microsoft.AspNetCore.Hosting.IWebHostEnvironment>(new TestEnvironment { EnvironmentName = "Development" })
            .BuildServiceProvider();
        var configuration = Configuration(new Dictionary<string, string?>
        {
            ["Persistence:UseRealServices"] = "true",
            ["Persistence:SeedDevelopment"] = "false",
            ["Seed:Password"] = "isolated-test-password"
        });

        await Assert.ThrowsAsync<InvalidOperationException>(() => DatabaseSeeder.SeedAsync(services, configuration));
        Assert.Empty(context.Usuarios);
    }

    private static TalentMatchDbContext CreateContext() => new(new DbContextOptionsBuilder<TalentMatchDbContext>()
        .UseInMemoryDatabase(Guid.NewGuid().ToString())
        .Options);

    private static IConfiguration Configuration(Dictionary<string, string?> values) =>
        new ConfigurationBuilder().AddInMemoryCollection(values).Build();

    private sealed class TestEnvironment : Microsoft.AspNetCore.Hosting.IWebHostEnvironment
    {
        public string EnvironmentName { get; set; } = "Development";
        public string ApplicationName { get; set; } = typeof(DatabaseSeederGuardTests).Assembly.GetName().Name!;
        public string WebRootPath { get; set; } = string.Empty;
        public Microsoft.Extensions.FileProviders.IFileProvider WebRootFileProvider { get; set; } = new Microsoft.Extensions.FileProviders.NullFileProvider();
        public string ContentRootPath { get; set; } = AppContext.BaseDirectory;
        public Microsoft.Extensions.FileProviders.IFileProvider ContentRootFileProvider { get; set; } = new Microsoft.Extensions.FileProviders.NullFileProvider();
    }
}
