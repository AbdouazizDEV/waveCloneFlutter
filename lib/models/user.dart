// lib/models/user.dart

import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String nom;

  @HiveField(2)
  final String prenom;

  @HiveField(3)
  final String telephone;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final double solde;

  @HiveField(6)
  final String code;

  @HiveField(7)
  final double promo;

  @HiveField(8)
  final String carte;

  @HiveField(9)
  final bool etatcarte;

  @HiveField(10)
  final int roleId;

  @HiveField(11)
  final DateTime createdAt;

  @HiveField(12)
  final DateTime updatedAt;

  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.telephone,
    required this.email,
    required this.solde,
    required this.code,
    required this.promo,
    required this.carte,
    required this.etatcarte,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      telephone: json['telephone'] as String,
      email: json['email'] as String,
      solde: double.parse(json['solde'].toString()),
      code: json['code'] as String,
      promo: double.parse(json['promo'].toString()),
      carte: json['carte'] as String,
      etatcarte: json['etatcarte'] as bool,
      roleId: json['role_id'] as int,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'telephone': telephone,
      'email': email,
      'solde': solde,
      'code': code,
      'promo': promo,
      'carte': carte,
      'etatcarte': etatcarte,
      'role_id': roleId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String get fullName => '$prenom $nom';
}