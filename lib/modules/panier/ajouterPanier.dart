import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:konnecti/modules/package_pricing.dart';

Future<void> addToCart({
  required String userId,
  required PackagePricing pack,
}) async {
  final url = Uri.parse("https://backend-1-f2ms.onrender.com/cart/add");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"userId": userId, "packageId": pack.id, "quantity": 1}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['status'] == true) {
      print("✅ Ajouté au panier");
    } else {
      print("❌ Erreur: ${data['message']}");
    }
  } else {
    throw Exception("Erreur API panier: ${response.statusCode}");
  }
}
