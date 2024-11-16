import 'package:flutter/material.dart';

class ContactsSearch extends StatelessWidget {
  final Function(String) onSearch;

  const ContactsSearch({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: onSearch,
        decoration: InputDecoration(
          hintText: 'Rechercher un contact...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}