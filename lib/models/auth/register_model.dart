// lib/models/auth/register_model.dart

class RegisterModel {
  final String nom;
  final String prenom;
  final String telephone;
  final String email;
  final int roleId;

  RegisterModel({
    required this.nom,
    required this.prenom,
    required this.telephone,
    required this.email,
    required this.roleId,
  });

  Map<String, dynamic> toJson() => {
    'nom': nom,
    'prenom': prenom,
    'telephone': telephone,
    'email': email,
    'roleId': roleId,  // Changé de roleId à role_id pour correspondre à l'API
  };
}