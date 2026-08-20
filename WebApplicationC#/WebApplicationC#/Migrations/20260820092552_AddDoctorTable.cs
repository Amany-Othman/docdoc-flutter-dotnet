using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace WebApplicationC_.Migrations
{
    /// <inheritdoc />
    public partial class AddDoctorTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Doctors",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Speciality = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Hospital = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Rating = table.Column<double>(type: "float", nullable: false),
                    ReviewsCount = table.Column<int>(type: "int", nullable: false),
                    ImageUrl = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    IsRecommended = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Doctors", x => x.Id);
                });

            migrationBuilder.InsertData(
                table: "Doctors",
                columns: new[] { "Id", "Hospital", "ImageUrl", "IsRecommended", "Name", "Rating", "ReviewsCount", "Speciality" },
                values: new object[,]
                {
                    { 1, "RSUD Gatot Subroto", "assets/images/doctor_randy.png", true, "Dr. Randy Wigham", 4.7999999999999998, 4279, "General" },
                    { 2, "RSUD Gatot Subroto", "assets/images/doctor_sarah.png", true, "Dr. Sarah Sulivan", 4.5999999999999996, 3120, "Neurologic" },
                    { 3, "Cairo General Hospital", "assets/images/doctor_amina.png", true, "Dr. Amina Farouk", 4.9000000000000004, 2894, "Pediatric" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Doctors");
        }
    }
}
