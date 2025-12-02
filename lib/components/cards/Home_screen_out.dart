part of component;

class HomeScreenOut extends StatefulWidget {
  @override
  State<HomeScreenOut> createState() => _HomeScreenOutState();
}

class _HomeScreenOutState extends State<HomeScreenOut> {
  String sortOption = "name";
  int selectedIndex = 0; // 0 = Local, 1 = Regional, 2 = Global
  int selectedPackageType = 0; // 0 = DATA-ONLY, 1 = DATA-VOICE-SMS
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  void _loadData() {
    final provider = context.read<PackagesProvider>();

    switch (selectedIndex) {
      case 0:
        provider.fetchCountries();
        break;
      case 1:
        provider.fetchContinents();
        break;
      case 2:
        // global in future
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final provider = context.watch<PackagesProvider>();
    final filteredCountries = provider.filterCountries(searchQuery);

    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(context),

          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // 🔍 Search
                SearchBaree(
                  onChanged: (value) {
                    setState(() => searchQuery = value);
                  },
                  onFilterTap: () => _showSortOptions(context),
                ),

                // DATA ONLY / DATA + VOICE/SMS
                Dataoptions(
                  selectedIndex: selectedPackageType,
                  onSelected: (type) {
                    setState(() => selectedPackageType = type);
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

  //------------------------------------------------------------
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

  //------------------------------------------------------------
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

  //------------------------------------------------------------
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
        child: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            elevation: MaterialStateProperty.all(0),
          ),
          onPressed: _loadData,
          icon: const Icon(Icons.refresh, size: 18, color: Colors.black),
          label: const Text(
            'Refresh',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    switch (selectedIndex) {
      case 0: // LOCAL ESIMS
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredCountries.length,
          itemBuilder: (_, index) {
            final country = filteredCountries[index];

            final packageTypeString =
                selectedPackageType == 0 ? "DATA-ONLY" : "DATA-VOICE-SMS";

            return CountryCard(
              country: country,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => Buyesimdetails(
                          countryId: country.id.toString(),
                          countryName: country.name,
                          imagePath: country.imgUrl,
                          packageType: packageTypeString, // 🟦 FIX IMPORTANT
                        ),
                  ),
                );
              },
            );
          },
        );

      case 1:
        return Text("Continents (à afficher)");

      case 2:
        return Text(local.globalComingSoon);

      default:
        return const SizedBox.shrink();
    }
  }

  //------------------------------------------------------------
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
