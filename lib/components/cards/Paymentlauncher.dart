import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentURLLauncher extends StatefulWidget {
  final String url;

  const PaymentURLLauncher({super.key, required this.url});

  @override
  State<PaymentURLLauncher> createState() => _PaymentURLLauncherState();
}

class _PaymentURLLauncherState extends State<PaymentURLLauncher> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _openPaymentPage();
  }

  Future<void> _openPaymentPage() async {
    final Uri uri = Uri.parse(widget.url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // navigateur externe
      );

      // On ferme la page Flutter une fois le navigateur ouvert
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.pop(context);
        }
      });
    } else {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Impossible d’ouvrir le lien de paiement"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Paiement"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child:
            isLoading
                ? Lottie.asset(
                  'assets/lottie/progess.json',
                  width: 180,
                  height: 180,
                )
                : const Text("Erreur lors de l’ouverture du paiement"),
      ),
    );
  }
}
