using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplicationC.Data;

namespace WebApplicationC.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DoctorController : ControllerBase
    {
        private readonly AppDbContext _context;

        public DoctorController(AppDbContext context)
        {
            _context = context;
        }

        // GET api/Doctor/recommended
        [HttpGet("recommended")]
        public async Task<IActionResult> GetRecommended()
        {
            var doctors = await _context.Doctors
                .Where(d => d.IsRecommended)
                .Select(d => new
                {
                    d.Id,
                    d.Name,
                    d.Speciality,
                    d.Hospital,
                    d.Rating,
                    d.ReviewsCount,
                    d.ImageUrl
                })
                .ToListAsync();

            return Ok(doctors);
        }
    }
}