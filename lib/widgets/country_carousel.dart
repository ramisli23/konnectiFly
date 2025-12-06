import 'package:flutter/material.dart';
import 'package:konnecti/components/components.dart';
import 'package:konnecti/l10n/app_localizations.dart';

class CountryCarousel extends StatelessWidget {
  CountryCarousel({super.key});

  final List<Map<String, String>> countries = const [
    {
      'id': '151', // Italy
      'name': 'Italy',
      'flag': '🇮🇹',
      'image': 'assets/countries/italy.jpg',
      'packageType': 'DATA-ONLY',
    },
    {
      'id': '68', // United Arab Emirates (Dubai)
      'name': 'Dubai',
      'flag': '🇦🇪',
      'image': 'assets/countries/dubai.jpg',
      'packageType': 'DATA-ONLY',
    },
    {
      'id': '211', // Brazil
      'name': 'Brazil',
      'flag': '🇧🇷',
      'image': 'assets/countries/brazil.jpg',
      'packageType': 'DATA-ONLY',
    },
    {
      'id': '87', // Malaysia
      'name': 'Malaysia',
      'flag': '🇲🇾',
      'image': 'assets/countries/malaysia.jpg',
      'packageType': 'DATA-ONLY',
    },
    {
      'id': '150', // France
      'name': 'France',
      'flag': '🇫🇷',
      'image': 'assets/countries/france.jpg',
      'packageType': 'DATA-ONLY',
    },
    {
      'id': '149', // Germany
      'name': 'Germany',
      'flag': '🇩🇪',
      'image': 'assets/countries/germany.jpg',
      'packageType': 'DATA-ONLY',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr.myEsim,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];

                return InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => Buyesimdetails(
                              countryId: country['id']!,
                              countryName: country['name']!,
                              imagePath: country['image']!,
                              packageType: country['packageType']!,
                            ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.transparent,
                          child: Text(
                            country['flag']!,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          country['name']!,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
