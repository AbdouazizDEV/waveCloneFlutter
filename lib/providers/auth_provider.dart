// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/auth/auth_model.dart' as models;
class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  models.AuthModel? _currentUser;
  bool _isLoading = false;
  String? _error;

  AuthProvider(this._authService);

  bool get isLoading => _isLoading;
  models.AuthModel? get currentUser => _currentUser;
  String? get error => _error;
 Future<bool> login(String phone, String code) async {
  try {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final response = await _authService.login(phone, code);
    // Check the response to see if the login was successful
    // For example:
    if (response != null && response['access_token'] != null) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    _error = e.toString();
    return false;
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}

  Future<void> logout() async {
    try {
      await _authService.logout();
      _currentUser = null;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}