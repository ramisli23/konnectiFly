import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TopUpPage extends StatefulWidget {
  final String userId;

  const TopUpPage({super.key, required this.userId});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _amountController = TextEditingController();
  double? balance;
  bool isLoading = false;

  final Color primaryBlue = const Color(0xFF1565C0); // Bleu Konnecti
  final Color lightBlue = const Color(0xFF42A5F5);

  @override
  void initState() {
    super.initState();
    _fetchBalance();
  }

  Future<void> _fetchBalance() async {
    setState(() => isLoading = true);
    try {
      final response = await http.get(
        Uri.parse(
          "https://backend-bumm.onrender.com/users/${widget.userId}/balance",
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          balance = double.tryParse(data["balance"].toString());
        });
      }
    } catch (e) {
      debugPrint("⚠️ Erreur balance: $e");
    }
    setState(() => isLoading = false);
  }

  Future<void> _topUpBalance(double amount) async {
    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(
          "https://backend-bumm.onrender.com/users/${widget.userId}/balance/charge",
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"amount": amount}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["success"] == true) {
          setState(() {
            balance = double.tryParse(data["balance"].toString());
          });

          // ✅ Animation + SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green.shade600,
              content: Text(
                "✅ Recharge réussie ! Nouveau solde: ${balance!.toStringAsFixed(2)} DZD",
                style: const TextStyle(color: Colors.white),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint("⚠️ Erreur recharge: $e");
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        title: const Text("💳 Recharger le solde"),
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // ✅ Carte du solde
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: lightBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Votre solde actuel",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              balance != null
                                  ? "${balance!.toStringAsFixed(2)} DZD"
                                  : "Chargement...",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: primaryBlue,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ✅ Champ de saisie
                      TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: "Montant à recharger (DZD)",
                          prefixIcon: Icon(
                            Icons.attach_money,
                            color: primaryBlue,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ✅ Bouton stylisé
                      ElevatedButton(
                        onPressed: () {
                          final amount = double.tryParse(
                            _amountController.text.trim(),
                          );
                          if (amount != null && amount > 0) {
                            _topUpBalance(amount);
                            _amountController.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("❌ Entrez un montant valide"),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          "🚀 Recharger maintenant",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
