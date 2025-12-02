import 'package:flutter/material.dart';

class OfferProvider with ChangeNotifier {
  String data = '';
  String days = '';
  String price = '';
  String country = '';

  void setOffer({
    required String newData,
    required String newDays,
    required String newPrice,
    required String newCountry,
  }) {
    data = newData;
    days = newDays;
    price = newPrice;
    country = newCountry;
    notifyListeners();
  }
}
