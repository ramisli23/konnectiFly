part of component;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String sortOption = "name";
  int selectedIndex = 0; // 0=Local, 1=Regional, 2=Global
  int selectedPackageType = 0; // 0=DATA-ONLY, 1=DATA-VOICE-SMS
  String searchQuery = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  // ---------------------------------------------------
  // 🔥 Charge Countries / Continents + Preload Packages
  // ---------------------------------------------------
  Future<void> _loadData() async {
    final provider = context.read<PackagesProvider>();

    final type = selectedPackageType == 0 ? "DATA-ONLY" : "DATA-VOICE-SMS";

    print("📥 HomeScreen: LoadData()");
    print("🌍 Section index = $selectedIndex");
    print("📦 Package type = $type");

    if (selectedIndex == 0) {
      print("➡ FETCH /countries");
      await provider.fetchCountries(force: true);

      print("🚀 Preloading packages for all countries...");
      await provider.preloadPackagesForAllCountries(type);
      print("✔ Preload done");
    }

    if (selectedIndex == 1) {
      print("➡ FETCH /continents");
      await provider.fetchContinents(force: true);
    }
  }

  // ---------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          _background(context),

          SingleChildScrollView(
            child: Column(
              children: [
                WelcomeHeader(),

                SearchBaree(
                  onChanged: (v) => setState(() => searchQuery = v),
                  onFilterTap: () => _showSortOptions(context),
                ),

                CountryCarousel(),

                /// 🔵 DATA-ONLY / DATA-VOICE-SMS SWITCH
                Dataoptions(
                  selectedIndex: selectedPackageType,
                  onSelected: (t) {
                    setState(() => selectedPackageType = t);
                    _loadData(); // 🔥 recharge les bons packages
                  },
                ),

                _tabs(local),

                Consumer<PackagesProvider>(
                  builder: (_, provider, __) {
                    final filtered = provider.filterCountries(searchQuery);
                    return _buildContent(provider, local, filtered);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------
  Widget _background(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        Expanded(child: Container(color: Colors.white)),
      ],
    );
  }

  // ---------------------------------------------------
  Widget _tabs(AppLocalizations local) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _tab(local.localEsims, 0),
          const SizedBox(width: 20),
          _tab(local.regionalEsims, 1),
          const SizedBox(width: 20),
          _tab(local.globalEsims, 2),
        ],
      ),
    );
  }

  Widget _tab(String title, int index) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          searchQuery = "";
        });
        _loadData();
      },
      child: Container(
        width: 110,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------
  Widget _buildContent(
    PackagesProvider provider,
    AppLocalizations local,
    List<Country> countries,
  ) {
    if (provider.isLoading) {
      return Padding(
        padding: const EdgeInsets.all(40),
        child: Lottie.asset(
          "assets/lottie/Trail loading.json",
          width: 100,
          height: 100,
        ),
      );
    }

    if (provider.errorMessage != null) {
      print("❌ Error = ${provider.errorMessage}");
      return ElevatedButton.icon(
        onPressed: _loadData,
        icon: const Icon(Icons.refresh, color: Colors.black),
        label: const Text("Refresh"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    }

    switch (selectedIndex) {
      case 0:
        return _buildLocalCountries(countries);

      case 1:
        return Regionalesims(
          continents: provider.continents,
          packageType:
              selectedPackageType == 0 ? "DATA-ONLY" : "DATA-VOICE-SMS",
        );

      case 2:
        return Text(local.globalComingSoon);

      default:
        return const SizedBox.shrink();
    }
  }

  // ---------------------------------------------------
  Widget _buildLocalCountries(List<Country> countries) {
    final type = selectedPackageType == 0 ? "DATA-ONLY" : "DATA-VOICE-SMS";

    final filtered =
        countries.map((c) {
          final pkgs = c.packages.where((p) => p.packageType == type).toList();
          return c.copyWith(packages: pkgs);
        }).toList();

    if (sortOption == "name") {
      filtered.sort((a, b) => a.name.compareTo(b.name));
    } else {
      filtered.sort((a, b) {
        if (a.packages.isEmpty || b.packages.isEmpty) return 0;
        return a.packages.first.priceDZD.compareTo(b.packages.first.priceDZD);
      });
    }

    return LocalCountriesView(
      countries: filtered,
      packageType: type, // 🟦 IMPORTANT pour CountryCard
    );
  }

  // ---------------------------------------------------
  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.sort_by_alpha),
              title: const Text("Trier par nom"),
              onTap: () {
                setState(() => sortOption = "name");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.monetization_on),
              title: const Text("Trier par prix"),
              onTap: () {
                setState(() => sortOption = "price");
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
