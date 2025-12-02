/*part of component;

class Confirmationorder extends StatefulWidget {
  @override
  State<Confirmationorder> createState() => _ConfirmationorderState();
}

class _ConfirmationorderState extends State<Confirmationorder> {
  String? userId;

  @override
  void initState() {
    super.initState();

    // Récupérer l'ID depuis AuthProvider
    Future.microtask(() {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      userId =
          authProvider.userId; // 👈 Ici tu prends l'id réel de l'utilisateur

      if (userId != null) {
        Provider.of<CartProvider>(context, listen: false).fetchCart(userId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          if (cartProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (userId == null) {
            return Column(children: [TopHeader(), Cardempty()]);
            //Center(child: Text("Utilisateur non connect
            //é"));
          }

          if (cartProvider.itemsCount == 0) {
            return Column(
              children: [
                TopHeader(),
                Cardempty(),
           getBalance(),
                Text("ID utilisateur: $userId"), // 👈 afficher l'id ici
                Text("Articles dans le panier: ${cartProvider.itemsCount}"),
                Text(
                  "Sous-total: \$${cartProvider.subTotal.toStringAsFixed(2)}",
                ),
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  TopHeader(),
                  CustomStepper(currentStep: 1),
                  Text("ID utilisateur: $userId"), // 👈 ou ici
                  Ordersummary(userId: userId!),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
*/
part of component;

class Confirmationorder extends StatefulWidget {
  @override
  State<Confirmationorder> createState() => _ConfirmationorderState();
}

class _ConfirmationorderState extends State<Confirmationorder> {
  String? userId;

  @override
  void initState() {
    super.initState();

    // Récupérer l'ID depuis AuthProvider
    Future.microtask(() {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      userId = authProvider.userId;

      if (userId != null) {
        Provider.of<CartProvider>(context, listen: false).fetchCart(userId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          if (cartProvider.isLoading) {
            return Center(
              child: Lottie.asset(
                "assets/lottie/progess.json", // ton fichier Lottie
                width: 120,
                height: 120,
              ),
            );
          }

          if (userId == null) {
            return Column(children: [TopHeader(), Cardempty()]);
          }

          if (cartProvider.itemsCount == 0) {
            return Column(
              children: [
                TopHeader(),
                Cardempty(),
                Text("ID utilisateur: $userId"),
                Text("Articles dans le panier: ${cartProvider.itemsCount}"),
                Text(
                  "Sous-total: \$${cartProvider.subTotal.toStringAsFixed(2)}",
                ),
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  TopHeader(),
                  CustomStepper(currentStep: 1),

                  // ✅ Affichage du solde avec bouton TopUp
                  FutureBuilder<String?>(
                    future: getBalance(userId!), // 👈 on passe bien l'id ici
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Lottie.asset(
                          "assets/lottie/Trail loading.json",
                          width: 100,
                          height: 100,
                        );
                      }
                      if (snapshot.hasError) {
                        return Text("⚠️ Erreur: ${snapshot.error}");
                      }
                      if (!snapshot.hasData) {
                        return const Text("Aucun solde disponible");
                      }

                      double balance = double.tryParse(snapshot.data!) ?? 0.0;

                      return Column(
                        children: [
                          Availbleblance(balance: balance),
                          const SizedBox(height: 12),

                          /*  ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => /*TopUpPage(
                                        userId: userId!,
                                      ), // ✅ navigation*/
                                          Refil(),
                                ),
                              );
                            },

                            
                            child: const Text(
                              "Top Up Balance",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),*/
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            onPressed: () {
                              final String paymentUrl =
                                  "https://slick-pay.com/invoice/payment/PAY-0412179XXAU3/merchant";

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => PaymentWebViewe(
                                        url: paymentUrl,
                                        userId: "",
                                      ),
                                ),
                              );
                            },
                            child: const Text(
                              "Top Up Balance",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  Ordersummary(userId: userId!),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
