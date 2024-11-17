// lib/views/pages/transfer/widgets/contact_list_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactListItem extends StatelessWidget {
  final Contact contact;
  final bool isSelected;
  final VoidCallback onToggle;

  const ContactListItem({
    Key? key,
    required this.contact,
    required this.isSelected,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstLetter = contact.displayName[0].toUpperCase();
    final phoneNumber = contact.phones.isNotEmpty 
        ? contact.phones.first.number 
        : '';

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          firstLetter,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        contact.displayName,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        phoneNumber,
        style: TextStyle(color: Colors.grey[600]),
      ),
      trailing: SizedBox(
        width: 24,
        height: 24,
        child: Checkbox(
          value: isSelected,
          onChanged: (value) => onToggle(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      onTap: onToggle,
    );
  }
}