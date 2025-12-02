import 'package:konnecti/services/api_client.dart';
import 'package:konnecti/modules/order/order.dart';

class OrderService {
  final ApiClient apiClient;

  OrderService(this.apiClient);

  /// 🔥 Créer une facture SlickPay (pas un order)
  Future<Map<String, dynamic>> createInvoicePayment({
    required int amount,
    required String firstname,
    required String lastname,
    required String phone,
    required String email,
    required String address,
  }) async {
    final response = await apiClient.post("/invoise/create-invoice", {
      "amount": amount,
      "firstname": firstname,
      "lastname": lastname,
      "phone": phone,
      "email": email,
      "address": address,
    });

    if (response["success"] == true) {
      return {
        "invoiceId": response["invoiceId"],
        "paymentUrl": response["paymentUrl"],
      };
    } else {
      throw Exception(response["message"] ?? "Erreur création facture");
    }
  }
}


/*import 'package:konnecti/services/api_client.dart';
import 'package:konnecti/modules/order/order.dart';

class OrderService {
  final ApiClient apiClient;

  OrderService(this.apiClient);

  Future<Map<String, dynamic>> createOrder(
    String userId,
    String packageId,
    String imei,
  ) async {
   /* final response = await apiClient.post("/orders", {
      "userId": userId,
      "packageId": packageId,
      "imei": imei,
      "price": 100,
      "firstname": "Rami",
      "lastname": "Slimani",
    });*/
    final response = await apiClient.post("/orders", {
  "userId": userId,
  "packageId": packageId,
  "imei": imei,
  "price": 100,
  "firstname": "Rami",
  "lastname": "Slimani",
});


    if (response["success"] == true) {
      return {
        "order": Order.fromJson(response["order"]),
        "paymentUrl": response["paymentUrl"],
      };
    } else {
      throw Exception(response["message"] ?? "Erreur création commande");
    }
  }

  Future<Order> confirmPayment(String orderId) async {
    final response = await apiClient.post(
      "/orders/confirm-payment/$orderId",
      {},
    );

    if (response["success"] == true) {
      return Order.fromJson(response["order"]);
    } else {
      throw Exception(response["message"] ?? "Erreur confirmation paiement");
    }
  }
}
*/