import 'package:flutter/material.dart';

class ContactFilter extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const ContactFilter({
    Key? key,
    required this.selectedFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _FilterChip(
              label: 'Tous',
              isSelected: selectedFilter == 'all',
              onTap: () => onFilterChanged('all'),
            ),
            _FilterChip(
              label: 'Favoris',
              isSelected: selectedFilter == 'favorite',
              onTap: () => onFilterChanged('favorite'),
            ),
            _FilterChip(
              label: 'Récents',
              isSelected: selectedFilter == 'recent',
              onTap: () => onFilterChanged('recent'),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: isSelected ? Colors.deepPurple : Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}