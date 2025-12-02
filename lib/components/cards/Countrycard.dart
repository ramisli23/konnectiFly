import 'package:flutter/material.dart';
import 'package:konnecti/modules/country.dart';
import 'package:konnecti/providers/packages_provider.dart';
import 'package:provider/provider.dart';

class CountryCard extends StatelessWidget {
  final Country country;
  final VoidCallback onTap;

  /// 🟦 Type du package envoyé depuis HomeScreen
  final String packageType; // "DATA-ONLY" ou "DATA-VOICE-SMS"

  const CountryCard({
    super.key,
    required this.country,
    required this.onTap,
    required this.packageType,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(country.imgUrl),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),

                  // ⭐ Prix min du pays
                  FutureBuilder<double?>(
                    future: Provider.of<PackagesProvider>(
                      context,
                      listen: false,
                    ).getStartingPrice(
                      country.id,
                      packageType, // 🟦 envoie le type du package ici
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          "Loading...",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        );
                      }

                      final price = snapshot.data;

                      if (price == null) {
                        return const Text(
                          "No offers",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        );
                      }

                      return Text(
                        "Starts from ${price.toInt()} DZD",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
