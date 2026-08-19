using System.ComponentModel.DataAnnotations;

namespace WebApplicationC.Models
{
    public class User
    {
        public int Id { get; set; }

        [Required]
        public string Name { get; set; } = string.Empty;

        [Required]
        [EmailAddress]
        public string Email { get; set; } = string.Empty;

        [Range(20, 50)]
        public int Age { get; set; }

        [Required]
        [Phone]
        public string Mobile { get; set; } = string.Empty;

        [Required]
        public string Password { get; set; } = string.Empty;

        public string Role { get; set; } = "User";

        public string? ProfileImage { get; set; }
    }
}