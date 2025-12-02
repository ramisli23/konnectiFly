class Usage {
  final double initialDataQuantity;
  final String initialDataUnit;
  final double remDataQuantity;
  final String remDataUnit;

  Usage({
    required this.initialDataQuantity,
    required this.initialDataUnit,
    required this.remDataQuantity,
    required this.remDataUnit,
  });

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(
      initialDataQuantity: (json['initial_data_quantity'] as num).toDouble(),
      initialDataUnit: json['initial_data_unit'],
      remDataQuantity: (json['rem_data_quantity'] as num).toDouble(),
      remDataUnit: json['rem_data_unit'],
    );
  }
}
