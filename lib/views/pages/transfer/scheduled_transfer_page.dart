// lib/views/pages/transfer/scheduled_transfer_page.dart
import 'package:flutter/material.dart';
import './widgets/contact_picker.dart';
import './widgets/amount_input.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import './widgets/scheduled_success_modal.dart';

class ScheduledTransferPage extends StatefulWidget {
 const ScheduledTransferPage({Key? key}) : super(key: key);

 @override
 State<ScheduledTransferPage> createState() => _ScheduledTransferPageState();
}

class _ScheduledTransferPageState extends State<ScheduledTransferPage> {
 final _formKey = GlobalKey<FormState>();
 final _phoneController = TextEditingController();
 final _amountController = TextEditingController();
 DateTime _selectedDate = DateTime.now();
 TimeOfDay _selectedTime = TimeOfDay.now();
 String _frequency = 'Jour'; // 'Jour', 'Semaine', 'Mois'
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
       _fees = amount * 0.1;
     });
   }
 }

 void _handleContactSelected(Contact contact) {
   if (contact.phones.isNotEmpty) {
     setState(() {
       _phoneController.text = contact.phones.first.number;
     });
   }
 }

 Future<void> _selectDate() async {
   final picked = await showDatePicker(
     context: context,
     initialDate: _selectedDate,
     firstDate: DateTime.now(),
     lastDate: DateTime.now().add(const Duration(days: 365)),
     builder: (context, child) {
       return Theme(
         data: Theme.of(context).copyWith(
           colorScheme: const ColorScheme.light(
             primary: Colors.purple,
             onPrimary: Colors.white,
             onSurface: Colors.black,
           ),
         ),
         child: child!,
       );
     },
   );
   if (picked != null) {
     setState(() {
       _selectedDate = picked;
     });
   }
 }

 Future<void> _selectTime() async {
   final picked = await showTimePicker(
     context: context,
     initialTime: _selectedTime,
     builder: (context, child) {
       return Theme(
         data: Theme.of(context).copyWith(
           colorScheme: const ColorScheme.light(
             primary: Colors.purple,
             onPrimary: Colors.white,
             onSurface: Colors.black,
           ),
         ),
         child: child!,
       );
     },
   );
   if (picked != null) {
     setState(() {
       _selectedTime = picked;
     });
   }
 }

 void _handleScheduleTransfer() {
   if (_formKey.currentState?.validate() ?? false) {
     // D'abord fermer le formulaire
     Navigator.pop(context);
     
     // Puis afficher le modal de succès
     showModalBottomSheet(
       context: context,
       isScrollControlled: true,
       backgroundColor: Colors.transparent,
       builder: (context) => ScheduledSuccessModal(
         amount: double.parse(_amountController.text),
         recipientPhone: _phoneController.text,
         startDate: _selectedDate,
         scheduleTime: _selectedTime,
         frequency: _frequency,
       ),
     );
   }
 }

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text(
         'Transfert Planifié',
         style: TextStyle(
           color: Colors.black,
           fontSize: 20,
           fontWeight: FontWeight.bold,
         ),
       ),
       backgroundColor: Colors.transparent,
       elevation: 0,
       leading: IconButton(
         icon: const Icon(Icons.arrow_back, color: Colors.black),
         onPressed: () => Navigator.pop(context),
       ),
     ),
     body: SingleChildScrollView(
       padding: const EdgeInsets.all(16),
       child: Form(
         key: _formKey,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             // Contact Picker
             ContactPicker(
               controller: _phoneController,
               onContactSelected: _handleContactSelected,
             ),
             const SizedBox(height: 16),

             // Montant Input
             AmountInput(
               controller: _amountController,
               fees: _fees,
             ),
             const SizedBox(height: 24),

             // Fréquence
             const Text(
               'Fréquence',
               style: TextStyle(
                 fontSize: 16,
                 fontWeight: FontWeight.w500,
               ),
             ),
             const SizedBox(height: 8),
             Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(30),
                 color: Colors.grey[200],
               ),
               child: Row(
                 children: [
                   _buildFrequencyOption('Jour'),
                   _buildFrequencyOption('Semaine'),
                   _buildFrequencyOption('Mois'),
                 ],
               ),
             ),
             const SizedBox(height: 24),

             // Date de début
             InkWell(
               onTap: _selectDate,
               child: Container(
                 padding: const EdgeInsets.all(16),
                 decoration: BoxDecoration(
                   color: Colors.grey[100],
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const Text(
                           'Date de début',
                           style: TextStyle(
                             color: Colors.grey,
                             fontSize: 14,
                           ),
                         ),
                         Text(
                           '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                           style: const TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.w500,
                           ),
                         ),
                       ],
                     ),
                     const Icon(Icons.calendar_today),
                   ],
                 ),
               ),
             ),
             const SizedBox(height: 16),

             // Heure de transfert
             InkWell(
               onTap: _selectTime,
               child: Container(
                 padding: const EdgeInsets.all(16),
                 decoration: BoxDecoration(
                   color: Colors.grey[100],
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const Text(
                           'Heure de transfert',
                           style: TextStyle(
                             color: Colors.grey,
                             fontSize: 14,
                           ),
                         ),
                         Text(
                           '${_selectedTime.hour}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                           style: const TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.w500,
                           ),
                         ),
                       ],
                     ),
                     const Icon(Icons.access_time),
                   ],
                 ),
               ),
             ),
             const SizedBox(height: 32),

             // Bouton de planification
             SizedBox(
               width: double.infinity,
               child: ElevatedButton(
                 onPressed: _handleScheduleTransfer,
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.purple,
                   padding: const EdgeInsets.symmetric(vertical: 16),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(12),
                   ),
                   
                 ),
                 child: const Text(
                   'Planifier le transfert',
                   style: TextStyle(
                     fontSize: 16,
                     color: Colors.white,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ),
             ),
           ],
         ),
       ),
     ),
   );
 }

 Widget _buildFrequencyOption(String frequency) {
   final isSelected = _frequency == frequency;
   return Expanded(
     child: GestureDetector(
       onTap: () => setState(() => _frequency = frequency),
       child: Container(
         padding: const EdgeInsets.symmetric(vertical: 12),
         decoration: BoxDecoration(
           color: isSelected ? Colors.purple : Colors.transparent,
           borderRadius: BorderRadius.circular(30),
         ),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             if (frequency == 'Jour')
               Icon(
                 Icons.check,
                 color: isSelected ? Colors.white : Colors.grey,
                 size: 16,
               )
             else if (frequency == 'Semaine')
               Icon(
                 Icons.view_week,
                 color: isSelected ? Colors.white : Colors.grey,
                 size: 16,
               )
             else
               Icon(
                 Icons.calendar_month,
                 color: isSelected ? Colors.white : Colors.grey,
                 size: 16,
               ),
             const SizedBox(width: 4),
             Text(
               frequency,
               style: TextStyle(
                 color: isSelected ? Colors.white : Colors.grey,
                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
               ),
             ),
           ],
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