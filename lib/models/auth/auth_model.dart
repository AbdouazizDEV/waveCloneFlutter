// lib/models/auth_model.dart

class AuthModel {
  final int id;
  final String nom;
  final String prenom;
  final String telephone;
  final String email;
  final double solde;
  final String promo;
  final String carte;
  final bool etatcarte;
  final int roleId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String accessToken;

  AuthModel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.telephone,
    required this.email,
    required this.solde,
    required this.promo,
    required this.carte,
    required this.etatcarte,
    required this.roleId,
    this.createdAt,
    this.updatedAt,
    required this.accessToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    return AuthModel(
      id: user['id'],
      nom: user['nom'],
      prenom: user['prenom'],
      telephone: user['telephone'],
      email: user['email'],
      solde: double.parse(user['solde'].toString()),
      promo: user['promo'] ?? '0.00',
      carte: user['carte'] ?? '',
      etatcarte: user['etatcarte'] ?? false,
      roleId: user['role_id'],
      createdAt: user['created_at'] != null ? DateTime.parse(user['created_at']) : null,
      updatedAt: user['updated_at'] != null ? DateTime.parse(user['updated_at']) : null,
      accessToken: json['access_token'],
    );
  }
}
