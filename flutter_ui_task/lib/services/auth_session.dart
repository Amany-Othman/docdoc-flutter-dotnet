import 'secure_storage_service.dart';

class AuthSession {
  AuthSession._();

  static final AuthSession instance = AuthSession._();

  String? token;
  String? role;

  bool get isLoggedIn => token != null;

  void setSession({
    required String token,
    required String role,
  }) {
    this.token = token;
    this.role = role;
  }

  Future<void> restoreSession() async {
    final savedToken = await SecureStorageService.getToken();

    if (savedToken != null && savedToken.isNotEmpty) {
      token = savedToken;
    }
  }

  Future<void> clear() async {
    token = null;
    role = null;

    await SecureStorageService.deleteToken();
  }
}
