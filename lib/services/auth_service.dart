import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = 'https://backend-bumm.onrender.com';

  Future<Map<String, dynamic>> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/auth/login'); // ✅ FIX

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({"email": email, "password": password}),
      );

      print('📤 Sent to: $url');
      print('📩 Code: ${response.statusCode}');
      print('📨 Body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['token'] != null) {
        final token = data['token'];

        // 🔍 Récupération du payload JWT
        final payload = _decodeJWT(token);
        final userId = payload['id'] ?? '';

        // 💾 Sauvegarde locale
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', token);
        await prefs.setString('user_id', userId);

        return {
          'success': true,
          'token': token,
          'id': userId, // 🔥 IMPORTANT
          'message': data['message'],
        };
      } else {
        final message = data['message'] ?? 'Identifiants invalides';
        return {'success': false, 'message': message};
      }
    } catch (e) {
      return {'success': false, 'message': 'Erreur réseau: $e'};
    }
  }

  /// Décoder un JWT et retourner le payload
  Map<String, dynamic> _decodeJWT(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw Exception('JWT invalide');

    final payload = utf8.decode(
      base64Url.decode(base64Url.normalize(parts[1])),
    );
    return jsonDecode(payload);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }
}

/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // final String baseUrl = 'https://esimcard.com/api/developer/reseller';
  final String baseUrl = 'https://backend-1-f2ms.onrender.com';

  Future<Map<String, dynamic>> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({"email": email, "password": password}),
      );

      print('📤 Sent to: $url');
      print('📩 Code: ${response.statusCode}');
      print('📨 Body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['token'] != null) {
        final token = data['token'];

        // Sauvegarde locale
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', token);

        return {'success': true, 'token': token, 'message': data['message']};
      } else {
        final message = data['message'] ?? 'Identifiants invalides';
        return {'success': false, 'message': message};
      }
    } catch (e) {
      return {'success': false, 'message': 'Erreur réseau: $e'};
    }
  }
}
*/
