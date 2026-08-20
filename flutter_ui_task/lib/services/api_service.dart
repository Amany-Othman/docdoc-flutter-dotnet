import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auth_response.dart';
import '../models/doctor.dart';

/// Thrown when the server responds with an error we can show the user
/// (wrong password, email already taken, etc).
class ApiException implements Exception {
  ApiException(this.message);
  final String message;
}

/// All network calls live here. Screens and controllers never call
/// `http` directly - they only ever talk to ApiService.
class ApiService {
  static const String _baseUrl = 'http://localhost:5042/api';

  static Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('$_baseUrl/Auth/login');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    }
    throw ApiException(
        _extractMessage(response.body) ?? 'Invalid email or password.');
  }

  static Future<void> register({
    required String name,
    required String email,
    required String password,
    required String mobile,
  }) async {
    final uri = Uri.parse('$_baseUrl/Auth/register');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'mobile': mobile,
      }),
    );
    if (response.statusCode == 200) {
      return;
    }
    throw ApiException(
        _extractMessage(response.body) ?? 'Could not create your account.');
  }

  /// Matches DoctorController.GetRecommended() - GET api/Doctor/recommended.
  /// Public endpoint, no auth token required.
  static Future<List<Doctor>> getRecommendedDoctors() async {
    final uri = Uri.parse('$_baseUrl/Doctor/recommended');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map((json) => Doctor.fromJson(json)).toList();
    }
    throw ApiException(
        _extractMessage(response.body) ?? 'Could not load doctors.');
  }

  static String? _extractMessage(String body) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map && decoded['message'] is String) {
        return decoded['message'] as String;
      }
    } catch (_) {
      // Body wasn't JSON - fall through and use the default message.
    }
    return null;
  }
}
