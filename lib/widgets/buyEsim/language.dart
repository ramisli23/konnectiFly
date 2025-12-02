import 'package:flutter/material.dart';
import 'package:konnecti/providers/languageprovider.dart';
import 'package:provider/provider.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String? selectedLanguage;

  final Map<String, String> languageCodes = {
    'English': 'en',
    'Français': 'fr',
    'عربية': 'ar',
    'Español': 'es',
  };

  @override
  void initState() {
    super.initState();
    _loadSavedLanguage();
  }

  void _loadSavedLanguage() {
    final provider = Provider.of<LanguageProvider>(context, listen: false);
    final currentCode = provider.locale.languageCode;
    setState(() {
      selectedLanguage =
          languageCodes.entries
              .firstWhere(
                (entry) => entry.value == currentCode,
                orElse: () => const MapEntry('English', 'en'),
              )
              .key;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DraggableScrollableSheet(
          initialChildSize: 0.75,
          maxChildSize: 0.75,
          minChildSize: 0.2,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: ListView(
                controller: scrollController,
                children: [
                  const Text(
                    "Choose Language",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  ...languageCodes.entries.map((entry) {
                    final isSelected = selectedLanguage == entry.key;
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          selectedLanguage = entry.key;
                        });

                        final locale = Locale(entry.value);
                        Provider.of<LanguageProvider>(
                          context,
                          listen: false,
                        ).setLocale(locale);

                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? Colors.blue.withOpacity(0.1)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    isSelected ? Colors.blue : Colors.black87,
                                fontWeight:
                                    isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          },
        ),
        Positioned(
          top: 10,
          right: 20,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Icon(Icons.close, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
