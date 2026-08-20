import 'secure_storage_service.dart';

class AuthSession {
  AuthSession._();

  static final AuthSession instance = AuthSession._();

  String? token;
  String? role;
  String? name;

  bool get isLoggedIn => token != null;

  void setSession({
    required String token,
    required String role,
    String? name,
    bool persist = true,
  }) {
    this.token = token;
    this.role = role;
    this.name = name;

    if (persist && name != null && name.isNotEmpty) {
      // Fire-and-forget: persist so the name survives an app restart,
      // not just this in-memory session.
      SecureStorageService.saveValue('user_name', name);
    }
  }

  Future<void> restoreSession() async {
    final savedToken = await SecureStorageService.getToken();

    if (savedToken != null && savedToken.isNotEmpty) {
      token = savedToken;
    }

    final savedName = await SecureStorageService.getValue('user_name');
    if (savedName != null && savedName.isNotEmpty) {
      name = savedName;
    }
  }

  Future<void> clear() async {
    token = null;
    role = null;
    name = null;

    await SecureStorageService.deleteToken();
    await SecureStorageService.deleteValue('user_name');
  }
}
