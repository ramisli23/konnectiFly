import 'dart:convert';
import 'package:http/http.dart' as http;

class BalanceService {
  final String baseUrl = 'https://esimcard.com/api';

  Future<Map<String, dynamic>> getBalance(String token) async {
    final url = Uri.parse('$baseUrl/developer/reseller/balance');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print('📤 Sent to: $url');
      print('📩 Code: ${response.statusCode}');
      print('📨 Body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        return {
          'success': true,
          'balance': (data['balance'] as num).toDouble(),
        };
      } else {
        final message =
            data['message'] ?? 'Erreur lors de la récupération du solde';
        return {'success': false, 'message': message};
      }
    } catch (e) {
      return {'success': false, 'message': 'Erreur réseau: $e'};
    }
  }
}
