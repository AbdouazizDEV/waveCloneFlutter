// lib/services/http/dio_client.dart

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';

class DioClient {
  late Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // URL de base pour l'API
  static const String baseUrl = 'http://192.168.224.58:8000/api';
  
  // Getter public pour l'URL de base
  String get currentBaseUrl => baseUrl;

  DioClient() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.json,
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Connection': 'keep-alive',
      },
    ));

    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: true,
      logPrint: (object) {
        print('🔍 DIO LOG: $object');
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        print('📡 Requesting: ${options.method} ${options.uri}');
        final token = await _storage.read(key: 'token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  Future<Response> get(String path) async {
    try {
      // Test de connexion basique avant l'appel Dio
      try {
        final uri = Uri.parse(baseUrl);
        final socket = await Socket.connect(
          uri.host, 
          uri.port,
          timeout: const Duration(seconds: 5),
        );
        socket.destroy();
      } catch (e) {
        throw DioException(
          requestOptions: RequestOptions(path: path),
          error: 'Impossible de se connecter au serveur: $e',
          type: DioExceptionType.connectionError,
        );
      }

      print('🌐 Tentative de connexion à: $baseUrl$path');
      final response = await _dio.get(path);
      print('✅ Réponse reçue: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      print('❌ Erreur Dio: ${e.message}');
      throw _handleError(e);
    } catch (e) {
      print('❌ Erreur générale: $e');
      throw Exception('Erreur inattendue: $e');
    }
  }

  // ... autres méthodes (post, put) ...
Future<Response> post(String path, dynamic data) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(String path, dynamic data) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
 
  Exception _handleError(DioException e) {
    print('🚨 Type d\'erreur: ${e.type}');
    print('🚨 Message d\'erreur: ${e.message}');
    print('🚨 URL tentée: ${e.requestOptions.uri}');

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception(
          'Le serveur met trop de temps à répondre.\n'
          'Vérifiez que:\n'
          '1. Le serveur Laravel est démarré (php artisan serve --host=0.0.0.0)\n'
          '2. Vous êtes connecté au même réseau WiFi que le serveur\n'
          '3. L\'adresse IP ${baseUrl.split('://')[1].split(':')[0]} est correcte'
        );

      case DioExceptionType.connectionError:
        return Exception(
          'Impossible de se connecter au serveur.\n'
          'Vérifiez que:\n'
          '1. Votre téléphone est connecté à Internet\n'
          '2. Le serveur est accessible sur ${baseUrl.split('://')[1]}\n'
          '3. Le pare-feu autorise les connexions\n'
          '4. L\'adresse IP est correcte'
        );

      default:
        return Exception(e.message ?? 'Une erreur est survenue');
    }
  }
}