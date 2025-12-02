import 'package:konnecti/modules/continent.dart';
import 'package:konnecti/modules/country.dart';
import 'package:konnecti/modules/package_detail.dart';
import 'package:konnecti/modules/package_pricing.dart';
import 'package:konnecti/services/api_client.dart';

class PackagesService {
  final ApiClient apiClient;
  PackagesService(this.apiClient);
  Future<List<Country>> getCountries() async {
    final response = await apiClient.get('/countries');

    print("🌍 RAW countries response type = ${response.runtimeType}");

    // Ton API retourne une LISTE brute → pas un objet "data"
    if (response is! List) {
      throw Exception("Invalid /countries response: expected a List");
    }

    final cleaned =
        response
            .where((item) => item != null && item is Map<String, dynamic>)
            .map((item) => Country.fromJson(item as Map<String, dynamic>))
            .toList();

    print("✅ Countries converted = ${cleaned.length}");

    return cleaned;
  }

  Future<List<Continent>> getContinents() async {
    final data = await apiClient.get('/continents');

    print("Raw /continents response type = ${data.runtimeType}");
    print("Raw /continents = $data");

    // 🔥 Ton API renvoie une LISTE brute contenant aussi des null
    if (data is List) {
      final cleanedList =
          data
              .where((item) => item != null && item is Map<String, dynamic>)
              .map((item) => Continent.fromJson(item as Map<String, dynamic>))
              .toList();

      print("Continents converted = ${cleanedList.length}");
      return cleanedList;
    }

    // 🔄 Si un jour ton API renvoie { "data": [] }
    if (data is Map && data['data'] is List) {
      final cleanedList =
          (data['data'] as List)
              .where((item) => item != null && item is Map<String, dynamic>)
              .map((item) => Continent.fromJson(item as Map<String, dynamic>))
              .toList();

      print("Continents converted (object) = ${cleanedList.length}");
      return cleanedList;
    }

    throw Exception("Invalid /continents response format: $data");
  }

  Future<List<PackagePricing>> getPackagesByCountry(
    String countryId,
    String packageType,
    String mode,
  ) async {
    final data = await apiClient.get(
      '/packages/country/$countryId/$packageType/$mode',
    );
    if (data['data'] is List) {
      return (data['data'] as List)
          .map((p) => PackagePricing.fromJson(p as Map<String, dynamic>))
          .toList();
    }
    throw Exception("Invalid /packages/country response: $data");
  }

  Future<List<PackagePricing>> getPackagesByContinent(
    String continentId,
    String packageType,
    String mode,
  ) async {
    final data = await apiClient.get(
      '/packages/continent/$continentId/$packageType/$mode',
    );

    if (data['data'] is List) {
      return (data['data'] as List)
          .map((p) => PackagePricing.fromJson(p as Map<String, dynamic>))
          .toList();
    }

    throw Exception("Invalid /packages/continent response");
  }

  Future<List<PackagePricing>> getGlobalPackages(
    String packageType,
    String mode,
  ) async {
    final data = await apiClient.get('/packages/global/$packageType/$mode');
    if (data['data'] is List) {
      return (data['data'] as List)
          .map((p) => PackagePricing.fromJson(p as Map<String, dynamic>))
          .toList();
    }
    throw Exception("Invalid /packages/global response");
  }

  Future<PackageDetail> getPackageDetail(
    String countryId,
    String packageType,
    String packageId,
  ) async {
    final data = await apiClient.get(
      '/packages/package/$countryId/$packageType/$packageId',
    );
    if (data['data'] is Map<String, dynamic>) {
      return PackageDetail.fromJson(data['data'] as Map<String, dynamic>);
    }
    throw Exception("Invalid package detail format");
  }

  /*Future<List<Continent>> getContinents() async {
    final data = await apiClient.get('/continents');
    if (data['data'] is List) {
      return (data['data'] as List)
          .map((c) => Continent.fromJson(c as Map<String, dynamic>))
          .toList();
    }
    throw Exception("Invalid /continents response");
  }*/
}
