class PackageDetail {
  final String id;
  final String name;
  final String code;
  final double price;
  final String currency;
  final String type;
  final int validityDays;
  final String description;
  final List<String> supportedCountries;

  PackageDetail({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.currency,
    required this.type,
    required this.validityDays,
    required this.description,
    required this.supportedCountries,
  });

  factory PackageDetail.fromJson(Map<String, dynamic> json) {
    return PackageDetail(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      currency: json['currency'] ?? '',
      type: json['type'] ?? '',
      validityDays: json['validity_days'] ?? 0,
      description: json['description'] ?? '',
      supportedCountries: List<String>.from(json['supported_countries'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "code": code,
      "price": price,
      "currency": currency,
      "type": type,
      "validity_days": validityDays,
      "description": description,
      "supported_countries": supportedCountries,
    };
  }
}
