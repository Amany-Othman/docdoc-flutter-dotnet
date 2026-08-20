using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace WebApplicationC_.Migrations
{
    /// <inheritdoc />
    public partial class AddSpecialities : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Specialities",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Label = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IconKey = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    BackgroundColorHex = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IconColorHex = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IsFeatured = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Specialities", x => x.Id);
                });

            migrationBuilder.InsertData(
                table: "Specialities",
                columns: new[] { "Id", "BackgroundColorHex", "IconColorHex", "IconKey", "IsFeatured", "Label" },
                values: new object[,]
                {
                    { 1, "#EFF3FF", "#4E7FFF", "general", true, "General" },
                    { 2, "#FFEDED", "#FF5A5A", "neurologic", true, "Neurologic" },
                    { 3, "#FFEEF5", "#FF6FA5", "pediatric", true, "Pediatric" },
                    { 4, "#EDEBFF", "#8A6BFF", "radiology", true, "Radiology" },
                    { 5, "#FFF1EE", "#FF7A59", "cardiology", false, "Cardiology" },
                    { 6, "#EFFAF3", "#3FBF7F", "dermatology", false, "Dermatology" },
                    { 7, "#EFF9FF", "#34AEDB", "dental", false, "Dental" },
                    { 8, "#FFF8E8", "#E0A72E", "orthopedic", false, "Orthopedic" },
                    { 9, "#F1EEFF", "#7A5AF8", "ophthalmology", false, "Ophthalmology" },
                    { 10, "#FFEFF7", "#E24E9B", "ent", false, "ENT" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Specialities");
        }
    }
}
