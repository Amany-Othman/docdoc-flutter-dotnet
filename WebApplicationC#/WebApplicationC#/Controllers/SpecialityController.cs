using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplicationC.Data;

namespace WebApplicationC.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SpecialityController : ControllerBase
    {
        private readonly AppDbContext _context;

        public SpecialityController(AppDbContext context)
        {
            _context = context;
        }

        // GET api/Speciality
        // Used by the "All Specialities" screen.
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var specialities = await _context.Specialities.ToListAsync();
            return Ok(specialities);
        }

        // GET api/Speciality/featured
        // Used by the home screen's small speciality row.
        [HttpGet("featured")]
        public async Task<IActionResult> GetFeatured()
        {
            var specialities = await _context.Specialities
                .Where(s => s.IsFeatured)
                .ToListAsync();
            return Ok(specialities);
        }
    }
}