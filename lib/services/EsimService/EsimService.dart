/*import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:konnecti/modules/Esim/OrderDetail.dart';
import 'package:konnecti/modules/Esim/esim.dart';
import 'package:konnecti/modules/Esim/usage.dart';

class EsimService {
  final String baseUrl;
  final String token;

  EsimService({required this.baseUrl, required this.token});

  // 🔹 Récupère toutes les eSIMs de l’utilisateur
  Future<List<Esim>> fetchMyEsims() async {
    final response = await http.get(
      Uri.parse("$baseUrl/my-esims"),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = json['data'] as List;
      return data.map((e) => Esim.fromJson(e)).toList();
    } else {
      throw Exception("Erreur lors de la récupération des eSIMs");
    }
  }

  // 🔹 Vérifie le solde de l’utilisateur
  Future<double> checkBalance(String token) async {
    final url = Uri.parse("$baseUrl/users/balance");

    final response = await http.get(url, headers: _headers());

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return double.tryParse(data['balance'].toString()) ?? 0.0;
    } else {
      throw Exception("Erreur lors de la récupération du solde");
    }
  }

  // 🔹 Acheter un package (corrigé et complet)
  Future<void> buyPackage({
    required String userId,
    required String packageId,
    required int price,
    required String imei,
  }) async {
    final url = Uri.parse('$baseUrl/orders');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'userId': userId,
          'packageId': packageId,
          'price': price,
          'imei': imei,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          print('✅ Achat réussi !');
          print('💰 Nouveau solde : ${data['balance']}');

          final esim = data['order']['esimData']['sim'];
          print('📱 ICCID : ${esim['iccid']}');
          print('📡 QR Code : ${esim['qr_code_text']}');
          print('🔗 Lien Apple : ${esim['universal_link']}');
        } else {
          throw Exception('⚠️ Erreur API : ${data['message']}');
        }
      } else {
        throw Exception(
          '❌ Erreur HTTP ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      print('🚨 Exception lors de l’achat: $e');
      rethrow;
    }
  }

  // 🔹 Récupère le détail d'une eSIM par ID
  Future<Esim> fetchEsimById(String id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/my-esims/$id"),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Esim.fromJson(json['data']);
    } else {
      throw Exception("Erreur lors de la récupération de l'eSIM $id");
    }
  }

  // 🔹 Récupère le détail d'une commande par ID
  Future<List<OrderDetail>> fetchOrderById(String id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/order/$id"),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = json['data'] as List;
      return data.map((e) => OrderDetail.fromJson(e)).toList();
    } else {
      throw Exception("Erreur lors de la récupération de la commande $id");
    }
  }

  // 🔹 Récupère l’utilisation d’une eSIM (data, validité, etc.)
  Future<Usage> fetchEsimUsage(String iccid) async {
    final response = await http.get(
      Uri.parse("$baseUrl/my-sim/$iccid/usage"),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Usage.fromJson(json['data']);
    } else {
      throw Exception(
        "Erreur lors de la récupération de l’usage de l’eSIM $iccid",
      );
    }
  }

  // 🔹 Headers par défaut
  Map<String, String> _headers() => {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
*/
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:konnecti/modules/Esim/esim.dart';
import 'package:konnecti/modules/Esim/OrderDetail.dart';
import 'package:konnecti/modules/Esim/usage.dart';

class EsimService {
  final String baseUrl;
  final String token;

  EsimService({required this.baseUrl, required this.token});

  // 🔹 Headers par défaut
  Map<String, String> get _headers => {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  // 🔹 Méthode centrale pour gérer les réponses HTTP
  dynamic _handleResponse(http.Response response) {
    final int status = response.statusCode;
    if (status == 200 || status == 201) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData['success'] == true || jsonData['data'] != null) {
        return jsonData['data'] ?? jsonData;
      } else {
        throw Exception(jsonData['message'] ?? "Erreur inconnue de l'API");
      }
    } else {
      throw Exception("Erreur HTTP $status: ${response.body}");
    }
  }

  Future<Map<String, dynamic>> createInvoice({
    required int amount,
    required String firstname,
    required String lastname,
    required String phone,
    required String email,
    required String address,
    required String userId,
  }) async {
    final url = Uri.parse('$baseUrl/api/slickpay/create');

    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode({
        'amount': amount,
        'firstname': firstname,
        'lastname': lastname,
        'phone': phone,
        'email': email,
        'address': address,
        'userId': userId,

        // 🔥 OBLIGATOIRE
        "items": [
          {"name": "Recharge eSIM", "price": amount, "quantity": 1},
        ],
      }),
    );

    final data = _handleResponse(response) as Map<String, dynamic>;

    return {"paymentUrl": data["paymentUrl"], "invoiceId": data["invoiceId"]};
  }

  // 🔹 Récupérer toutes les eSIMs de l'utilisateur
  Future<List<Esim>> fetchMyEsims() async {
    final response = await http.get(
      Uri.parse("$baseUrl/my-esims"),
      headers: _headers,
    );
    final data = _handleResponse(response) as List;
    return data.map((e) => Esim.fromJson(e)).toList();
  }

  // 🔹 Acheter un package eSIM (commande + infos eSIM)
  Future<Map<String, dynamic>> buyPackage({
    required String userId,
    required String packageId,
    required int price,
    required String imei,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: _headers,
      body: jsonEncode({
        'userId': userId,
        'packageId': packageId,
        'price': price,
        'imei': imei,
      }),
    );

    final data = _handleResponse(response) as Map<String, dynamic>;
    return {
      'order': data['order'],
      'balance': data['balance'],
      'esimData': data['order']['esimData'],
    };
  }

  // 🔹 Vérifier le solde de l'utilisateur
  Future<double> checkBalance() async {
    final response = await http.get(
      Uri.parse("$baseUrl/users/balance"),
      headers: _headers,
    );
    final data = _handleResponse(response) as Map<String, dynamic>;
    return double.tryParse(data['balance'].toString()) ?? 0.0;
  }

  // 🔹 Récupérer le détail d'une eSIM par ID
  Future<Esim> fetchEsimById(String id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/my-esims/$id"),
      headers: _headers,
    );
    final data = _handleResponse(response) as Map<String, dynamic>;
    return Esim.fromJson(data);
  }

  // 🔹 Récupérer le détail d'une commande par ID
  Future<List<OrderDetail>> fetchOrderById(String id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/order/$id"),
      headers: _headers,
    );
    final data = _handleResponse(response) as List;
    return data.map((e) => OrderDetail.fromJson(e)).toList();
  }

  // 🔹 Récupère l’utilisation d’une eSIM (data, validité, etc.)
  Future<Usage> fetchEsimUsage(String iccid) async {
    final response = await http.get(
      Uri.parse("$baseUrl/my-sim/$iccid/usage"),
      headers: _headers,
    );

    // Utilisation de _handleResponse pour centraliser la gestion des erreurs
    final data = _handleResponse(response) as Map<String, dynamic>;
    return Usage.fromJson(data);
  }
}
