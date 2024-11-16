import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'contact_item.dart';

class ContactList extends StatelessWidget {
  final List<Contact> contacts;

  const ContactList({
    Key? key,
    required this.contacts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (contacts.isEmpty) {
      return const Center(
        child: Text('Aucun contact trouvé'),
      );
    }

    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ContactItem(contact: contact);
      },
    );
  }
}