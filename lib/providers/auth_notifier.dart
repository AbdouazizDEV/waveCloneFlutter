// lib/providers/auth_notifier.dart

import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import '../models/auth/register_model.dart';
import '../models/user.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthService _authService;
  bool isAuthenticated = false;
  bool isLoading = false;
  String? error;
  User? user;

  AuthNotifier(this._authService) {
    // Charger l'utilisateur depuis le cache au démarrage
    _initUser();
  }

  void _initUser() {
    try {
      final cachedUser = _authService.getCurrentUser();
      if (cachedUser != null) {
        user = cachedUser;
        isAuthenticated = true;
        notifyListeners();
      }
    } catch (e) {
      print('Erreur lors de l\'initialisation de l\'utilisateur: $e');
    }
  }

  Future<bool> login(String telephone, String code) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await _authService.login(telephone, code);
      user = User.fromJson(response['user']);
      isAuthenticated = true;
      error = null;
      notifyListeners();
      return true;
    } catch (e) {
      error = e.toString();
      isAuthenticated = false;
      notifyListeners();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register(RegisterModel registerData) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await _authService.register(registerData);
      
      if (response['success'] == true && response['user'] != null) {
        user = User.fromJson(response['user'] as Map<String, dynamic>);
        isAuthenticated = true;
        error = null;
        notifyListeners();
        return true;
      } else {
        error = response['message'] as String? ?? 'Erreur lors de l\'inscription';
        notifyListeners();
        return false;
      }
    } catch (e) {
      error = e.toString();
      isAuthenticated = false;
      notifyListeners();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      isAuthenticated = false;
      user = null;
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> refreshProfile() async {
    try {
      isLoading = true;
      notifyListeners();
      
      user = await _authService.getProfile();
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}