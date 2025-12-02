import 'package:konnecti/modules/country.dart';

class Continent {
  final String id;
  final String name;
  final String imagePath;
  final String banner;
  final List<Country> countries;

  Continent({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.banner,
    this.countries = const [],
  });

  factory Continent.fromJson(Map<String, dynamic> json) {
    return Continent(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      imagePath: json['image_url'] ?? '',
      banner: json['banner'] ?? '',
      countries:
          (json['countries'] is List)
              ? (json['countries'] as List)
                  .map((c) => Country.fromJson(c as Map<String, dynamic>))
                  .toList()
              : [],
    );
  }
}
