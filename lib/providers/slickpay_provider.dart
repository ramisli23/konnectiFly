import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SlickPayProvider with ChangeNotifier {
  String? paymentUrl;
  bool isLoading = false;
  String? errorMessage;

  Future<void> createInvoice({
    required double amount,
    required String firstname,
    required String lastname,
    required String phone,
    required String email,
    required String address,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    const String apiUrl = "https://backend-bumm.onrender.com/api/slickpay/create-invoice";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "amount": amount,
          "firstname": firstname,
          "lastname": lastname,
          "phone": phone,
          "email": email,
          "address": address,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        paymentUrl = data["paymentUrl"];
      } else {
        errorMessage = data["message"] ?? "Erreur lors de la création de la facture.";
      }
    } catch (e) {
      errorMessage = "Erreur réseau : $e";
    }

    isLoading = false;
    notifyListeners();
  }

  void reset() {
    paymentUrl = null;
    errorMessage = null;
    notifyListeners();
  }
}
