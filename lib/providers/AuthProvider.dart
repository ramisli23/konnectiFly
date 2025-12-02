/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  String? _accessToken;
  String? _userId;
  Map<String, dynamic>? _user; // Pour stocker les infos utilisateur

  String? get accessToken => _accessToken;
  String? get userId => _userId;
  Map<String, dynamic>? get user => _user;

  /// === Initialisation (charger données) ===
  Future<void> loadAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString("access_token");
    _userId = prefs.getString("user_id");
    notifyListeners();
  }

  /// === Sauvegarder token ===
  Future<void> setAccessToken(String token) async {
    _accessToken = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("access_token", token);
    notifyListeners();
  }

  /// === Sauvegarder userId ===
  Future<void> setUserId(String id) async {
    _userId = id;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_id", id);
    notifyListeners();
  }

  /// === Déconnexion ===
  Future<void> logout() async {
    _accessToken = null;
    _userId = null;
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("access_token");
    await prefs.remove("user_id");
    notifyListeners();
  }

  /// === Récupérer infos utilisateur (endpoint /me) ===
  Future<void> fetchMe() async {
    if (_accessToken == null) return;

    final response = await http.get(
      Uri.parse("https://backend-bumm.onrender.com/me"),
      headers: {"Authorization": "Bearer $_accessToken"},
    );

    if (response.statusCode == 200) {
      _user = jsonDecode(response.body);
      notifyListeners();
    } else {
      print("Erreur fetchMe: ${response.statusCode}");
    }
  }

  /// === Effacer seulement le token ===
  Future<void> clearAccessToken() async {
    _accessToken = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("access_token");
    notifyListeners();
  }
}
*/

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  String? _accessToken;
  String? _userId;
  Map<String, dynamic>? _user;

  String? get accessToken => _accessToken;
  String? get userId => _userId;
  Map<String, dynamic>? get user => _user;

  /// === Initialisation (charger données depuis SharedPreferences) ===
  Future<void> loadAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString("access_token");
    _userId = prefs.getString("user_id");
    notifyListeners();
  }

  /// === Sauvegarder token ===
  Future<void> setAccessToken(String token) async {
    _accessToken = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("access_token", token);
    notifyListeners();
  }

  /// === Sauvegarder userId ===
  Future<void> setUserId(String id) async {
    _userId = id;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_id", id);
    notifyListeners();
  }

  /// === Déconnexion ===
  Future<void> logout() async {
    _accessToken = null;
    _userId = null;
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("access_token");
    await prefs.remove("user_id");
    notifyListeners();
  }

  /// === Récupérer infos utilisateur (/me) ===
  Future<void> fetchMe() async {
    if (_accessToken == null) return;

    final response = await http.get(
      Uri.parse("https://backend-bumm.onrender.com/me"),
      headers: {"Authorization": "Bearer $_accessToken"},
    );
    // "Authorization": "Bearer $_accessToken"
    if (response.statusCode == 200) {
      _user = jsonDecode(response.body);
      notifyListeners();
    } else {
      print("❌ Erreur fetchMe: ${response.statusCode}");
    }
  }

  /// === Effacer seulement le token ===
  Future<void> clearAccessToken() async {
    _accessToken = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("access_token");
    notifyListeners();
  }
}
