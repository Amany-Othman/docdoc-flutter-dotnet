using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using WebApplicationC.Data;
using WebApplicationC.Models;

namespace WebApplicationC.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly IConfiguration _configuration;

        public AuthController(
            AppDbContext context,
            IConfiguration configuration)
        {
            _context = context;
            _configuration = configuration;
        }

        // Register
        // CHANGED: now binds to SignUpRequest (email/password/mobile only)
        // instead of the full User model, to match what the Flutter Sign Up
        // screen collects. Name/Age are left blank/zero for now - fill them
        // in later via a "complete your profile" step if you add one.
        [HttpPost("register")]
        public async Task<IActionResult> Register(SignUpRequest request)
        {
            var emailExists = await _context.Users
                .AnyAsync(u => u.Email == request.Email);

            if (emailExists)
            {
                return BadRequest(new
                {
                    message = "Email already exists"
                });
            }

            var user = new User
            {
                Email = request.Email,
                Mobile = request.Mobile,
                Password = BCrypt.Net.BCrypt.HashPassword(request.Password),
                Role = "User",
                Name = string.Empty,
                Age = 0
            };

            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            return Ok(new
            {
                message = "Registration successful",
                user = new
                {
                    user.Id,
                    user.Name,
                    user.Email,
                    user.Age,
                    user.Mobile,
                    user.Role,
                    user.ProfileImage
                }
            });
        }

        // Login
        [HttpPost("login")]
        public async Task<IActionResult> Login(LoginRequest loginRequest)
        {
            var user = await _context.Users
                .FirstOrDefaultAsync(u => u.Email == loginRequest.Email);

            if (user == null)
            {
                return Unauthorized(new
                {
                    message = "Invalid email or password"
                });
            }

            var passwordValid = BCrypt.Net.BCrypt.Verify(
                loginRequest.Password,
                user.Password
            );

            if (!passwordValid)
            {
                return Unauthorized(new
                {
                    message = "Invalid email or password"
                });
            }

            var claims = new[]
            {
                new Claim(
                    ClaimTypes.NameIdentifier,
                    user.Id.ToString()
                ),

                new Claim(
                    ClaimTypes.Name,
                    user.Name
                ),

                new Claim(
                    ClaimTypes.Email,
                    user.Email
                ),

                new Claim(
                    ClaimTypes.Role,
                    user.Role
                )
            };

            var key = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(
                    _configuration["Jwt:Key"]!
                )
            );

            var credentials = new SigningCredentials(
                key,
                SecurityAlgorithms.HmacSha256
            );

            var token = new JwtSecurityToken(
                issuer: _configuration["Jwt:Issuer"],
                audience: _configuration["Jwt:Audience"],
                claims: claims,
                // Left as you had it - AddMinutes(1) means tokens expire fast.
                // Bump to AddHours(1) once you're past active testing.
                expires: DateTime.UtcNow.AddMinutes(1),
                signingCredentials: credentials
            );

            var tokenString = new JwtSecurityTokenHandler()
                .WriteToken(token);

            return Ok(new
            {
                message = "Login successful",
                token = tokenString,
                role = user.Role
            });
        }
    }
}