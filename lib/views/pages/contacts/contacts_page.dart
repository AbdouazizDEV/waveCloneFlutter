import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import './widgets/contact_list.dart';
import './widgets/contacts_search.dart';
import './widgets/contact_filter.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];
  bool _isLoading = true;
  String _searchQuery = '';
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    try {
      if (await Permission.contacts.request().isGranted) {
        final contacts = await FlutterContacts.getContacts(
          withProperties: true,
          withPhoto: true,
        );
        setState(() {
          _contacts = contacts;
          _filteredContacts = contacts;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
        _showPermissionDeniedDialog();
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorDialog('Erreur lors du chargement des contacts');
    }
  }

  void _filterContacts(String query) {
    setState(() {
      _searchQuery = query;
      _applyFilters();
    });
  }

  void _updateFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
      _applyFilters();
    });
  }

  void _applyFilters() {
    var filtered = _contacts;

    // Appliquer la recherche
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((contact) {
        final name = contact.displayName.toLowerCase();
        final phone = contact.phones.isNotEmpty ? contact.phones.first.number : '';
        return name.contains(_searchQuery.toLowerCase()) ||
            phone.contains(_searchQuery);
      }).toList();
    }

    // Appliquer le filtre
    switch (_selectedFilter) {
      case 'favorite':
        // Implémentez votre logique de filtrage des favoris
        break;
      case 'recent':
        // Implémentez votre logique de filtrage des récents
        break;
    }

    setState(() => _filteredContacts = filtered);
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission requise'),
        content: const Text(
          'Cette application nécessite l\'accès à vos contacts. '
          'Veuillez activer la permission dans les paramètres.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => openAppSettings(),
            child: const Text('Paramètres'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erreur'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ContactsSearch(onSearch: _filterContacts),
          ContactFilter(
            selectedFilter: _selectedFilter,
            onFilterChanged: _updateFilter,
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ContactList(contacts: _filteredContacts),
          ),
        ],
      ),
    );
  }
}