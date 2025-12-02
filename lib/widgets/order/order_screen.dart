import 'package:flutter/material.dart';
import 'package:konnecti/components/cards/PaymentWebView.dart';
import 'package:konnecti/providers/order/order_provider.dart';
import 'package:provider/provider.dart';

class OrderScreen2 extends StatelessWidget {
  final TextEditingController imeiController = TextEditingController();
  final TextEditingController packageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Orders")),
      body: Column(
        children: [
          TextField(
            controller: imeiController,
            decoration: InputDecoration(labelText: "IMEI"),
          ),
          TextField(
            controller: packageController,
            decoration: InputDecoration(labelText: "Package ID"),
          ),
          /*  ElevatedButton(
            onPressed: () {
              orderProvider.createOrder(
                "user123", // TODO: mettre l'ID utilisateur actuel
                packageController.text,
                imeiController.text,
              );
            },
            child: Text("Create Order"),
          ),*/
          ElevatedButton(
            onPressed: () async {
              final data = await orderProvider.createOrderWithPayment(
                price: 10000,
                firstname: "Rami",
                lastname: "Slimani",
                phone: "0555123456",
                email: "rami@example.com",
                address: "Alger",
              );

              if (data != null) {
                final url = data["paymentUrl"];
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Payment URL ready")));

                // 🔥 ouvrir la WebView ici
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => PaymentWebViewe(
                          url: url,
                          userId: 'f7230c76-3e3c-4320-a625-5c02959986f3',
                        ),
                  ),
                );
              }
            },
            child: Text("Create Invoice"),
          ),
          Expanded(
            child:
                orderProvider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      itemCount: orderProvider.orders.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("Package: "),
                          subtitle: Text("Status:"),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
