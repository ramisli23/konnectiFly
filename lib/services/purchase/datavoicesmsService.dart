import 'package:konnecti/modules/puechase/datavoicesms.dart';
import 'package:konnecti/services/api_client.dart';

class Datavoicesmsservice {
  final ApiClient apiClient;
  Datavoicesmsservice({required this.apiClient});
  Future<List<Datavoicesms>> getDatavoicesms() async {
    final data = await apiClient.get("endpoint");
    if (data['data'] is List) {
      return (data['data'] as List<dynamic>)
          .map((e) => Datavoicesms.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("error is ");
    }
  }
}
