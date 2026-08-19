using System.ComponentModel.DataAnnotations;

namespace WebApplicationC.DTOs.Users
{
    public class UpdateUserRequest
    {
        [Required]
        [MaxLength(100)]
        public string Name { get; set; } = string.Empty;

        [Required]
        [EmailAddress]
        public string Email { get; set; } = string.Empty;

        [Range(20, 50)]
        public int Age { get; set; }

        [Required]
        public string Mobile { get; set; } = string.Empty;

        public string? Password { get; set; }

        public string? Role { get; set; }
    }
}