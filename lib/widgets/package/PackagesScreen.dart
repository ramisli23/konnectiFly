// ignore: file_names

class EsimPackage {
  final String packageCode;
  final String name;
  final String locationCode;
  final double price; // en USD
  final String type; // BASE ou TOPUP

  EsimPackage({
    required this.packageCode,
    required this.name,
    required this.locationCode,
    required this.price,
    required this.type,
  });

  factory EsimPackage.fromJson(Map<String, dynamic> json) {
    return EsimPackage(
      packageCode: json['packageCode'] ?? '',
      name: json['name'] ?? '',
      locationCode: json['locationCode'] ?? '',
      price: (json['price'] ?? 0) / 10000, // car prix *10000
      type: json['type'] ?? 'BASE',
    );
  }
}
