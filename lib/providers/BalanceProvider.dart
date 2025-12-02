import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BalanceProvider extends ChangeNotifier {
  double _balance = 0;
  bool _isLoading = false;

  double get balance => _balance;
  bool get isLoading => _isLoading;

  // Charger le solde depuis l'API
  Future<void> fetchBalance() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        throw Exception("Token non trouvé");
      }

      final response = await http.get(
        Uri.parse("https://esimcard.com/api/developer/reseller/balance"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["status"] == true) {
          _balance = (data["balance"] as num).toDouble();
        } else {
          throw Exception("Réponse API invalide");
        }
      } else {
        throw Exception(
          "Erreur HTTP : ${response.statusCode} - ${response.reasonPhrase}",
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Erreur balance: $e");
      }
    }

    _isLoading = false;
    notifyListeners();
  }
}
