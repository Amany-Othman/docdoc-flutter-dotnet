namespace WebApplicationC.Models
{
    public class Speciality
    {
        public int Id { get; set; }
        public string Label { get; set; } = string.Empty;
        public string IconKey { get; set; } = string.Empty;
        public string BackgroundColorHex { get; set; } = string.Empty;
        public string IconColorHex { get; set; } = string.Empty;
        public bool IsFeatured { get; set; }
    }
}