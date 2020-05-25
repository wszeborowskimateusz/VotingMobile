class UserRepository {
  String _token;

  bool get isLoggedIn => _token != null;

  // Returns if operation was successful or not
  Future<bool> login(String username, String password) async {
    if (username.isNotEmpty && password == "123") {
      _token = "secretToken";
      return true;
    }
    return false;
  }

  void logout() {
    _token = null;
  }
}