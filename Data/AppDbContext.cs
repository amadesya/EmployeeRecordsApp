using Microsoft.EntityFrameworkCore;

public class AppDbContext : DbContext
{
    public DbSet<Employee> Employee { get; set; } = null!;
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
    {
    }
}

