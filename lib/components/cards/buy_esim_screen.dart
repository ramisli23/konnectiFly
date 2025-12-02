part of component;

class BuyEsimScreen extends StatefulWidget {
  const BuyEsimScreen({super.key});

  @override
  State<BuyEsimScreen> createState() => _BuyEsimScreenState();
}

class _BuyEsimScreenState extends State<BuyEsimScreen> {
  String sortOption = "name"; // ✅ "name" ou "price"

  int selectedIndex =
      0; // Onglet sélectionné : 0 = local, 1 = regional, 2 = global
  int selectedPackageType = 0; // 0 = DATA-ONLY, 1 = DATA-VOICE-SMS
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final provider = Provider.of<PackagesProvider>(context, listen: false);

    switch (selectedIndex) {
      case 0:
        provider.fetchCountries();
        break;
      case 1:
        provider.fetchContinents();
        break;
      case 2:
        // provider.fetchGlobalPackages();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final provider = Provider.of<PackagesProvider>(context);

    // Filtrer les pays selon la recherche
    final filteredCountries = provider.filterCountries(searchQuery);

    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(context),
          SingleChildScrollView(
            child: Column(
              children: [
                TopHeader(),
                Downloads(),
                Dataoptions(
                  selectedIndex: selectedPackageType,
                  onSelected: (int type) {
                    setState(() {
                      selectedPackageType = type;
                    });
                  },
                ),
                SearchBaree(
                  onChanged: (String value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  onFilterTap: () {
                    _showSortOptions(context);
                  },
                ),

                _buildTabs(local),
                _buildContent(provider, local, filteredCountries),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
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

  Widget _buildTabs(AppLocalizations local) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildOption(local.localEsims, 0),
          const SizedBox(width: 20),
          _buildOption(local.regionalEsims, 1),
          const SizedBox(width: 20),
          _buildOption(local.globalEsims, 2),
        ],
      ),
    );
  }

  Widget _buildOption(String title, int index) {
    bool isSelected = selectedIndex == index;

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

  Widget _buildContent(
    PackagesProvider provider,
    AppLocalizations local,
    List<Country> filteredCountries,
  ) {
    if (provider.isLoading) {
      return Padding(
        padding: const EdgeInsets.all(50),
        child: Lottie.asset(
          "assets/lottie/Trail loading.json",
          width: 100,
          height: 100,
        ),
      );
    }

    if (provider.errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: // Text("Erreur : ${provider.errorMessage}"),
            ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            elevation: MaterialStateProperty.all(0),
          ),
          onPressed: () {
            _loadData();
          },

          label: Text(
            'Refresh',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          icon: Icon(Icons.refresh, size: 18, color: Colors.black),
        ),
      );
    }

    switch (selectedIndex) {
      case 0:
        // Filtrer les packages pour chaque pays selon le type sélectionné
        final countriesWithFilteredPackages =
            filteredCountries.map((country) {
              final filteredPackages =
                  country.packages.where((p) {
                    return selectedPackageType == 0
                        ? p.packageType == "DATA-ONLY"
                        : p.packageType == "DATA-VOICE-SMS";
                  }).toList();

              return Country(
                id: country.id,
                name: country.name,
                code: country.code,
                imgUrl: country.imgUrl,
                packages: filteredPackages,
              );
            }).toList();

        return LocalCountriesView(
          countries: countriesWithFilteredPackages,
          packageType:
              selectedPackageType == 0 ? "DATA-ONLY" : "DATA-VOICE-SMS",
        );

      case 1:
        return Text("local.comingSoon");

      case 2:
        return Text(local.globalComingSoon);

      default:
        return const SizedBox.shrink();
    }
  }

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.sort_by_alpha),
              title: const Text("Trier par nom"),
              onTap: () {
                setState(() {
                  sortOption = "name";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.monetization_on),
              title: const Text("Trier par prix"),
              onTap: () {
                setState(() {
                  sortOption = "price";
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
