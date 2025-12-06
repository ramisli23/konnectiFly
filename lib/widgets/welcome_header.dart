import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:konnecti/providers/AuthProvider.dart';
import 'package:konnecti/l10n/app_localizations.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final auth = context.watch<AuthProvider>();

    final user = auth.user;
    final name = user?["name"] ?? "Guest";
    final avatar =
        user?["avatar"] ??
        "https://ui-avatars.com/api/?name=$name&background=2196F3&color=fff";

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 22),
      decoration: const BoxDecoration(
        color: Color(0xFF2196F3),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(26)),
      ),
      child: Row(
        children: [
          // AVATAR
          CircleAvatar(radius: 24, backgroundImage: NetworkImage(avatar)),
          const SizedBox(width: 12),

          // TEXT
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, $name 👋",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Stay connected everywhere",
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),

          const Spacer(),

          // NOTIFICATION ICON
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}



/*import 'package:flutter/material.dart';
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
*/*/


