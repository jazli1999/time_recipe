class CurrentUser {
  static int _id;
  static bool _isLoggedIn = false;

  static void setId(int value) {
    _id = value;
  }

  static void setIsLoggedIn(bool value) {
    _isLoggedIn = value;
  }

  static int getId() {
    return _id;
  }

  static bool getIsLoggedIn() {
    return _isLoggedIn;
  }
}
