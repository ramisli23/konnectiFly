import 'package:konnecti/modules/puechase/data_only.dart';
import 'package:konnecti/services/api_client.dart';

class DataOnlyService {
  final ApiClient apiClient;

  DataOnlyService({required this.apiClient});

  /// Récupère la liste des eSIMs DATA-ONLY depuis l'API
  Future<List<DataOnly>> getEsims() async {
    try {
      final response = await apiClient.get("/reseller/package/purchase");

      if (response == null || response['data'] == null) {
        throw Exception("Aucune donnée reçue depuis l'API");
      }

      final data = response['data'];

      if (data is List) {
        return data
            .map((e) => DataOnly.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (data is Map<String, dynamic>) {
        // Si l'API renvoie un objet unique au lieu d'une liste
        return [DataOnly.fromJson(data)];
      } else {
        throw Exception("Format de données inattendu depuis l'API");
      }
    } catch (e) {
      // Log ou propagation de l'erreur
      throw Exception("Erreur lors de la récupération des eSIMs: $e");
    }
  }

  Future<List<DataOnly>> getUserDataOnlyEsims(String userId) async {
    try {
      final response = await apiClient.get("/orders/user/$userId");

      if (response == null || response['orders'] == null) {
        throw Exception("Aucune donnée reçue depuis le backend");
      }

      final List orders = response['orders'];

      return orders
          .where((order) {
            final esim = order['esimData'];

            // ⛔️ ignorer les vides
            if (esim == null || esim == "" || esim is! Map<String, dynamic>) {
              return false;
            }

            // ✅ status au niveau esimData
            if (esim['status'] == 'completed') return true;

            // ✅ ou status à l'intérieur de package
            if (esim['package'] is Map<String, dynamic> &&
                esim['package']['status'] == 'completed') {
              return true;
            }

            return false;
          })
          .map<DataOnly>((order) {
            final esim = order['esimData'] as Map<String, dynamic>;

            // 🔄 Normalisation vers le format attendu par DataOnly.fromJson
            Map<String, dynamic> normalized;

            if (esim.containsKey('sim') ||
                esim.containsKey('sim_applied') ||
                esim.containsKey('package')) {
              // ✅ déjà dans un format proche de DataOnly
              normalized = esim;
            } else if (esim.containsKey('packageId')) {
              // ✅ format simplifié comme ton exemple (id, status, packageId, price)
              normalized = {
                'sim_applied': false,
                'sim': {}, // Sim.empty() sera utilisé via ton fallback
                'package': {
                  'id': esim['packageId'] ?? '',
                  'package_type_id': '',
                  'sim_id': '',
                  // ici on n’a pas le vrai nom, on met au moins quelque chose
                  'package': esim['packageId'] ?? '',
                  'activated': esim['status'] == 'completed',
                  'status': esim['status'] ?? '',
                  'initial_data_quantity': 0,
                  'initial_data_unit': '',
                  'rem_data_quantity': 0,
                  'rem_data_unit': '',
                  'unlimited': false,
                },
              };
            } else {
              // ✅ fallback: on considère que esim = package direct
              normalized = {'sim_applied': false, 'sim': {}, 'package': esim};
            }

            return DataOnly.fromJson(normalized);
          })
          .toList();
    } catch (e) {
      throw Exception("Erreur lors de la récupération des eSIMs Data-Only: $e");
    }
  }

  /*
  Future<List<DataOnly>> getUserDataOnlyEsims(String userId) async {
    try {
      final response = await apiClient.get("/orders/user/$userId");

      if (response == null || response['orders'] == null) {
        throw Exception("Aucune donnée reçue depuis le backend");
      }

      final data = response['orders'];

      if (data is List) {
        return data
            .where(
              (e) => e['status'] == 'completed',
            ) // ✅ filtre seulement completed
            .map(
              (e) => DataOnly.fromJson(
                e['esimData'] as Map<String, dynamic>, // ✅ pas juste package
              ),
            )
            .toList();
      } else {
        throw Exception("Format de données inattendu depuis le backend");
      }
    } catch (e) {
      throw Exception("Erreur lors de la récupération des eSIMs Data-Only: $e");
    }
  }*/
}
