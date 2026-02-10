import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _usersKey = 'registered_users';
  static const String _currentUserKey = 'current_user';

  /// Save a new user account
  Future<void> saveUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    // Get existing users
    final usersJson = prefs.getString(_usersKey) ?? '{}';

    // Parse users as a simple key-value map: email -> password
    Map<String, dynamic> users = {};
    try {
      // Simple format: email:password separated by |
      if (usersJson.isNotEmpty && usersJson != '{}') {
        final usersList = usersJson.split('|');
        for (var user in usersList) {
          if (user.contains(':')) {
            final parts = user.split(':');
            users[parts[0]] = parts[1];
          }
        }
      }
    } catch (e) {
      print('Error parsing users: $e');
    }

    // Add new user
    users[email] = password;

    // Convert back to string format
    final usersString = users.entries
        .map((e) => '${e.key}:${e.value}')
        .join('|');

    await prefs.setString(_usersKey, usersString);
  }

  /// Verify user credentials
  Future<bool> verifyUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_usersKey) ?? '';

    if (usersJson.isEmpty) {
      return false;
    }

    try {
      final usersList = usersJson.split('|');
      for (var user in usersList) {
        if (user.contains(':')) {
          final parts = user.split(':');
          if (parts[0] == email && parts[1] == password) {
            // Save current user
            await prefs.setString(_currentUserKey, email);
            return true;
          }
        }
      }
    } catch (e) {
      print('Error verifying user: $e');
    }

    return false;
  }

  /// Get current logged in user
  Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentUserKey);
  }

  /// Logout current user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    final user = await getCurrentUser();
    return user != null;
  }
}
