import 'package:flutter/material.dart';
import 'package:konnecti/providers/order/order_provider.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>().orders;

    return Scaffold(
      appBar: AppBar(title: const Text("Mes commandes")),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(""),
            subtitle: Text("Status:"),
            trailing: Text(""),
          );
        },
      ),
    );
  }
}
