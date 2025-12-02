import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterService {
  final String baseUrl = "https://backend-1-f2ms.onrender.com";

  Future<dynamic> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('$baseUrl/register');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'Erreur Register (${response.statusCode}): ${response.body}',
      );
    }
  }
}
