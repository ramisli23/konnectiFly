import 'package:flutter/material.dart';
import 'package:konnecti/components/components.dart';
import 'package:konnecti/providers/AuthProvider.dart';
import 'package:konnecti/services/auth_logout.dart';
import 'package:provider/provider.dart';

// Supposons que tu as déjà importé ta classe AuthLogout

class LogoutWidget extends StatefulWidget {
  final String token;

  const LogoutWidget({required this.token, Key? key}) : super(key: key);

  @override
  State<LogoutWidget> createState() => _LogoutWidgetState();
}

class _LogoutWidgetState extends State<LogoutWidget> {
  final AuthLogout authLogout = AuthLogout();
  bool isLoading = false;

  void handleLogout() async {
    setState(() {
      isLoading = true;
    });

    final token = Provider.of<AuthProvider>(context, listen: false).accessToken;

    final authLogout = AuthLogout();
    final result = await authLogout.logout(context, token!);

    setState(() {
      isLoading = false;
    });

    if (result['success']) {
      // Déconnexion réussie, on navigue vers écran login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      // Affiche erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Erreur inconnue')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : handleLogout,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff0076F7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child:
          isLoading
              ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
              : const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
    );
  }
}
