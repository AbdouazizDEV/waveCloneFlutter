// lib/models/auth/login_model.dart
class LoginModel {
  final String telephone;
  final String code;

  LoginModel({required this.telephone, required this.code});

  Map<String, dynamic> toJson() => {
    'telephone': telephone,
    'code': code,
  };
}
