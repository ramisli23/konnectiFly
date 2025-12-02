import 'package:flutter/material.dart';

import 'package:konnecti/l10n/app_localizations.dart';
import 'package:konnecti/components/components.dart';
import 'package:konnecti/modules/country.dart';
import 'package:konnecti/providers/packages_provider.dart';
import 'package:konnecti/widgets/country_card.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LocalCountriesView extends StatefulWidget {
  final List<Country> countries; // ✅ ajouter ça
  final String packageType;
  const LocalCountriesView({
    super.key,
    required this.countries,
    required this.packageType,
  });

  @override
  State<LocalCountriesView> createState() => _LocalCountriesViewState();
}

class _LocalCountriesViewState extends State<LocalCountriesView> {
  @override
  void initState() {
    super.initState();
    // ⚠️ ne pas re-fetch ici sinon ça écrase le filtrage
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<PackagesProvider>(context, listen: false).fetchCountries();
    // });
  }

  /*
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final countries = widget.countries; // ✅ utiliser ceux passés en paramètre

    if (countries.isEmpty) {
      return Center(
        child: Text(
          "Aucune offre disponible",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          local.exploreEsimsTitle,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: countries.length,
          itemBuilder: (context, index) {
            final country = countries[index];
            return CountryCard(
              country: country,
              onTap: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return Center(
                      child: Lottie.asset('assets/lottie/progess.json'),
                    );
                  },
                );

                await Future.delayed(const Duration(milliseconds: 500));

                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => Buyesimdetails(
                          countryId: country.id.toString(),
                          countryName: country.name,
                          imagePath: country.imgUrl,
                        ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
*/
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final countries = widget.countries;

    return Consumer<PackagesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          // 👉 Pendant le chargement : afficher Lottie
          return Center(
            child: Lottie.asset(
              'assets/lottie/progess.json',
              width: 120,
              height: 120,
            ),
          );
        }

        if (countries.isEmpty) {
          // 👉 Si aucune donnée
          return Center(
            child: Text(
              "Aucune offre disponible",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          );
        }

        // 👉 Si données présentes
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              local.exploreEsimsTitle,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];
                return CountryCard(
                  country: country,
                  onTap: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return Center(
                          child: Lottie.asset(
                            'assets/lottie/progess.json',
                            width: 100,
                            height: 100,
                          ),
                        );
                      },
                    );

                    await Future.delayed(const Duration(milliseconds: 500));

                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => Buyesimdetails(
                              countryId: country.id.toString(),
                              countryName: country.name,
                              imagePath: country.imgUrl,
                              packageType: widget.packageType,
                            ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
