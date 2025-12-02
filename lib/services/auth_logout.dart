import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:konnecti/components/components.dart';
import 'package:konnecti/providers/auth_storage.dart';
import 'package:provider/provider.dart';
import 'package:konnecti/providers/AuthProvider.dart';

class AuthLogout {
  final String baseUrl = 'https://backend-1-f2ms.onrender.com';

  Future<Map<String, dynamic>> logout(
    BuildContext context,
    String token,
  ) async {
    final url = Uri.parse('$baseUrl/logout');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Supprimer token local
        await AuthStorage.removeAccessToken();

        // Réinitialiser le provider
        Provider.of<AuthProvider>(context, listen: false).clearAccessToken();

        // Rediriger vers SplashScreen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const SplashScreen1()),
          (route) => false,
        );

        return {'success': true, 'data': data};
      } else {
        final message = data['message'] ?? 'Erreur lors du logout';
        return {'success': false, 'message': message};
      }
    } catch (e) {
      return {'success': false, 'message': 'Erreur réseau: $e'};
    }
  }
}
