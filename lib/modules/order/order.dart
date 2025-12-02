/*class Order {
  final String id;
  final String packageId;
  final String status;
  final String userId;
  final DateTime createdAt;
  final String? imei;

  Order({
    required this.id,
    required this.packageId,
    required this.status,
    required this.userId,
    required this.createdAt,
    this.imei,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"] ?? "",
      packageId: json["packageId"] ?? "",
      status: json["status"] ?? "",
      userId: json["userId"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
      imei: json["imei"],
    );
  }

  void operator [](String other) {}
}
*/
class Order {
  final String id;
  final String userId;
  final String packageId;
  final String imei;
  final String firstname;
  final String lastname;
  final int price;
  final String status;
  String? paymentUrl;
  String? invoiceId;

  Order({
    required this.id,
    required this.userId,
    required this.packageId,
    required this.imei,
    required this.firstname,
    required this.lastname,
    required this.price,
    required this.status,
    this.paymentUrl,
    this.invoiceId,
  });

  Order copyWith({String? status, String? paymentUrl, String? invoiceId}) {
    return Order(
      id: id,
      userId: userId,
      packageId: packageId,
      imei: imei,
      firstname: firstname,
      lastname: lastname,
      price: price,
      status: status ?? this.status,
      paymentUrl: paymentUrl ?? this.paymentUrl,
      invoiceId: invoiceId ?? this.invoiceId,
    );
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"],
      userId: json["userId"],
      packageId: json["packageId"],
      imei: json["imei"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      price: json["price"],
      status: json["status"],
      paymentUrl: json["paymentUrl"],
      invoiceId: json["invoiceId"],
    );
  }
}
