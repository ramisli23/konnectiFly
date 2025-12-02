import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:konnecti/modules/continent.dart';

class ContinentService {
  static const String baseUrl = "https://backend-1-f2ms.onrender.com";

  // Récupérer la liste des continents
  static Future<List<Continent>> fetchContinents() async {
    final response = await http.get(Uri.parse("$baseUrl/continents"));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Continent.fromJson(json)).toList();
    } else {
      throw Exception("Erreur lors du chargement des continents");
    }
  }
}
