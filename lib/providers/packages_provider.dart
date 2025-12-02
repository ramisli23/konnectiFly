import 'package:flutter/widgets.dart';
import 'package:flutter/scheduler.dart';
import 'package:konnecti/modules/continent.dart';
import 'package:konnecti/modules/country.dart';
import 'package:konnecti/modules/package_detail.dart';
import 'package:konnecti/modules/package_pricing.dart';
import 'package:konnecti/services/packages_service.dart';

class PackagesProvider extends ChangeNotifier {
  final PackagesService _service;

  PackagesProvider(this._service);

  bool _isLoading = false;
  String? _errorMessage;

  List<Country> _countries = [];
  List<Continent> _continents = [];
  PackageDetail? _selectedPackage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Country> get countries => _countries;
  List<Continent> get continents => _continents;

  final Map<String, List<PackagePricing>> _packagesCache = {};

  void _safeNotify() {
    if (!hasListeners) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (hasListeners) notifyListeners();
    });
  }

  // --- WRAPPER fetch ---
  Future<void> _fetch(Future<void> Function() action) async {
    _isLoading = true;
    _errorMessage = null;
    _safeNotify();

    try {
      await action();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    _safeNotify();
  }

  // --- Countries ---
  Future<void> fetchCountries({bool force = false}) async {
    if (!force && _countries.isNotEmpty) return;

    await _fetch(() async {
      _countries = await _service.getCountries();
    });
  }

  // --- Continents ---
  Future<void> fetchContinents({bool force = false}) async {
    if (!force && _continents.isNotEmpty) return;

    await _fetch(() async {
      _continents = await _service.getContinents();
    });
  }

  // --- Search filter ---
  List<Country> filterCountries(String query) {
    if (query.isEmpty) return _countries;

    return _countries
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // --- Packages Per Country ---
  Future<List<PackagePricing>> fetchPackagesByCountry({
    required String countryId,
    required String type,
    required String mode,
    bool forceRefresh = false,
  }) async {
    final key = "$countryId-$type-$mode";

    if (!forceRefresh && _packagesCache.containsKey(key)) {
      return _packagesCache[key]!;
    }

    final packages = await _service.getPackagesByCountry(countryId, type, mode);

    _packagesCache[key] = packages;
    return packages;
  }

  // --- Preload all country packages (Fix: new list, no mutation) ---
  Future<void> preloadPackagesForAllCountries(String type) async {
    print("🚀 Preload all countries packages...");

    final List<Country> updatedList = [];

    for (final c in _countries) {
      final packages = await _service.getPackagesByCountry(
        c.id,
        type,
        "limited",
      );

      updatedList.add(c.copyWith(packages: packages));
    }

    // 🔥 REMPLACE LA LISTE COMPLÈTE (aucune mutation pendant build)
    _countries = updatedList;

    _safeNotify();
  }

  // --- Details ---
  Future<void> fetchPackageDetail({
    required String countryId,
    required String type,
    required String packageId,
  }) async {
    await _fetch(() async {
      _selectedPackage = await _service.getPackageDetail(
        countryId,
        type,
        packageId,
      );
    });
  }

  Future<double?> getStartingPrice(String countryId, String packageType) async {
    try {
      final packages = await fetchPackagesByCountry(
        countryId: countryId,
        type: packageType,
        mode: "limited",
      );

      if (packages.isEmpty) return null;

      // Trier par prix
      packages.sort((a, b) => a.priceDZD.compareTo(b.priceDZD));

      return packages.first.priceDZD;
    } catch (_) {
      return null;
    }
  }

  Future<List<PackagePricing>> fetchPackagesByContinent({
    required String continentId,
    required String type,
    required String mode,
  }) async {
    try {
      return await _service.getPackagesByContinent(continentId, type, mode);
    } catch (e) {
      throw Exception("Error loading continent packages: $e");
    }
  }

  void clearCache() {
    _packagesCache.clear();
    _safeNotify();
  }
}
