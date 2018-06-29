using AspCoreServer.Server.Models;
using Microsoft.EntityFrameworkCore;

namespace AspCoreServer.Server.Data
{
    public class SpaDbContext : DbContext
    {
        public SpaDbContext(DbContextOptions<SpaDbContext> options)
            : base(options)
        {
            Database.EnsureCreated();
        }

        //List of DB Models - Add your DB models here
        public DbSet<User> User { get; set; }
    }
}
