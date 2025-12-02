import 'package:konnecti/modules/package_pricing.dart';

class Country {
  final String id;
  final String name;
  final String code;
  final String imgUrl;

  // ⚠️ packages ne vient PAS du backend — on le charge manuellement après
  final List<PackagePricing> packages;

  Country({
    required this.id,
    required this.name,
    required this.code,
    required this.imgUrl,
    this.packages = const [],
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      imgUrl: json['flag'] ?? '',
      packages: [], // Pas dans l'API → liste vide
    );
  }

  Country copyWith({
    String? id,
    String? name,
    String? code,
    String? imgUrl,
    List<PackagePricing>? packages,
  }) {
    return Country(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      imgUrl: imgUrl ?? this.imgUrl,
      packages: packages ?? this.packages,
    );
  }
}
