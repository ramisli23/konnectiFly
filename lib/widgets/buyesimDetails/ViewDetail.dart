import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:konnecti/providers/offer_provider.dart';

class Viewdetail extends StatelessWidget {
  const Viewdetail({super.key});

  @override
  Widget build(BuildContext context) {
    final offer = Provider.of<OfferProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Important pour bottom sheet
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Barre de fermeture ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Offer Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // --- Titre + Image ---
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/images/png/analytics.png"),
                radius: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "${offer.days} Day ${offer.data} Data for ${offer.country}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          _buildDetailTile(
            icon: Icons.data_usage,
            label: "Data",
            value: offer.data,
          ),
          const SizedBox(height: 10),

          _buildDetailTile(
            icon: Icons.calendar_today,
            label: "Duration",
            value: "${offer.days}",
          ),
          const SizedBox(height: 10),

          _buildDetailTile(
            icon: Icons.attach_money,
            label: "Price",
            value: "${offer.price} USD",
          ),
          const SizedBox(height: 10),

          _buildDetailTile(
            icon: Icons.wifi_tethering,
            label: "Tethering/Hotspot",
            value: "Available", // ou offer.hotspot si tu l’as
          ),
          const SizedBox(height: 20),

          const Text(
            "Supported Countries & Networks",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          _buildNetworkBox(offer.country, ["Verizon", "AT&T"]),
        ],
      ),
    );
  }

  Widget _buildDetailTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal),
          const SizedBox(width: 10),
          Text(
            "$label:",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkBox(String country, List<String> networks) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children:
            networks.map((net) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.teal),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(net),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "2G, 3G, 4G, 5G",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }
}
