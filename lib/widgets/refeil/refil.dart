import 'package:flutter/material.dart';
import 'package:konnecti/widgets/order/order_detail.dart';

class Refil extends StatefulWidget {
  const Refil({super.key});

  @override
  State<Refil> createState() => _RefilState();
}

class _RefilState extends State<Refil> {
  String selectedCurrency = "USD";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Wallet Refill"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Well Refill for KONNECTI",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// ---- Devise ----
            const Text(
              "Choose a currency:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _currencyBox("DZD", "2,431.37"),
                _currencyBox("USD", "18.00"),
              ],
            ),

            const SizedBox(height: 20),

            /// ---- Email ----
            _shadowInput(
              "Email",
              TextInputType.emailAddress,
              prefixIcon: Icons.email,
            ),
            const SizedBox(height: 12),

            /// ---- Phone ----
            _shadowInput("Phone", TextInputType.phone, prefixIcon: Icons.phone),
            const SizedBox(height: 20),

            /// ---- Card Info ----
            const Text(
              "Card Information",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  // ---- Card Number ----
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "1234 1234 1234 1234",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      // ---- Card Logos ----
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/png/visa.png",
                            height:
                                30, // taille (tu peux ajuster à 24, 28, etc.)
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            "assets/images/png/mastercard.png",
                            height: 30,
                          ),
                          const SizedBox(width: 8),
                          Image.asset("assets/images/png/amex.png", height: 30),
                        ],
                      ),
                    ],
                  ),

                  const Divider(height: 1, color: Colors.grey),

                  // ---- Expiry + CVC ----
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "MM / YY",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      Container(width: 1, height: 40, color: Colors.grey),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "CVC",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ---- Cardholder ----
            _shadowInput("Full name on card", TextInputType.text),
            const SizedBox(height: 12),

            /// ---- Country ----
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                value: "Algeria",
                items: const [
                  DropdownMenuItem(value: "Algeria", child: Text("Algeria")),
                  DropdownMenuItem(value: "USA", child: Text("USA")),
                  DropdownMenuItem(value: "France", child: Text("France")),
                ],
                onChanged: (val) {},
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// ---- Pay Button ----
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                // 👉 Affiche un loader
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder:
                      (_) => const Center(child: CircularProgressIndicator()),
                );

                // 👉 Simule un délai de paiement (ex: API call Stripe)
                await Future.delayed(const Duration(seconds: 2));

                // 👉 Ferme le loader
                Navigator.pop(context);

                // 👉 Affiche une confirmation (SnackBar)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Paiement réussi ✅")),
                );

                // 👉 Redirige vers la page des commandes
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => OrdersScreen(
                          userId: "23c8a481-de21-4d98-8297-6f0f8bea75ec",
                        ),
                  ),
                );
              },

              child: const Text(
                "Pay",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),

            Center(
              child: Text(
                "Powered by Stripe",
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---- Box devise ----
  Widget _currencyBox(String label, String value) {
    bool isSelected = selectedCurrency == label;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => selectedCurrency = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            border: Border.all(color: isSelected ? Colors.black : Colors.grey),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              "$label $value",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.black : Colors.grey[700],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ---- Champ input avec shadow ----
  Widget _shadowInput(
    String hint,
    TextInputType type, {
    IconData? prefixIcon,
    IconData? suffixIcon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon:
              prefixIcon != null
                  ? Icon(prefixIcon, color: Colors.grey[600], size: 20)
                  : null,
          suffixIcon:
              suffixIcon != null
                  ? Icon(suffixIcon, color: Colors.blue, size: 20)
                  : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
        ),
        keyboardType: type,
      ),
    );
  }
}
