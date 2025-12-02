part of component;

class Myesim extends StatefulWidget {
  const Myesim({super.key});

  @override
  State<Myesim> createState() => _MyesimState();
}

class _MyesimState extends State<Myesim> {
  @override
  void initState() {
    super.initState();

    // Récupérer les providers après le build initial
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = context.read<AuthProvider>();
      final cartProvider = context.read<CartProvider>();
      final dataonlyProvider = context.read<DataonlyProvider>();
      final datavoicesmsProvider = context.read<Datavoicesmsserviceprovider>();

      final userId = authProvider.userId;

      if (userId != null && userId.trim().isNotEmpty) {
        dataonlyProvider.fetchUserEsims(userId);
        datavoicesmsProvider.fetchDatavoicesms();
        cartProvider.fetchCart(userId);
      } else {
        debugPrint("⚠️ Aucun userId trouvé dans AuthProvider");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🎨 Background blanc
          Column(children: [Expanded(child: Container(color: Colors.white))]),

          SingleChildScrollView(
            child: Column(
              children: [
                TopHeader(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Text(
                        "Sims Details",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Lottie.asset(
                        "assets/lottie/Trail loading.json",
                        width: 100,
                        height: 100,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                const Text(
                  "My Sims",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // ✅ DataOnly eSIMs
                Container(
                  height: 500,
                  color: Colors.white,
                  child: Consumer<DataonlyProvider>(
                    builder: (context, provider, _) {
                      if (provider.isLoading) {
                        return Center(
                          child: Lottie.asset(
                            "assets/lottie/Trail loading.json",
                            width: 100,
                            height: 100,
                          ),
                        );
                      }

                      if (provider.errorMessage != null) {
                        return Center(
                          child: Text(
                            "Erreur: ${provider.errorMessage}",
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      if (provider.esims.isEmpty) {
                        return const Center(
                          child: Text(
                            "Aucune eSIM trouvée",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }

                      return Dataonlydetail(esims: provider.esims);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
