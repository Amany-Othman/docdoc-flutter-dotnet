using Microsoft.AspNetCore.Mvc;
using WebApplicationC.Data;
using WebApplicationC.Models;
using Microsoft.EntityFrameworkCore;

[ApiController]
[Route("api/[controller]")]
public class SetupController : ControllerBase
{
    private readonly AppDbContext _context;

    public SetupController(AppDbContext context)
    {
        _context = context;
    }

    [HttpPost("create-first-admin")]
    public async Task<IActionResult> CreateFirstAdmin([FromBody] User user)
    {
        bool adminExists = await _context.Users.AnyAsync(u => u.Role == "Admin");
        if (adminExists)
        {
            // Permanently locked once the first admin exists
            return Conflict("An Admin account already exists. This endpoint is disabled.");
        }

        user.Password = BCrypt.Net.BCrypt.HashPassword(user.Password);
        user.Role = "Admin";

        _context.Users.Add(user);
        await _context.SaveChangesAsync();

        return Ok("First admin account created. You can now log in.");
    }
}