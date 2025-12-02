part of component;

class Buyesimdetails extends StatefulWidget {
  final String countryId;
  final String countryName;
  final String imagePath;
  final String packageType;

  const Buyesimdetails({
    super.key,
    required this.countryId,
    required this.countryName,
    required this.imagePath,
    required this.packageType,
  });

  @override
  State<Buyesimdetails> createState() => _BuyesimdetailsState();
}

class _BuyesimdetailsState extends State<Buyesimdetails> {
  late final EsimService _esimService;
  final authProvider = AuthProvider();

  Future<List<PackagePricing>>? _packagesFuture;
  bool _isUnlimited = false;

  /// 🔄 Charger selon le mode (Limited / Unlimited)
  Future<void> _loadData() async {
    try {
      final provider = context.read<PackagesProvider>();
      final mode = _isUnlimited ? "unlimited" : "limited";

      setState(() {
        _packagesFuture = provider.fetchPackagesByCountry(
          countryId: widget.countryId,
          type: "DATA-ONLY",
          mode: mode,
        );
      });
    } catch (e) {
      debugPrint("Erreur lors du reload : $e");
      showCenterMessage(context, "⚠️ Erreur : $e");
    }
  }

  @override
  void initState() {
    super.initState();

    final provider = context.read<PackagesProvider>();

    /// 🟢 Chargement initial : LIMITED (correct)
    _packagesFuture = provider.fetchPackagesByCountry(
      countryId: widget.countryId,
      type: "DATA-ONLY",
      mode: "limited",
    );

    _esimService = EsimService(
      baseUrl: "https://backend-bumm.onrender.com",
      token: authProvider.accessToken ?? "",
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = context.read<AuthProvider>();
      final cart = context.read<CartProvider>();

      if (auth.userId?.isNotEmpty == true) {
        cart.fetchCart(auth.userId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<PackagePricing>>(
        future: _packagesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _loader();
          }

          if (snapshot.hasError) {
            return _errorReloadButton();
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucun package trouvé"));
          }

          /// Filtrer selon mode
          final packages =
              snapshot.data!.where((p) => p.unlimited == _isUnlimited).toList();

          if (packages.isEmpty) {
            return const Center(child: Text("Aucune offre disponible"));
          }

          return CustomScrollView(
            slivers: [
              _header(),
              SliverToBoxAdapter(
                child: Preparedtravel(
                  country: widget.countryName,
                  imagePath: widget.imagePath,
                  price: "${packages.first.priceDZD}",
                ),
              ),

              /// Switch LIMITED / UNLIMITED
              SliverToBoxAdapter(
                child: Switchbar(
                  isUnlimited: _isUnlimited,
                  onChanged: (val) {
                    setState(() => _isUnlimited = val);
                    _loadData(); // 🔥 recharge les packages
                  },
                ),
              ),

              /// Grid des offres
              _offersGrid(packages),

              /// Boutons Panier + Achat
              SliverToBoxAdapter(child: _actionButtons(packages)),
            ],
          );
        },
      ),
    );
  }

  // ------------------ UI HELPERS ------------------

  Widget _loader() {
    return Center(
      child: Lottie.asset(
        "assets/lottie/progess.json",
        width: 120,
        height: 120,
      ),
    );
  }

  Widget _errorReloadButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _loadData,
        icon: const Icon(Icons.refresh, color: Colors.black),
        label: const Text(
          "Refresh",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }

  Widget _header() {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _offersGrid(List<PackagePricing> packages) {
    return SliverPadding(
      padding: const EdgeInsets.all(12.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final p = packages[index];
          return Offrecards(
            mainImagePath: widget.imagePath,
            data: "${p.data} ${p.dataUnit}",
            days: "${p.validity} ${p.validityUnit}",
            price: "${p.priceDZD}",
            country: widget.countryName,
            mainPrice: "${p.priceDZD}",
            isUnlimited: p.unlimited,
          );
        }, childCount: packages.length),
      ),
    );
  }

  Widget _actionButtons(List<PackagePricing> packages) {
    final auth = context.read<AuthProvider>();
    final userId = auth.userId;
    final p = packages.first;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          /// Panier
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (userId == null || userId.isEmpty) {
                  showCenterMessage(context, "Veuillez vous connecter");
                  return;
                }

                final cartItem = {
                  "country_id": widget.countryId,
                  "package_type": p.packageType,
                  "package_id": p.id,
                  "name": p.name,
                  "data_quantity": p.data,
                  "data_unit": p.dataUnit,
                  "package_validity": p.validity,
                  "package_validity_unit": p.validityUnit,
                  "price": p.priceDZD,
                  "unlimited": p.unlimited,
                  "quantity": 1,
                };

                context.read<CartProvider>().addToCart(userId, cartItem);
                _showSuccessAnimation("assets/lottie/OCL Confirmed.json");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text("Ajouter au panier"),
            ),
          ),

          const SizedBox(width: 10),

          /// Achat direct
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                if (userId == null || userId.isEmpty) {
                  showCenterMessage(context, "Veuillez vous connecter");
                  return;
                }

                try {
                  final orderProvider = context.read<OrderProvider>();

                  // 🔥 Création facture SlickPay
                  final invoice = await orderProvider.createOrderWithPayment(
                    firstname: "Rami",
                    lastname: "Slimani",
                    phone: "0770000000",
                    email: "rami@example.com",
                    address: "Alger, Algérie",
                    price: p.priceDZD.toInt(),
                  );

                  if (invoice == null) {
                    showCenterMessage(context, "Erreur création facture");
                    return;
                  }

                  final paymentUrl = invoice["paymentUrl"];

                  if (paymentUrl == null) {
                    showCenterMessage(context, "Payment URL introuvable");
                    return;
                  }

                  // 🔵 Afficher Lottie avant redirection
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder:
                        (_) => Center(
                          child: Lottie.asset(
                            "assets/lottie/progess.json",
                            width: 150,
                            height: 150,
                          ),
                        ),
                  );

                  await Future.delayed(const Duration(seconds: 1));
                  Navigator.pop(context); // enlever loader

                  // 🚀 Ouvrir la WebView SlickPay
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => PaymentWebViewe(url: paymentUrl, userId: ''),
                    ),
                  );
                } catch (e) {
                  showCenterMessage(context, "Erreur: $e");
                }
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text("Acheter maintenant"),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------ NOTIFICATION ------------------

  void _showSuccessAnimation(String asset) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => Center(
            child: Lottie.asset(
              asset,
              width: 200,
              height: 200,
              repeat: false,
              onLoaded: (c) {
                Future.delayed(c.duration, () => Navigator.pop(context));
              },
            ),
          ),
    );
  }

  void showCenterMessage(BuildContext context, String msg) {
    final overlay = Overlay.of(context);

    final entry = OverlayEntry(
      builder:
          (_) => Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                msg,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
    );

    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 2), () => entry.remove());
  }
}
