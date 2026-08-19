namespace WebApplicationC.DTOs.Users
{
    public class UserResponse
    {
        public int Id { get; set; }

        public string Name { get; set; } = string.Empty;

        public string Email { get; set; } = string.Empty;

        public int Age { get; set; }

        public string Mobile { get; set; } = string.Empty;

        public string Role { get; set; } = string.Empty;

        public string? ProfileImage { get; set; }
    }
}