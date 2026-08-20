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
        public DbSet<Speciality> Specialities { get; set; }

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

            modelBuilder.Entity<Speciality>().HasData(
                new Speciality
                {
                    Id = 1,
                    Label = "General",
                    IconKey = "general",
                    BackgroundColorHex = "#EFF3FF",
                    IconColorHex = "#4E7FFF",
                    IsFeatured = true
                },
                new Speciality
                {
                    Id = 2,
                    Label = "Neurologic",
                    IconKey = "neurologic",
                    BackgroundColorHex = "#FFEDED",
                    IconColorHex = "#FF5A5A",
                    IsFeatured = true
                },
                new Speciality
                {
                    Id = 3,
                    Label = "Pediatric",
                    IconKey = "pediatric",
                    BackgroundColorHex = "#FFEEF5",
                    IconColorHex = "#FF6FA5",
                    IsFeatured = true
                },
                new Speciality
                {
                    Id = 4,
                    Label = "Radiology",
                    IconKey = "radiology",
                    BackgroundColorHex = "#EDEBFF",
                    IconColorHex = "#8A6BFF",
                    IsFeatured = true
                },
                new Speciality
                {
                    Id = 5,
                    Label = "Cardiology",
                    IconKey = "cardiology",
                    BackgroundColorHex = "#FFF1EE",
                    IconColorHex = "#FF7A59",
                    IsFeatured = false
                },
                new Speciality
                {
                    Id = 6,
                    Label = "Dermatology",
                    IconKey = "dermatology",
                    BackgroundColorHex = "#EFFAF3",
                    IconColorHex = "#3FBF7F",
                    IsFeatured = false
                },
                new Speciality
                {
                    Id = 7,
                    Label = "Dental",
                    IconKey = "dental",
                    BackgroundColorHex = "#EFF9FF",
                    IconColorHex = "#34AEDB",
                    IsFeatured = false
                },
                new Speciality
                {
                    Id = 8,
                    Label = "Orthopedic",
                    IconKey = "orthopedic",
                    BackgroundColorHex = "#FFF8E8",
                    IconColorHex = "#E0A72E",
                    IsFeatured = false
                },
                new Speciality
                {
                    Id = 9,
                    Label = "Ophthalmology",
                    IconKey = "ophthalmology",
                    BackgroundColorHex = "#F1EEFF",
                    IconColorHex = "#7A5AF8",
                    IsFeatured = false
                },
                new Speciality
                {
                    Id = 10,
                    Label = "ENT",
                    IconKey = "ent",
                    BackgroundColorHex = "#FFEFF7",
                    IconColorHex = "#E24E9B",
                    IsFeatured = false
                }
            );
        }
    }
}