import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Ordersummary extends StatefulWidget {
  final String userId;
  const Ordersummary({super.key, required this.userId});

  @override
  State<Ordersummary> createState() => _OrdersummaryState();
}

class _OrdersummaryState extends State<Ordersummary> {
  List<Map<String, dynamic>> esimCards = [];
  double subTotal = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCart();
  }

  Future<void> fetchCart() async {
    try {
      final response = await http.get(
        Uri.parse("https://backend-bumm.onrender.com/cart/${widget.userId}"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data["status"] == true && data["cart"] != null) {
          final items = data["cart"]["items"] as Map<String, dynamic>;
          final totals = data["cart"]["totals"];

          setState(() {
            esimCards =
                items.values.map<Map<String, dynamic>>((item) {
                  final mapItem = item as Map<String, dynamic>;
                  return {
                    "id": mapItem["id"],
                    "name": mapItem["name"],
                    "quantity": mapItem["quantity"],
                    "isRenew": mapItem["isRenew"],
                    "price": (mapItem["price"] as num).toDouble(),
                    "data_quantity": mapItem["data_quantity"],
                    "data_unit": mapItem["data_unit"],
                    "package_validity": mapItem["package_validity"],
                    "package_validity_unit": mapItem["package_validity_unit"],
                  };
                }).toList();

            subTotal = (totals["sub_total"] as num).toDouble();
            isLoading = false;
          });
        } else {
          setState(() => isLoading = false);
        }
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("❌ Erreur lors du fetch du panier: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> updateRenew(String itemId, bool value) async {
    try {
      final response = await http.patch(
        Uri.parse(
          "https://backend-bumm.onrender.com/cart/update/${widget.userId}",
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"itemId": itemId, "isRenew": value}),
      );
      print("✅ update renew: ${response.body}");
    } catch (e) {
      print("❌ erreur update renew: $e");
    }
  }

  double get totalPrice {
    return esimCards.fold(
      0,
      (sum, card) => sum + (card['quantity'] * (card['price'] ?? 0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (esimCards.isEmpty) {
      return const Center(
        child: Text("🛒 Votre panier est vide", style: TextStyle(fontSize: 18)),
      );
    }

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: const [
              Icon(Icons.shopping_cart_outlined),
              SizedBox(width: 8),
              Text(
                "Order Summary",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(height: 30),

          // List of products
          ...List.generate(esimCards.length, (index) => _esimCard(index)),

          const SizedBox(height: 30),

          // Pricing
          const Text(
            "Pricing",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Sub Total",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
              Text("${subTotal.toStringAsFixed(2)} DZ"),
            ],
          ),

          const SizedBox(height: 20),

          // Discount code
          const Text("Got a discount code?"),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              border: const OutlineInputBorder(),
              hintText: "Enter code",
              suffixIcon: const Icon(Icons.expand_more),
            ),
          ),

          const SizedBox(height: 20),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${totalPrice.toStringAsFixed(2)} DZ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Checkout Button
          ElevatedButton.icon(
            onPressed: () {
              // TODO: checkout call API
            },
            label: const Text(
              "Go to Secure Checkout",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 17,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _esimCard(int index) {
    var card = esimCards[index];
    final price = (card['price'] as num).toDouble();
    final qty = (card['quantity'] as num).toInt();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.sim_card, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              card["name"] ??
                  "${card['data_quantity']} ${card['data_unit']} eSIM ${card['package_validity']} ${card['package_validity_unit']}",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          // quantity controls
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed:
                    qty > 1
                        ? () => setState(() => card['quantity'] = qty - 1)
                        : null,
              ),
              Text(qty.toString()),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => setState(() => card['quantity'] = qty + 1),
              ),
            ],
          ),
          Switch(
            value: card['isRenew'] ?? false,

            activeColor: Colors.blue,
            onChanged: (value) {
              setState(() => card['isRenew'] = value);
              updateRenew(card['id'], value);
            },
          ),
          const SizedBox(width: 4),
          Text(
            "${(qty * price).toStringAsFixed(2)} DZ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

/*
class Ordersummary extends StatefulWidget {
  const Ordersummary({super.key});

  @override
  State<Ordersummary> createState() => _OrdersummaryState();
}

class _OrdersummaryState extends State<Ordersummary> {
  final double unitPrice = 5.06;

  // Chaque produit a sa propre quantité et son switch 'renew'
  List<Map<String, dynamic>> esimCards = [
    {'quantity': 1, 'isRenew': false},
    /* {'quantity': 1, 'isRenew': false},
    {'quantity': 2, 'isRenew': true},*/
  ];

  double get totalPrice {
    return esimCards.fold(
      0,
      (sum, card) => sum + (card['quantity'] * unitPrice),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              Icon(Icons.shopping_cart_outlined),
              SizedBox(width: 8),
              Text(
                "Order Summary",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Divider(height: 30),

          // List of products
          ...List.generate(esimCards.length, (index) => _esimCard(index)),

          SizedBox(height: 30),

          // Pricing
          Text(
            "Pricing",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 17,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sub Total",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
              Text("\$${totalPrice.toStringAsFixed(2)}"),
            ],
          ),

          SizedBox(height: 20),

          // Discount code
          Text("Got a discount code?"),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),

              hintText: "Enter code",
              suffixIcon: Icon(Icons.expand_more),
            ),
          ),

          SizedBox(height: 20),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                "\$${totalPrice.toStringAsFixed(2)}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),

          SizedBox(height: 20),

          // Checkout Button
          ElevatedButton.icon(
            onPressed: () {},

            label: Text(
              "Go to Secure Checkout",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 17,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          SizedBox(height: 10),

          /*  // Footer
          Center(
            child: Column(
              children: [
                Text("Guaranteed safe & secure checkout"),
                SizedBox(height: 10),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  children: [
                    Icon(Icons.apple),
                    Icon(Icons.credit_card),
                    Icon(Icons.security),
                  ],
                ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }

  Widget _esimCard(int index) {
    var card = esimCards[index];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(Icons.sim_card, size: 40),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "1GB eSIM Data for 7 Day",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed:
                    card['quantity'] > 1
                        ? () => setState(() => card['quantity']--)
                        : null,
              ),
              Text(card['quantity'].toString()),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => setState(() => card['quantity']++),
              ),
            ],
          ),
          Switch(
            value: card['isRenew'],
            focusColor: Colors.blue,
            activeColor: Colors.blue,
            onChanged: (value) => setState(() => card['isRenew'] = value),
          ),
          SizedBox(width: 4),
          Text("\$${(card['quantity'] * unitPrice).toStringAsFixed(2)}"),
        ],
      ),
    );
  }
}
*/
