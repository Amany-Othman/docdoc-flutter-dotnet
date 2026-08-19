/// Matches your AuthController's login response exactly:
/// { "message": "...", "token": "...", "role": "..." }
/// Register does NOT return a token - see ApiService.register().
class AuthResponse {
  AuthResponse({required this.token, required this.role});

  final String token;
  final String role;

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] as String? ?? '',
      role: json['role'] as String? ?? 'User',
    );
  }
}
