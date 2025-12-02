class Package {
  final String id;
  final String packageTypeId;
  final String simId;
  final String packageName;
  final double initialDataQuantity;
  final String initialDataUnit;
  final double remDataQuantity;
  final String remDataUnit;
  final String status;
  final DateTime dateCreated;
  final DateTime dateActivated;
  final DateTime dateExpiry;
  final bool activated;

  Package({
    required this.id,
    required this.packageTypeId,
    required this.simId,
    required this.packageName,
    required this.initialDataQuantity,
    required this.initialDataUnit,
    required this.remDataQuantity,
    required this.remDataUnit,
    required this.status,
    required this.dateCreated,
    required this.dateActivated,
    required this.dateExpiry,
    required this.activated,
  });
  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'] ?? '',
      packageTypeId: json['package_type_id'] ?? '',
      simId: json['sim_id'] ?? '',
      packageName: json['package'] ?? '',
      initialDataQuantity:
          (json['initial_data_quantity'] as num?)?.toDouble() ?? 0.0,
      initialDataUnit: json['initial_data_unit'] ?? '',
      remDataQuantity: (json['rem_data_quantity'] as num?)?.toDouble() ?? 0.0,
      remDataUnit: json['rem_data_unit'] ?? '',
      status: json['status'] ?? '',
      dateCreated:
          json['date_created'] != null
              ? DateTime.parse(json['date_created'])
              : DateTime.now(),
      dateActivated:
          json['date_activated'] != null
              ? DateTime.parse(json['date_activated'])
              : DateTime.now(),
      dateExpiry:
          json['date_expiry'] != null
              ? DateTime.parse(json['date_expiry'])
              : DateTime.now(),
      activated: json['activated'] ?? false,
    );
  }
}
