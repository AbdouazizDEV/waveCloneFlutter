import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;

  const ContactItem({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.deepPurple,
        child: Text(
          contact.displayName[0].toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(contact.displayName),
      subtitle: contact.phones.isNotEmpty
          ? Text(contact.phones.first.number)
          : null,
      trailing: IconButton(
        icon: const Icon(Icons.send),
        onPressed: () {
          // TODO: Implémenter la logique de transfert
        },
      ),
    );
  }
}