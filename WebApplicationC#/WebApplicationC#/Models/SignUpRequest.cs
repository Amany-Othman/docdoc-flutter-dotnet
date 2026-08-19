namespace WebApplicationC.Models
{
    // What the Flutter Sign Up screen actually sends: email, password, phone.
    // Register() below binds to this instead of the full User model, so
    // the client doesn't need to supply Name/Age just to satisfy the model.
    public class SignUpRequest
    {
        public string Email { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string Mobile { get; set; } = string.Empty;
    }
}