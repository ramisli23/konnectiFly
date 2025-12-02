import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => "ApiException($statusCode): $message";
}

class ApiClient {
  final String baseUrl;
  final String? token;
  final Duration timeout;

  ApiClient({
    required this.baseUrl,
    this.token,
    this.timeout = const Duration(seconds: 30),
  });

  /// 🔑 Construire les headers dynamiquement
  Map<String, String> _headers({bool withJson = true}) {
    final headers = <String, String>{'Accept': 'application/json'};

    if (withJson) {
      headers['Content-Type'] = 'application/json';
    }

    if (token != null && token!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  /// 🌍 GET request avec params optionnels
  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? queryParams,
  }) async {
    return _sendRequest(
      () => http.get(
        Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams),
        headers: _headers(withJson: false),
      ),
    );
  }

  /// 📌 POST request
  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    return _sendRequest(
      () => http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers(),
        body: jsonEncode(body),
      ),
    );
  }

  /// ✏️ PUT request
  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    return _sendRequest(
      () => http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers(),
        body: jsonEncode(body),
      ),
    );
  }

  /// 🔄 PATCH request
  Future<dynamic> patch(String endpoint, Map<String, dynamic> body) async {
    return _sendRequest(
      () => http.patch(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers(),
        body: jsonEncode(body),
      ),
    );
  }

  /// 🗑 DELETE request
  Future<dynamic> delete(String endpoint) async {
    return _sendRequest(
      () => http.delete(Uri.parse('$baseUrl$endpoint'), headers: _headers()),
    );
  }

  /// 🚦 Centralisation de la logique des requêtes
  Future<dynamic> _sendRequest(
    Future<http.Response> Function() requestFn,
  ) async {
    try {
      final response = await requestFn().timeout(timeout);
      return _handleResponse(response);
    } on TimeoutException {
      throw ApiException("La requête a expiré après ${timeout.inSeconds}s");
    } catch (e) {
      throw ApiException("Erreur réseau: $e");
    }
  }

  /// 🔍 Gestion des réponses
  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : null;

    if (statusCode >= 200 && statusCode < 300) {
      return body;
    }

    // Gestion des erreurs spécifiques
    String message;

    if (statusCode == 400) {
      message =
          body is Map && body.containsKey("message")
              ? body["message"]
              : "Requête invalide (400)";
    } else if (statusCode == 401) {
      message = "Token invalide ou expiré. Veuillez vous reconnecter.";
    } else if (statusCode == 403) {
      message = "Accès refusé (403)";
    } else if (statusCode == 404) {
      message = "Ressource non trouvée (404)";
    } else if (statusCode >= 500) {
      message = "Erreur serveur ($statusCode)";
    } else {
      message = "Erreur API ($statusCode)";
    }

    throw ApiException(message, statusCode: statusCode);
  }
}
/*import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final String? token;
  final Duration timeout;

  ApiClient({
    required this.baseUrl,
    this.token,
    this.timeout = const Duration(seconds: 30),
  });

  /// Build headers dynamically
  Map<String, String> _headers({bool withJson = true}) {
    final headers = <String, String>{'Accept': 'application/json'};

    if (withJson) {
      headers['Content-Type'] = 'application/json';
    }

    if (token != null && token!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  /// GET request with optional query params
  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? queryParams,
  }) async {
    try {
      final uri = Uri.parse(
        '$baseUrl$endpoint',
      ).replace(queryParameters: queryParams);
      final response = await http
          .get(uri, headers: _headers(withJson: false))
          .timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      throw Exception("GET request error: $e");
    }
  }

  /// POST request
  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http
          .post(uri, headers: _headers(), body: jsonEncode(body))
          .timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      throw Exception("POST request error: $e");
    }
  }

  /// PUT request
  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http
          .put(uri, headers: _headers(), body: jsonEncode(body))
          .timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      throw Exception("PUT request error: $e");
    }
  }

  /// PATCH request
  Future<dynamic> patch(String endpoint, Map<String, dynamic> body) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http
          .patch(uri, headers: _headers(), body: jsonEncode(body))
          .timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      throw Exception("PATCH request error: $e");
    }
  }

  /// DELETE request
  Future<dynamic> delete(String endpoint) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http
          .delete(uri, headers: _headers())
          .timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      throw Exception("DELETE request error: $e");
    }
  }

  /// Handle API response
  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : null;

    if (statusCode >= 200 && statusCode < 300) {
      return body;
    } else if (statusCode == 401) {
      throw Exception("Unauthorized (401): ${body ?? response.body}");
    } else if (statusCode == 404) {
      throw Exception("Not Found (404): ${body ?? response.body}");
    } else if (statusCode >= 500) {
      throw Exception("Server Error ($statusCode): ${body ?? response.body}");
    } else {
      throw Exception("API Error ($statusCode): ${body ?? response.body}");
    }
  }
}
*/