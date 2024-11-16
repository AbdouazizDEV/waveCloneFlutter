// lib/services/http/dio_client.dart
import 'package:dio/dio.dart';
import 'http_client_interface.dart';
import 'package:wave_mobile/utils/api_urls.dart';
import 'dart:io';


class DioClient implements HttpClientInterface {
  final Dio _dio;

   DioClient() : _dio = Dio() {
    _dio.options.baseUrl = ApiUrls.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
    
     // Configuration pour accepter tous les certificats (à utiliser uniquement en développement)
   /*  (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = 
      (HttpClient client) {
        client.badCertificateCallback = 
          (X509Certificate cert, String host, int port) => true;
        return client;
      }; */
    // Ajouter un intercepteur pour le logging
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  @override
  Future<Map<String, dynamic>> get(String url) async {
    try {
      final response = await _dio.get(url);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> post(String url, {dynamic data}) async {
    try {
      //debugPrint('Envoi requête à: $url avec données: $data');
      final response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      //debugPrint('Réponse reçue: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      ////debugPrint('Erreur Dio: $e');
      //debugPrint('Réponse erreur: ${e.response?.data}');
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connexion au serveur impossible. Vérifiez votre connexion internet.');
      }
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Erreur de connexion');
      }
      throw Exception('Erreur réseau: ${e.message}');
    } catch (e) {
      //debugPrint('Erreur générale: $e');
      throw Exception('Erreur inattendue: $e');
    }
  }


  @override
void setAuthToken(String token) {
  _dio.options.headers['Authorization'] = 'Bearer $token';
}

  @override
  Future<Map<String, dynamic>> put(String url, {data}) async {
    try {
      final response = await _dio.put(url, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> delete(String url) async {
    try {
      final response = await _dio.delete(url);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }



  @override
  void removeAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.data is Map<String, dynamic>) {
      return response.data;
    }
    throw Exception('Réponse invalide du serveur');
  }

  Exception _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connexion timeout');
      case DioExceptionType.sendTimeout:
        return Exception('Erreur d\'envoi des données');
      case DioExceptionType.receiveTimeout:
        return Exception('Erreur de réception des données');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
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
            return Exception('Erreur ${statusCode}');
        }
      default:
        return Exception('Erreur de connexion');
    }
  }
}
