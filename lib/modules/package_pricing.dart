/*class PackagePricing {
  final String id;
  final String name;
  final double price;
  final double data; // quantité (ex: 1, 3, 10)
  final String dataUnit; // ex: GB, MB
  final int validity; // ex: 7, 30
  final String validityUnit; // ex: Day, Month

  PackagePricing({
    required this.id,
    required this.name,
    required this.price,
    required this.data,
    required this.dataUnit,
    required this.validity,
    required this.validityUnit,
  });

  factory PackagePricing.fromJson(Map<String, dynamic> json) {
    return PackagePricing(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      price: double.tryParse(json['price_usd'].toString()) ?? 0.0,
      data: double.tryParse(json['data_quantity'].toString()) ?? 0.0,
      dataUnit: json['data_unit'] ?? '',
      validity: json['package_validity'] ?? 0,
      validityUnit: json['package_validity_unit'] ?? '',
    );
  }

  get packageType => null;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "data_quantity": data,
      "data_unit": dataUnit,
      "package_validity": validity,
      "package_validity_unit": validityUnit,
    };
  }
}
*/

//import 'dart:ffi';
class PackagePricing {
  final String id;
  final String name;
  final double priceUSD;
  final double priceDZD;
  final double data;
  final String dataUnit;
  final int validity;
  final String validityUnit;
  final bool unlimited;
  final String packageType;
  final String mode;

  PackagePricing({
    required this.id,
    required this.name,
    required this.priceUSD,
    required this.priceDZD,
    required this.data,
    required this.dataUnit,
    required this.validity,
    required this.validityUnit,
    required this.unlimited,
    required this.packageType,
    required this.mode,
  });

  factory PackagePricing.fromJson(Map<String, dynamic> json) {
    return PackagePricing(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      priceUSD:
          double.tryParse(
            json['priceUSD']?.toString() ?? json['price']?.toString() ?? "0",
          ) ??
          0.0,
      priceDZD:
          double.tryParse(json['priceDZD']?.toString() ?? "0")?.toDouble() ?? 0,
      data: double.tryParse(json['data_quantity']?.toString() ?? "0") ?? 0.0,
      dataUnit: json['data_unit'] ?? '',
      validity: int.tryParse(json['package_validity']?.toString() ?? "0") ?? 0,
      validityUnit: json['package_validity_unit'] ?? '',
      unlimited: json['is_unlimited'] == true,
      packageType: json['package_type'] ?? '',
      mode: json['mode'] ?? 'limited',
    );
  }
}
