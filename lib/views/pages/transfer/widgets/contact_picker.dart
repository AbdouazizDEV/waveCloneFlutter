// lib/views/pages/transfer/widgets/contact_picker.dart
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactPicker extends StatefulWidget {
  final TextEditingController controller;
  final Function(Contact) onContactSelected;

  const ContactPicker({
    Key? key,
    required this.controller,
    required this.onContactSelected,
  }) : super(key: key);

  @override
  State<ContactPicker> createState() => _ContactPickerState();
}

class _ContactPickerState extends State<ContactPicker> {
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    if (await FlutterContacts.requestPermission()) {
      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );
      setState(() {
        _contacts = contacts;
        _filteredContacts = contacts;
      });
    }
  }

  void _filterContacts(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredContacts = _contacts;
      });
      return;
    }

    setState(() {
      _filteredContacts = _contacts.where((contact) {
        final name = contact.displayName.toLowerCase();
        final phone = contact.phones.isNotEmpty ? contact.phones.first.number.toLowerCase() : '';
        final searchQuery = query.toLowerCase();
        return name.contains(searchQuery) || phone.contains(searchQuery);
      }).toList();
    });
  }

  void _showContactSearch() {
    setState(() {
      _isSearching = true;
    });
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Rechercher un contact...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: _filterContacts,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: _filteredContacts.length,
                  itemBuilder: (context, index) {
                    final contact = _filteredContacts[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(contact.displayName[0]),
                      ),
                      title: Text(contact.displayName),
                      subtitle: contact.phones.isNotEmpty
                          ? Text(contact.phones.first.number)
                          : null,
                      onTap: () {
                        widget.onContactSelected(contact);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ).then((_) {
      setState(() {
        _isSearching = false;
      });
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Numéro de téléphone',
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _showContactSearch,
                ),
                IconButton(
                  icon: const Icon(Icons.contact_phone),
                  onPressed: () async {
                    final contact = await FlutterContacts.openExternalPick();
                    if (contact != null) {
                      widget.onContactSelected(contact);
                    }
                  },
                ),
              ],
            ),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Veuillez entrer un numéro de téléphone';
            }
            return null;
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}