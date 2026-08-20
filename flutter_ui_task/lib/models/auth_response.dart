class AuthResponse {
  final String token;
  final String role;
  final String name;

  AuthResponse({
    required this.token,
    required this.role,
    required this.name,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] as String,
      role: json['role'] as String,
      name: json['name'] as String? ?? '',
    );
  }
}
