import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CartProvider with ChangeNotifier {
  bool isLoading = false;
  List<Map<String, dynamic>> cartItems = [];
  int itemsCount = 0;
  double subTotal = 0.0;

  final String baseUrl = "https://backend-1-f2ms.onrender.com/cart";
  final Dio _dio = Dio();

  /// 🔹 Récupérer le panier
  Future<void> fetchCart(String userId) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _dio.get("$baseUrl/$userId");

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data["cart"] != null) {
        final userCart = response.data["cart"];

        final itemsMap = userCart["items"] as Map<String, dynamic>? ?? {};

        cartItems =
            itemsMap.entries.map<Map<String, dynamic>>((entry) {
              final itemData = entry.value as Map<String, dynamic>;
              return {
                "id": entry.key,
                "name": itemData["name"] ?? entry.key,
                "price": (itemData["price"] ?? 0).toDouble(),
                "quantity": (itemData["quantity"] ?? 0).toInt(),
              };
            }).toList();

        itemsCount = userCart["totals"]["items_count"] ?? 0;
        subTotal = (userCart["totals"]["sub_total"] ?? 0).toDouble();
      } else {
        _resetCart();
      }
    } catch (e) {
      print("❌ Erreur fetch panier: $e");
      _resetCart();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// 🔹 Ajouter au panier → envoie tout le package
  Future<bool> addToCart(String userId, Map<String, dynamic> package) async {
    try {
      final response = await _dio.post("$baseUrl/$userId/items", data: package);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchCart(userId); // refresh après ajout
        return true;
      }
    } catch (e) {
      print("❌ Erreur ajout panier: $e");
    }
    return false;
  }

  /// 🔹 Supprimer un item
  Future<void> removeFromCart(String userId, String itemId) async {
    try {
      await _dio.delete("$baseUrl/$userId/items/$itemId");
      await fetchCart(userId);
    } catch (e) {
      print("❌ Erreur suppression panier: $e");
    }
  }

  /// 🔹 Vider le panier
  Future<void> clearCart(String userId) async {
    try {
      await _dio.delete("$baseUrl/$userId/clear");
      _resetCart();
      notifyListeners();
    } catch (e) {
      print("❌ Erreur vidage panier: $e");
    }
  }

  void _resetCart() {
    cartItems = [];
    itemsCount = 0;
    subTotal = 0.0;
  }
}



/*import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CartProvider with ChangeNotifier {
  bool isLoading = false;
  List<dynamic> cartItems = [];

  final String baseUrl = "https://backend-1-f2ms.onrender.com/"; // ton backend

  Future<void> fetchCart(String userId) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await Dio().get("$baseUrl/$userId");

      if (response.data["success"]) {
        cartItems = response.data["cart"];
      } else {
        cartItems = [];
      }
    } catch (e) {
      cartItems = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToCart(String userId, String offerId, int quantity) async {
    try {
      await Dio().post(
        "$baseUrl/add",
        data: {"userId": userId, "offerId": offerId, "quantity": quantity},
      );
      // refresh panier après ajout
      await fetchCart(userId);
    } catch (e) {
      print("Erreur ajout panier: $e");
    }
  }
}
*/