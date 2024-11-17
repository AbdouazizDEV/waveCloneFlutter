// lib/views/pages/transfer/widgets/scheduled_success_modal.dart
import 'package:flutter/material.dart';

class ScheduledSuccessModal extends StatelessWidget {
  final double amount;
  final String recipientPhone;
  final DateTime startDate;
  final TimeOfDay scheduleTime;
  final String frequency;

  const ScheduledSuccessModal({
    Key? key,
    required this.amount,
    required this.recipientPhone,
    required this.startDate,
    required this.scheduleTime,
    required this.frequency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icône de succès
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.purple,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 24),

          // Montant
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Texte de confirmation
          const Text(
            'Transfert planifié avec succès',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),

          // Détails du transfert
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildDetailRow('Destinataire', recipientPhone),
                _buildDetailRow('Fréquence', frequency),
                _buildDetailRow(
                  'Date de début',
                  '${startDate.day}/${startDate.month}/${startDate.year}',
                ),
                _buildDetailRow(
                  'Heure',
                  '${scheduleTime.hour}:${scheduleTime.minute.toString().padLeft(2, '0')}',
                ),
                _buildDetailRow(
                  'Frais',
                  '\$${(amount * 0.1).toStringAsFixed(2)}',
                ),
                _buildDetailRow(
                  'Total',
                  '\$${(amount + amount * 0.1).toStringAsFixed(2)}',
                  isLast: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Boutons d'action
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // TODO: Implémenter le téléchargement du reçu
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.purple),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Télécharger le reçu',
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implémenter le partage du reçu
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Partager le reçu'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
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
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}