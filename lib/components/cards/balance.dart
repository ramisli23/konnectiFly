/*/// ====== API Balance ======
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> getBalance() async {
//  const token = '332551|iSECon0jBq5Owwt5B3v8EG8PHO3iQ47BRePFKLVz8d295a60';
//  final url = Uri.parse('https://esimcard.com/api/developer/reseller/balance');

  try {
    final response = await http.get(
      url,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['status'] == true) {
        return data['balance'].toString();
      } else {
        return "Erreur API";
      }
    } else {
      return "Erreur HTTP ${response.statusCode}";
    }
  } catch (e) {
    return "Erreur: $e";
  }
}
*/
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> getBalance(String userId) async {
  final url = Uri.parse(
    'https://backend-bumm.onrender.com/users/$userId/balance',
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Ton backend renvoie : {"balance": 0}
      if (data.containsKey('balance')) {
        return data['balance'].toString();
      } else {
        return "Erreur: champ balance manquant";
      }
    } else {
      return "Erreur HTTP ${response.statusCode}";
    }
  } catch (e) {
    return "Erreur: $e";
  }
}
