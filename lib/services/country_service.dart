import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:konnecti/modules/country.dart';

class CountryService {
  Future<List<Country>> getPackages() async {
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

      List<Country> packages =
          packagesJson.map((cntr) {
            return Country(
              id: cntr["id"],
              name: cntr["name"],
              code: cntr["code"],
              packages: cntr["code_alpha3"],
              imgUrl: cntr["image_url"],
            );
          }).toList();

      return packages;
    } else {
      throw Exception('Erreur lors du chargement : ${response.statusCode}');
    }
  }
}
