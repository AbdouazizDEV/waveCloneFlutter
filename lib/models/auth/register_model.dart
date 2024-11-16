// lib/models/auth/register_model.dart
class RegisterModel {
  final String nom;
  final String prenom;
  final String telephone;
  final String email;
  final int roleId;
  final String code;

  RegisterModel({
    required this.nom,
    required this.prenom,
    required this.telephone,
    required this.email,
    required this.roleId,
    required this.code,
  });

  Map<String, dynamic> toJson() => {
    'nom': nom,
    'prenom': prenom,
    'telephone': telephone,
    'email': email,
    'roleId': roleId,
    'code': code,
  };
}