// lib/models/transaction.dart

class TransactionType {
  final int id;
  final String libelle;

  TransactionType({
    required this.id,
    required this.libelle,
  });

  factory TransactionType.fromJson(Map<String, dynamic> json) {
    return TransactionType(
      id: json['id'],
      libelle: json['libelle'],
    );
  }
}

class TransactionParty {
  final int id;
  final String nom;
  final String prenom;
  final String telephone;

  TransactionParty({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.telephone,
  });

  factory TransactionParty.fromJson(Map<String, dynamic> json) {
    return TransactionParty(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      telephone: json['telephone'],
    );
  }

  String get fullName => '$prenom $nom';
}

class Transaction {
  final int id;
  final TransactionType type;
  final double montant;
  final DateTime date;
  final String status;
  final bool isExpediteur;
  final TransactionParty autrePartie;
  final DateTime? cancelledAt;
  final String? cancelReason;

  Transaction({
    required this.id,
    required this.type,
    required this.montant,
    required this.date,
    required this.status,
    required this.isExpediteur,
    required this.autrePartie,
    this.cancelledAt,
    this.cancelReason,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      type: TransactionType.fromJson(json['type']),
      montant: double.parse(json['montant'].toString()),
      date: DateTime.parse(json['date']),
      status: json['status'],
      isExpediteur: json['is_expediteur'],
      autrePartie: TransactionParty.fromJson(json['autre_partie']),
      cancelledAt: json['cancelled_at'] != null 
          ? DateTime.parse(json['cancelled_at'])
          : null,
      cancelReason: json['cancel_reason'],
    );
  }
}

class TransactionStats {
  final String totalEnvoye;
  final String totalRecu;
  final int nombreEnvois;
  final int nombreReceptions;

  TransactionStats({
    required this.totalEnvoye,
    required this.totalRecu,
    required this.nombreEnvois,
    required this.nombreReceptions,
  });

  factory TransactionStats.fromJson(Map<String, dynamic> json) {
    return TransactionStats(
      totalEnvoye: json['total_envoye'],
      totalRecu: json['total_recu'],
      nombreEnvois: json['nombre_envois'],
      nombreReceptions: json['nombre_receptions'],
    );
  }
}