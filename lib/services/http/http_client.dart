// lib/services/http/http_client.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'http_client_interface.dart';

class HttpClient implements HttpClientInterface {
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  @override
  Future<Map<String, dynamic>> get(String url) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: _headers,
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> post(String url, {data}) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: _headers,
        body: json.encode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
    
  }

  @override
  Future<Map<String, dynamic>> put(String url, {data}) async {
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: _headers,
        body: json.encode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }

  }

  @override
  Future<Map<String, dynamic>> delete(String url) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: _headers,
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  void setAuthToken(String token) {
    _headers['Authorization'] = 'Bearer $token';
  }

  @override
  void removeAuthToken() {
    _headers.remove('Authorization');
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    }
    throw _handleStatusCode(response.statusCode);
  }

  Exception _handleStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return Exception('Requête invalide');
      case 401:
        return Exception('Non autorisé');
      case 403:
        return Exception('Accès refusé');
      case 404:
        return Exception('Resource non trouvée');
      case 500:
        return Exception('Erreur serveur');
      default:
        return Exception('Erreur $statusCode');
    }
  }

  Exception _handleError(error) {
    return Exception('Erreur de connexion: ${error.toString()}');
  }
}