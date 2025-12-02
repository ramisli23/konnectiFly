import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterService {
  Future<bool> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final url = Uri.parse("https://backend-bumm.onrender.com/auth/register");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "full_name": fullName,
          "email": email,
          "phone": phone,
          "password": password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ Register success: ${response.body}");
        return true;
      } else {
        print("❌ Register failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("⚠️ Register error: $e");
      return false;
    }
  }
}
