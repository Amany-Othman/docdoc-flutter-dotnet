/// Holds the logged-in user's token/role for the lifetime of the app.
/// In-memory only for now - the user will need to log in again after
/// a full app restart. Swap this for shared_preferences (or flutter_secure_storage
/// for the token specifically) once you want that to persist.
class AuthSession {
  AuthSession._();
  static final AuthSession instance = AuthSession._();

  String? token;
  String? role;

  bool get isLoggedIn => token != null;

  void setSession({required String token, required String role}) {
    this.token = token;
    this.role = role;
  }

  void clear() {
    token = null;
    role = null;
  }
}
