import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:konnecti/widgets/package/PackagesScreen.dart';

class EsimpackageService {
  Future<List<EsimPackage>> getPackages() async {
    final url =
        "https://esimcard.com/api/developer/reseller/packages/continent";
    final token = '330552|cxONygI6oTVD7LFAy4Eh7gjqxqmclEsEpLcAxA3w4c4f28a6';

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> packagesJson = data["data"];

      List<EsimPackage> packages =
          packagesJson.map((pkg) {
            final map = pkg as Map<String, dynamic>;
            return EsimPackage(
              packageCode: map["code"] ?? '',
              name: map["name"] ?? '',
              locationCode: map["location_code"] ?? '',
              price:
                  map["price"] != null
                      ? double.tryParse(map["price"].toString()) ?? 0.0
                      : 0.0,
              type: map["type"] ?? '',
            );
          }).toList();

      return packages;
    } else {
      throw Exception('Erreur lors du chargement : ${response.statusCode}');
    }
  }
}
