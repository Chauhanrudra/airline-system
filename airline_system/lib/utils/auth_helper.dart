import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static const String _tokenKey = "auth_token"; // Key for JWT token
  static const String _roleKey = "user_role";   // Key for user role

  // Save JWT token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Get JWT token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Save user role
  static Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    print("save role is called with $role");
    await prefs.setString(_roleKey, role);
  }

  // Get user role
  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    print("get role is called with ${prefs.getString(_roleKey)}");
    return prefs.getString(_roleKey);
  }

  // Remove both token and role (Logout)
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_roleKey);
  }
}