import 'package:flutter/material.dart';
import 'package:konnecti/services/api_client.dart';
import 'package:konnecti/services/order/order_service.dart';
import 'package:konnecti/services/EsimService/EsimService.dart';
import 'package:konnecti/modules/order/order.dart';
import 'package:konnecti/components/cards/PaymentWebView.dart';

class OrderProvider extends ChangeNotifier {
  final OrderService _orderService;
  final EsimService _esimService;

  OrderProvider(String baseUrl, String token)
    : _orderService = OrderService(ApiClient(baseUrl: baseUrl, token: token)),
      _esimService = EsimService(baseUrl: baseUrl, token: token);

  bool _isLoading = false;
  String? _errorMessage;
  List<Order> _orders = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Order> get orders => _orders;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /*
  // ---------------------------------------------------------------
  // 1️⃣ CREATE ORDER SIMPLE (without payment)
  // ---------------------------------------------------------------
  Future<Order?> createOrder({
    required String userId,
    required String packageId,
    required String imei,
  }) async {
    _setLoading(true);

    try {
      final result = await _orderService.createOrder(userId, packageId, imei);

      final order = result["order"] as Order;
      final paymentUrl = result["paymentUrl"];

      // injection payment URL dans l’objet Order
      order.paymentUrl = paymentUrl;

      _orders.add(order);

      return order;
    } catch (e) {
      _errorMessage = e.toString();
      return null;
    } finally {
      _setLoading(false);
    }
  }
*/
  // ---------------------------------------------------------------
  // 2️⃣ CREATE ORDER + INVOICE (SlickPay)
  // ---------------------------------------------------------------
  Future<Map<String, dynamic>?> createOrderWithPayment({
    required int price,
    required String firstname,
    required String lastname,
    required String phone,
    required String email,
    required String address,
  }) async {
    _setLoading(true);

    try {
      final paymentData = await _orderService.createInvoicePayment(
        amount: price,
        firstname: firstname,
        lastname: lastname,
        phone: phone,
        email: email,
        address: address,
      );

      return paymentData;
    } catch (e) {
      _errorMessage = e.toString();
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // ---------------------------------------------------------------
  // 3️⃣ BUY PACKAGE => full flow create → invoice → webview → confirm
  // ---------------------------------------------------------------

  /*
  Future<bool> buyPackage({
    required String userId,
    required String packageId,
    required String imei,
    required String lastname,
    required int price,
    required String firstname,
    required String phone,
    required String email,
    required String address,
    required BuildContext context,
  }) async {
    _setLoading(true);

    try {
      // Create order + invoice SlickPay
      final order = await createOrderWithPayment(
        userId: userId,
        packageId: packageId,
        imei: imei, // FIXED : pas de hardcode
        price: price,
        lastname: lastname,
        firstname: firstname,
        phone: phone,
        email: email, // FIXED : email = vrai email
        address: address,
      );

      if (order == null || order.paymentUrl == null) {
        throw Exception("Impossible de créer la facture");
      }

      // Open payment WebView
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) => PaymentWebViewe(userId: userId, url: order.paymentUrl!),
        ),
      );

      // Confirm payment after WebView closes
      final confirmedOrder = await _orderService.confirmPayment(order.id);
      final paid = confirmedOrder.status == "paid";

      // Update order list
      if (paid) {
        final index = _orders.indexWhere((o) => o.id == order.id);
        if (index >= 0) _orders[index] = confirmedOrder;
      }

      return paid;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }*/
}
