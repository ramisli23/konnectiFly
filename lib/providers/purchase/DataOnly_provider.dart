import 'package:flutter/foundation.dart';
import 'package:konnecti/modules/puechase/data_only.dart';
import 'package:konnecti/services/purchase/data_only_service.dart';
import 'package:konnecti/services/api_client.dart';

class DataonlyProvider extends ChangeNotifier {
  final DataOnlyService _service;

  List<DataOnly> _esims = [];
  bool _isLoading = false;
  String? _errorMessage;

  DataonlyProvider({required String baseUrl, required String token})
    : _service = DataOnlyService(
        apiClient: ApiClient(baseUrl: baseUrl, token: token),
      );

  List<DataOnly> get esims => _esims;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// 📌 يجيب كل الباقات (من المزود مباشرة)
  Future<void> fetchEsims() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final result = await _service.getEsims();
      _esims = result;
    } catch (e) {
      _errorMessage = e.toString();
      if (kDebugMode) {
        print('❌ DataonlyProvider fetchEsims error: $e');
      }
    } finally {
      _setLoading(false);
    }
  }

  /// 📌 يجيب فقط طلبات المستخدم (status == completed && DATA-ONLY)
  Future<void> fetchUserEsims(String userId) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final result = await _service.getUserDataOnlyEsims(userId);
      _esims = result;
    } catch (e) {
      _errorMessage = e.toString();
      if (kDebugMode) {
        print(userId);
        print('❌ DataonlyProvider fetchUserEsims error: $e');
      }
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void updateToken(String token) {
    // إذا حبيت تبدل التوكن أثناء runtime
  }
}
