// lib/services/auth_service.dart
import 'package:flutter/foundation.dart';
import '../utils/constants/api_urls.dart';
import 'http/http_client_interface.dart';
import '../models/auth/auth_model.dart';

class AuthService {
  final HttpClientInterface _client;

  AuthService(this._client);

  /* Future<AuthModel> login(String telephone, String code) async {
    try {
      debugPrint('Tentative de connexion avec: $telephone et $code');
      final response = await _client.post(
        ApiUrls.login,
        data: {
          'telephone': telephone,
          'code': code,
        },
      );
      debugPrint('Réponse du serveur: $response');

      if (response['status'] == true) {
        final authModel = AuthModel.fromJson(response);
        // Configurer le token pour les futures requêtes
        _client.setAuthToken(response['accessToken']);
        return authModel;
      } else {
        throw Exception(response['message'] ?? 'Erreur de connexion');
      }
    } catch (e) {
      debugPrint('Erreur lors de la connexion: $e');
      throw Exception('Erreur de connexion: $e');
    }
  } */
 Future<bool> validateLogin(String phone, String code) {
    // Simulation de validation
    return Future.value(true);
  }
  Future<void> logout() async {
    try {
      await _client.post(ApiUrls.logout);
    } catch (e) {
      throw Exception('Erreur lors de la déconnexion: $e');
    }
  }
}

