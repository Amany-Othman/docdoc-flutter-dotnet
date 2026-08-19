using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplicationC.Data;
using WebApplicationC.DTOs.Users;
using WebApplicationC.Models;

namespace WebApplicationC.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class UsersController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly IWebHostEnvironment _environment;

        private const long MaxImageSize = 2 * 1024 * 1024;

        private readonly string[] AllowedExtensions =
        {
            ".jpg",
            ".png"
        };

        public UsersController(
            AppDbContext context,
            IWebHostEnvironment environment)
        {
            _context = context;
            _environment = environment;
        }

        // Create User - Admin Only
        [HttpPost]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> CreateUser(
            [FromForm] CreateUserRequest request,
            IFormFile? profileImage)
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
                Name = request.Name,
                Email = request.Email,
                Age = request.Age,
                Mobile = request.Mobile,
                Role = request.Role,
                Password = BCrypt.Net.BCrypt.HashPassword(
                    request.Password
                )
            };

            if (profileImage != null)
            {
                var validationResult =
                    ValidateImage(profileImage);

                if (validationResult != null)
                {
                    return BadRequest(new
                    {
                        message = validationResult
                    });
                }

                user.ProfileImage =
                    await SaveImage(profileImage);
            }

            _context.Users.Add(user);

            await _context.SaveChangesAsync();

            return Ok(MapToResponse(user));
        }

        // Get All Users - Any Authenticated User
        [HttpGet]
        public async Task<IActionResult> GetUsers()
        {
            var users = await _context.Users
                .ToListAsync();

            var result = users
                .Select(MapToResponse)
                .ToList();

            return Ok(result);
        }

        // Get User Statistics - Any Authenticated User
        [HttpGet("stats")]
        public async Task<IActionResult> GetUserStats()
        {
            var totalUsers = await _context.Users
                .CountAsync();

            var totalAdmins = await _context.Users
                .CountAsync(u => u.Role == "Admin");

            var totalRegularUsers =
                totalUsers - totalAdmins;

            return Ok(new
            {
                totalUsers,
                totalAdmins,
                totalRegularUsers
            });
        }

        // Get User By ID - Any Authenticated User
        [HttpGet("{id}")]
        public async Task<IActionResult> GetUser(int id)
        {
            var user = await _context.Users
                .FirstOrDefaultAsync(u => u.Id == id);

            if (user == null)
            {
                return NotFound(new
                {
                    message = "User not found"
                });
            }

            return Ok(MapToResponse(user));
        }

        // Search Users + Pagination
        // Any Authenticated User
        [HttpGet("search")]
        public async Task<IActionResult> SearchUsers(
            string? name,
            int page = 1,
            int pageSize = 5)
        {
            if (page < 1)
                page = 1;

            if (pageSize < 1)
                pageSize = 5;

            var query = _context.Users
                .AsQueryable();

            if (!string.IsNullOrWhiteSpace(name))
            {
                query = query.Where(u =>
                    u.Name.Contains(name));
            }

            var totalUsers =
                await query.CountAsync();

            var users = await query
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            var result = users
                .Select(MapToResponse)
                .ToList();

            return Ok(new
            {
                totalUsers,
                page,
                pageSize,
                totalPages = (int)Math.Ceiling(
                    (double)totalUsers / pageSize
                ),
                users = result
            });
        }

        // Update User - Admin Only
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> UpdateUser(
            int id,
            [FromForm] UpdateUserRequest request,
            IFormFile? profileImage)
        {
            var existingUser =
                await _context.Users.FindAsync(id);

            if (existingUser == null)
            {
                return NotFound(new
                {
                    message = "User not found"
                });
            }

            if (existingUser.Email != request.Email)
            {
                var emailExists =
                    await _context.Users.AnyAsync(u =>
                        u.Email == request.Email &&
                        u.Id != id);

                if (emailExists)
                {
                    return BadRequest(new
                    {
                        message = "Email already exists"
                    });
                }
            }

            existingUser.Name = request.Name;
            existingUser.Email = request.Email;
            existingUser.Age = request.Age;
            existingUser.Mobile = request.Mobile;

            if (!string.IsNullOrWhiteSpace(request.Password))
            {
                existingUser.Password =
                    BCrypt.Net.BCrypt.HashPassword(
                        request.Password
                    );
            }

            if (!string.IsNullOrWhiteSpace(request.Role))
            {
                existingUser.Role = request.Role;
            }

            // Update profile image
            if (profileImage != null)
            {
                var validationResult =
                    ValidateImage(profileImage);

                if (validationResult != null)
                {
                    return BadRequest(new
                    {
                        message = validationResult
                    });
                }

                DeleteImage(existingUser.ProfileImage);

                existingUser.ProfileImage =
                    await SaveImage(profileImage);
            }

            await _context.SaveChangesAsync();

            return Ok(MapToResponse(existingUser));
        }

        // Delete User - Admin Only
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> DeleteUser(int id)
        {
            var user =
                await _context.Users.FindAsync(id);

            if (user == null)
            {
                return NotFound(new
                {
                    message = "User not found"
                });
            }

            DeleteImage(user.ProfileImage);

            _context.Users.Remove(user);

            await _context.SaveChangesAsync();

            return Ok(new
            {
                message = "User deleted successfully"
            });
        }

        // Convert User Entity to UserResponse
        private UserResponse MapToResponse(User user)
        {
            return new UserResponse
            {
                Id = user.Id,
                Name = user.Name,
                Email = user.Email,
                Age = user.Age,
                Mobile = user.Mobile,
                Role = user.Role,
                ProfileImage =
                    GetImageUrl(user.ProfileImage)
            };
        }

        // Validate Image
        private string? ValidateImage(IFormFile image)
        {
            if (image.Length > MaxImageSize)
            {
                return "Image size must not exceed 2 MB";
            }

            var extension = Path
                .GetExtension(image.FileName)
                .ToLowerInvariant();

            if (!AllowedExtensions.Contains(extension))
            {
                return "Only JPG and PNG images are allowed";
            }

            return null;
        }

        // Save Image
        private async Task<string> SaveImage(IFormFile image)
        {
            var folderPath = Path.Combine(
                _environment.WebRootPath,
                "images",
                "users"
            );

            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            var extension = Path
                .GetExtension(image.FileName)
                .ToLowerInvariant();

            var fileName =
                $"{Guid.NewGuid()}{extension}";

            var filePath = Path.Combine(
                folderPath,
                fileName
            );

            using var stream = new FileStream(
                filePath,
                FileMode.Create
            );

            await image.CopyToAsync(stream);

            return fileName;
        }

        // Delete Image
        private void DeleteImage(string? fileName)
        {
            if (string.IsNullOrWhiteSpace(fileName))
                return;

            var filePath = Path.Combine(
                _environment.WebRootPath,
                "images",
                "users",
                fileName
            );

            if (System.IO.File.Exists(filePath))
            {
                System.IO.File.Delete(filePath);
            }
        }

        // Get Image URL
        private string? GetImageUrl(string? fileName)
        {
            if (string.IsNullOrWhiteSpace(fileName))
                return null;

            return $"{Request.Scheme}://{Request.Host}/images/users/{fileName}";
        }
    }
}