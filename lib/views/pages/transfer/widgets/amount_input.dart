// lib/views/pages/transfer/widgets/amount_input.dart
import 'package:flutter/material.dart';
class AmountInput extends StatelessWidget {
  final TextEditingController controller;
  final double fees;

  const AmountInput({
    Key? key,
    required this.controller,
    required this.fees,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Montant',
            prefixText: '\$ ',
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Veuillez entrer un montant';
            }
            final amount = double.tryParse(value!);
            if (amount == null || amount <= 0) {
              return 'Veuillez entrer un montant valide';
            }
            return null;
          },
        ),
        if (fees > 0) ...[
          const SizedBox(height: 8),
          Text(
            'Frais de transfert: \$${fees.toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          Text(
            'Total: \$${(double.parse(controller.text) + fees).toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ],
    );
  }
}
