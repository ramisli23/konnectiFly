import 'package:flutter/material.dart';
import 'package:konnecti/components/components.dart';

import 'package:konnecti/l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:konnecti/modules/continent.dart';
import 'package:lottie/lottie.dart';

class Regionalesims extends StatelessWidget {
  final List<Continent> continents;
  final String packageType;
  const Regionalesims({
    super.key,
    required this.continents,
    required this.packageType,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (continents.isEmpty) {
      return const Center(child: Text("Aucune offre disponible"));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          local.regionalEsimSubtitle,
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
          itemCount: continents.length,
          itemBuilder: (context, index) {
            final continent = continents[index];
            return _continentCard(
              context: context,
              title: continent.name,
              imageUrl: continent.banner,
              continentId: continent.id,
            );
          },
        ),
      ],
    );
  }

  Widget _continentCard({
    required BuildContext context,
    required String title,
    required String imageUrl,
    required String continentId,
  }) {
    return GestureDetector(
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
                  countryId: continentId, // 🟦 ID du continent
                  countryName: title, // 🟦 Nom du continent
                  imagePath: imageUrl, // 🟦 Image (banner)
                  packageType: packageType, // 🟦 DATA-ONLY / DATA-VOICE-SMS
                ),
          ),
        );
      },

      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child:
                  imageUrl.toLowerCase().endsWith(".svg")
                      ? SvgPicture.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        placeholderBuilder:
                            (_) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                      )
                      : Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder:
                            (_, __, ___) => Image.asset(
                              "assets/images/png/asia.png",
                              fit: BoxFit.cover,
                            ),
                      ),
            ),
          ),

          Positioned(
            left: 40,
            top: 22,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 3,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),

          const Positioned(
            right: 40,
            bottom: 50,
            child: Icon(Icons.arrow_forward_ios, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
