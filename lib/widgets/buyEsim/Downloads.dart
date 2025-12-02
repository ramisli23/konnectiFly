import 'package:flutter/material.dart';

import 'package:konnecti/l10n/app_localizations.dart';

class Downloads extends StatefulWidget {
  const Downloads({super.key});

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(20),
      height: 150,
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.blue),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: Colors.yellow),
              const SizedBox(width: 5),
              const Icon(Icons.star, color: Colors.yellow),
              const SizedBox(width: 5),
              const Icon(Icons.star, color: Colors.yellow),
              const SizedBox(width: 5),
              const Icon(Icons.star, color: Colors.yellow),
              const SizedBox(width: 20),
              Text(
                tr.downloadsCount, // ← "500000+"
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                tr.downloadsLabel, // ← "Downloads"
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            tr.downloadsTitle, // ← "Konnecti for Easy Travel Connectivity"
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            tr.downloadsSubtitle, // ← "Konnecti - Fast and Affordable mode of Connectivity"
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
