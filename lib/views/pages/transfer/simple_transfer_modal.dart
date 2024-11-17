// lib/views/pages/transfer/simple_transfer_modal.dart
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import './widgets/amount_input.dart';
import './widgets/contact_picker.dart';
import './success_modal.dart';

class SimpleTransferModal extends StatefulWidget {
  const SimpleTransferModal({Key? key}) : super(key: key);

  @override
  State<SimpleTransferModal> createState() => _SimpleTransferModalState();
}

class _SimpleTransferModalState extends State<SimpleTransferModal> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  double _fees = 0;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_calculateFees);
  }

  void _calculateFees() {
    if (_amountController.text.isNotEmpty) {
      final amount = double.tryParse(_amountController.text) ?? 0;
      setState(() {
        _fees = amount * 0.01; // frait de 1%
      });
    }
  }

  void _handleTransfer() {
    if (_formKey.currentState?.validate() ?? false) {
      // Simuler un transfert réussi
      Navigator.pop(context); // Fermer le modal de transfert
      
      // Afficher le modal de succès
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => SuccessModal(
          amount: double.parse(_amountController.text),
          recipientName: "Williams Green", // À remplacer par le vrai nom
          recipientEmail: "Williams.Green@gmail.com", // À remplacer par le vrai email
          recipientPhone: _phoneController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Transfert Simple',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ContactPicker(
                  controller: _phoneController,
                  onContactSelected: (Contact contact) {
                    if (contact.phones.isNotEmpty) {
                      _phoneController.text = contact.phones.first.number;
                    }
                  },
                ),
                const SizedBox(height: 16),
                AmountInput(
                  controller: _amountController,
                  fees: _fees,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleTransfer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Envoyer'),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
