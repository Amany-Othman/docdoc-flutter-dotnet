using Microsoft.EntityFrameworkCore;
using WebApplicationC.Models;

namespace WebApplicationC.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options)
        {
        }

        public DbSet<User> Users { get; set; }
        public DbSet<Doctor> Doctors { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Doctor>().HasData(
                new Doctor
                {
                    Id = 1,
                    Name = "Dr. Randy Wigham",
                    Speciality = "General",
                    Hospital = "RSUD Gatot Subroto",
                    Rating = 4.8,
                    ReviewsCount = 4279,
                    ImageUrl = "assets/images/doctor_randy.png",
                    IsRecommended = true
                },
                new Doctor
                {
                    Id = 2,
                    Name = "Dr. Sarah Sulivan",
                    Speciality = "Neurologic",
                    Hospital = "RSUD Gatot Subroto",
                    Rating = 4.6,
                    ReviewsCount = 3120,
                    ImageUrl = "assets/images/doctor_sarah.png",
                    IsRecommended = true
                },
                new Doctor
                {
                    Id = 3,
                    Name = "Dr. Amina Farouk",
                    Speciality = "Pediatric",
                    Hospital = "Cairo General Hospital",
                    Rating = 4.9,
                    ReviewsCount = 2894,
                    ImageUrl = "assets/images/doctor_amina.png",
                    IsRecommended = true
                }
            );
        }
    }
}