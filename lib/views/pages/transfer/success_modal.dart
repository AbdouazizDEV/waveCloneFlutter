// lib/views/pages/transfer/success_modal.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class SuccessModal extends StatelessWidget {
  final double amount;
  final String recipientPhone;
  final String? recipientName;
  final String recipientEmail;
  final String? message;
  final String? transactionId;
  final String? reference;
  final DateTime? date;

  const SuccessModal({
    Key? key,
    required this.amount,
    required this.recipientPhone,
    this.recipientName,
    required this.recipientEmail,
    this.message,
    this.transactionId,
    this.reference,
    this.date,
  }) : super(key: key);

  void _shareReceipt() {
  final timestamp = date ?? DateTime.now();
  Share.share('''
    Transfert Wave
    Montant: ${NumberFormat.currency(symbol: 'FCFA ', decimalDigits: 0).format(amount)}
    Destinataire: ${recipientName ?? recipientPhone}
    Date: ${DateFormat('dd/MM/yyyy HH:mm').format(timestamp)}
    ${reference != null ? 'Référence: $reference' : ''}
    ${message != null ? 'Message: $message' : ''}
  ''');
}

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      symbol: 'FCFA ',
      decimalDigits: 0,
    );
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final timestamp = date ?? DateTime.now();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            currencyFormat.format(amount),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Envoyé à ${recipientName ?? recipientPhone}',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 8),
            Text(
              message!,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 24),
          _buildInfoRow('Montant', currencyFormat.format(amount)),
          _buildInfoRow('Destinataire', recipientPhone),
          _buildInfoRow('Date', dateFormat.format(timestamp)),
          if (transactionId != null)
            _buildInfoRow('N° Transaction', transactionId!),
          if (reference != null)
            _buildInfoRow('Référence', reference!),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _shareReceipt,
                  icon: const Icon(Icons.share),
                  label: const Text('Partager le reçu'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}