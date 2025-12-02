import 'package:flutter/foundation.dart';
import 'package:konnecti/services/api_client.dart';
import 'package:konnecti/services/purchase/datavoicesmsService.dart';

class Datavoicesmsserviceprovider extends ChangeNotifier {
  final Datavoicesmsservice _services;
  bool _isLoading = false;
  Datavoicesmsserviceprovider(String baseUrl, String token)
    : _services = Datavoicesmsservice(
        apiClient: ApiClient(baseUrl: baseUrl, token: token),
      );

  bool get isLoading => _isLoading;
  Future<void> fetchDatavoicesms() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _services.getDatavoicesms();
      return;
    } catch (e) {
      if (kDebugMode) {
        print('error $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
