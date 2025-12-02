import 'package:flutter/material.dart';
import 'package:konnecti/modules/Esim/OrderDetail.dart';
import 'package:konnecti/modules/Esim/esim.dart';
import 'package:konnecti/modules/Esim/usage.dart';
import 'package:konnecti/services/EsimService/EsimService.dart';

class EsimProvider with ChangeNotifier {
  final EsimService esimService;

  bool isLoading = false;
  String? errorMessage;

  List<Esim> myEsims = [];
  Esim? selectedEsim;
  List<OrderDetail> orderDetails = [];
  Usage? currentUsage;

  EsimProvider({required this.esimService});

  /// 🔹 Récupérer toutes les eSIMs
  Future<void> loadMyEsims() async {
    _startLoading();
    try {
      myEsims = await esimService.fetchMyEsims();
    } catch (e) {
      errorMessage = e.toString();
    }
    _stopLoading();
  }

  /// 🔹 Charger le détail d'une eSIM
  Future<void> loadEsimById(String id) async {
    _startLoading();
    try {
      selectedEsim = await esimService.fetchEsimById(id);
    } catch (e) {
      errorMessage = e.toString();
    }
    _stopLoading();
  }

  /// 🔹 Charger les détails d'une commande
  Future<void> loadOrderById(String id) async {
    _startLoading();
    try {
      orderDetails = await esimService.fetchOrderById(id);
    } catch (e) {
      errorMessage = e.toString();
    }
    _stopLoading();
  }

  /// 🔹 Charger l’usage d’une eSIM
  Future<void> loadUsage(String iccid) async {
    _startLoading();
    try {
      currentUsage = await esimService.fetchEsimUsage(iccid);
    } catch (e) {
      errorMessage = e.toString();
    }
    _stopLoading();
  }

  void _startLoading() {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
  }

  void _stopLoading() {
    isLoading = false;
    notifyListeners();
  }
}
