import 'package:flutter/material.dart';

import 'package:konnecti/l10n/app_localizations.dart';

class SearchBaree extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onFilterTap; // ✅ nouveau paramètre

  const SearchBaree({
    super.key,
    required this.onChanged,
    required this.onFilterTap, // ✅ obligatoire
  });

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: tr.searchHint,
          hintStyle: const TextStyle(color: Colors.black),
          prefixIcon: const Icon(Icons.search, color: Colors.blue),
          suffixIcon: IconButton(
            icon: const Icon(Icons.tune, color: Colors.blue),
            onPressed: onFilterTap, // ✅ clique → ouvre menu de tri
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
