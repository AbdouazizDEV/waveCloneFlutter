// lib/services/auth_service.dart

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/auth/register_model.dart';
import '../models/user.dart';
import 'http/dio_client.dart';
import 'http/api_endpoints.dart';

class AuthService {
  final DioClient _client;
  final _storage = const FlutterSecureStorage();
  late Box<User> _userBox;

  AuthService(this._client) {
    initHive();
  }

  Future<void> initHive() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }
    _userBox = await Hive.openBox<User>('userBox');
  }

   Future<Map<String, dynamic>> login(String telephone, String code) async {
    try {
      final response = await _client.post(ApiEndpoints.login, {
        'telephone': telephone,
        'code': code,
      });
      
      final user = User.fromJson(response.data['user']);
      await _storage.write(key: 'token', value: response.data['access_token']);
      await _userBox.put('currentUser', user);
      
      return response.data;
    } catch (e) {
      throw Exception('Échec de connexion: ${e.toString()}');
    }
  }

  User? getCurrentUser() {
    try {
      return _userBox.get('currentUser');
    } catch (e) {
      print('Erreur lors de la récupération de l\'utilisateur: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> register(RegisterModel registerData) async {
    try {
      final response = await _client.post('/register', registerData.toJson());
      
      if (response.data['user'] != null) {
        final user = User.fromJson(response.data['user'] as Map<String, dynamic>);
        await _userBox.put('currentUser', user);
      }
      
      return {
        'success': true,
        'message': response.data['message'] as String? ?? 'Inscription réussie',
        'user': response.data['user'],
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  Future<void> logout() async {
    try {
      await _client.post(ApiEndpoints.logout, {});
      await _storage.delete(key: 'token');
      await _userBox.clear();
    } catch (e) {
      throw Exception('Échec de déconnexion: ${e.toString()}');
    }
  }

  Future<User> getProfile() async {
    try {
      final response = await _client.get(ApiEndpoints.userProfile);
      final user = User.fromJson(response.data);
      await _userBox.put('currentUser', user);
      return user;
    } catch (e) {
      // Essayer de récupérer l'utilisateur du cache si la requête échoue
      final cachedUser = _userBox.get('currentUser');
      if (cachedUser != null) {
        return cachedUser;
      }
      throw Exception('Échec de récupération du profil: ${e.toString()}');
    }
  }

  
}