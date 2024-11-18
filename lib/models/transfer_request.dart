// lib/models/transfer/transfer_request.dart

class TransferRequest {
  final String telephone;
  final double montant;

  TransferRequest({
    required this.telephone,
    required this.montant,
  });

  Map<String, dynamic> toJson() {
    return {
      'telephone': telephone,
      'montant': montant,
    };
  }
}

class MultipleTransferRequest {
  final List<Map<String, dynamic>> transfers;

  MultipleTransferRequest({required this.transfers});

  Map<String, dynamic> toJson() {
    return {
      'transfers': transfers,
    };
  }
}

class ScheduledTransferRequest {
  final String telephone;
  final double montant;
  final String frequency; // 'daily', 'weekly', 'monthly'
  final DateTime startDate;
  final DateTime? endDate;

  ScheduledTransferRequest({
    required this.telephone,
    required this.montant,
    required this.frequency,
    required this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'telephone': telephone,
      'montant': montant,
      'frequency': frequency,
      'start_date': startDate.toIso8601String(),
      if (endDate != null) 'end_date': endDate!.toIso8601String(),
    };
  }
}