class Doctor {
  final int id;
  final String name;
  final String speciality;
  final String hospital;
  final double rating;
  final int reviewsCount;
  final String imageUrl;

  const Doctor({
    required this.id,
    required this.name,
    required this.speciality,
    required this.hospital,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as int,
      name: json['name'] as String,
      speciality: json['speciality'] as String,
      hospital: json['hospital'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: json['reviewsCount'] as int,
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }
}
