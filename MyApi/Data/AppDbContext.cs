using Microsoft.EntityFrameworkCore;
using MyApi.Models;

namespace MyApi.Data
{
    public class AppDbContext : DbContext
    {
        public DbSet<Product> Products { get; set; }
        

        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }
    }
}