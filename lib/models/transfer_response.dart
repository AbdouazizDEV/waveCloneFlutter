// lib/models/transfer/transfer_response.dart
class TransferResponse {
  final bool status;
  final String message;
  final TransactionDetails? transaction;

  TransferResponse({
    required this.status,
    required this.message,
    this.transaction,
  });

  factory TransferResponse.fromJson(Map<String, dynamic> json) {
    return TransferResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      transaction: json['transaction'] != null 
          ? TransactionDetails.fromJson(json['transaction'])
          : null,
    );
  }
}

class TransactionDetails {
  final int id;
  final double montant;
  final String date;
  final String reference;
  final Map<String, dynamic> destinataire;

  TransactionDetails({
    required this.id,
    required this.montant,
    required this.date,
    required this.reference,
    required this.destinataire,
  });

  factory TransactionDetails.fromJson(Map<String, dynamic> json) {
    return TransactionDetails(
      id: json['id'] as int,
      montant: double.parse(json['montant'].toString()),
      date: json['date'] as String,
      reference: json['reference'] as String,
      destinataire: json['destinataire'] as Map<String, dynamic>,
    );
  }
}
