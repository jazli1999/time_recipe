class CurrentUser {
  static int _id;
  static String _username;
  static bool _isLoggedIn = false;

  static void setId(int value) {
    _id = value;
  }

  static void setUsername(String value) {
    _username = value;
  }

  static void setIsLoggedIn(bool value) {
    _isLoggedIn = value;
  }

  static int getId() {
    return _id;
  }

  static String getUsername() {
    return _username;
  }

  static bool getIsLoggedIn() {
    return _isLoggedIn;
  }
}
