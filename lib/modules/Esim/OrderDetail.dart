import 'esim.dart';

class OrderDetail {
  final String id;
  final String package;
  final double initialData;
  final String initialUnit;
  final double remainingData;
  final String remainingUnit;
  final String status;
  final Esim sim;

  OrderDetail({
    required this.id,
    required this.package,
    required this.initialData,
    required this.initialUnit,
    required this.remainingData,
    required this.remainingUnit,
    required this.status,
    required this.sim,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'] ?? '',
      package: json['package'] ?? '',
      initialData: (json['initial_data_quantity'] ?? 0).toDouble(),
      initialUnit: json['initial_data_unit'] ?? '',
      remainingData: (json['rem_data_quantity'] ?? 0).toDouble(),
      remainingUnit: json['rem_data_unit'] ?? '',
      status: json['status'] ?? '',
      sim: Esim.fromJson(json['sim']),
    );
  }
}
