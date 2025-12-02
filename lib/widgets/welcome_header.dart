import 'package:flutter/material.dart';
import 'package:konnecti/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

import 'package:konnecti/l10n/app_localizations.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    Provider.of<AuthProvider>(context);
    context.read<AuthProvider>();
    /* final userId = authProvider.userId;

    final user = auth.user;
    final name = user?["email"] ?? "Utilisateur";
    final phone = user?["phone"] ?? "";
    final email = user?["email"] ?? "";
*/
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://example.com/user.jpg'),
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr.welcomeText,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ) /*
              const SizedBox(height: 4),
              Text(
                "$name ($phone)", // 👈 ici ton vrai nom + téléphone
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),*/,
            ],
          ),
          const Spacer(),
          // const Icon(Icons.menu, color: Colors.white),
        ],
      ),
    );
  }
}




/*
class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://example.com/user.jpg'),
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr.welcomeText, // 👈 texte traduit
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Mariya Bek (+901265887596)", // 👈 à rendre dynamique plus tard si besoin
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.menu, color: Colors.white),
        ],
      ),
    );
  }
}
*/