using System.ComponentModel.DataAnnotations;

namespace WebApplicationC.Models
{
    public class Doctor
    {
        public int Id { get; set; }

        [Required]
        public string Name { get; set; } = string.Empty;

        [Required]
        public string Speciality { get; set; } = string.Empty;

        [Required]
        public string Hospital { get; set; } = string.Empty;

        [Range(0, 5)]
        public double Rating { get; set; }

        public int ReviewsCount { get; set; }

        public string? ImageUrl { get; set; }

        // Lets us mark a subset of doctors as "recommended" on the
        // homepage without needing a separate table/endpoint later.
        public bool IsRecommended { get; set; } = true;
    }
}