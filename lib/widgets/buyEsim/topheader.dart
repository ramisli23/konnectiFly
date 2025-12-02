import 'package:flutter/material.dart';
import 'package:konnecti/providers/cart/CartProvider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:konnecti/components/components.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 22),
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo + bouton retour
          Row(
            children: [
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "kONNECTI",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ),
            ],
          ),

          // Panier avec badge
          // Panier avec badge
          GestureDetector(
            onTap: () async {
              // Affiche Lottie pendant le "chargement"
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return Center(
                    child: Lottie.asset(
                      "assets/lottie/progess.json", // ton fichier Lottie
                      width: 120,
                      height: 120,
                    ),
                  );
                },
              );

              // Simule un petit temps d’attente (500 ms)
              await Future.delayed(const Duration(milliseconds: 500));

              // Ferme le Lottie
              Navigator.pop(context);

              // Navigue vers Confirmationorder
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Confirmationorder()),
              );
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(Icons.shopping_cart_outlined, size: 24),
                ),

                // Badge dynamique depuis CartProvider
                Positioned(
                  top: 0,
                  right: 0,
                  child: Consumer<CartProvider>(
                    builder: (context, cartProvider, _) {
                      final count = cartProvider.itemsCount;
                      if (count == 0) return const SizedBox.shrink();
                      return CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.blue,
                        child: Text(
                          "$count",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
