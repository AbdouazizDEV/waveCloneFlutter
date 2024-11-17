// lib/views/pages/home/widgets/action_buttons.dart
import 'package:flutter/material.dart';
import '../../transfer/transfer_page.dart';
import 'package:go_router/go_router.dart';
class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionButton(
              context: context,
              icon: Icons.send,
              label: 'Send',
              onTap: () => GoRouter.of(context).go('/transfer'),
            ),
          _buildActionButton(
            context: context,  // Ajout du context
            icon: Icons.download,
            label: 'Request',
            onTap: () {
              // TODO: Implémenter la navigation vers Request
            },
          ),
          _buildActionButton(
            context: context,  // Ajout du context
            icon: Icons.add,
            label: 'Top Up',
            onTap: () {
              // TODO: Implémenter la navigation vers Top Up
            },
          ),
          _buildActionButton(
            context: context,  // Ajout du context
            icon: Icons.logout,
            label: 'Withdraw',
            onTap: () {
              // TODO: Implémenter la navigation vers Withdraw
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,  // Ajout du context
    required IconData icon,
    required String label,
    required VoidCallback onTap,  // Ajout du callback onTap
  }) {
    return GestureDetector(  // Ajout du GestureDetector pour la gestion des clics
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.deepPurple.withOpacity(0.2)),
            ),
            child: Icon(icon, color: Colors.deepPurple),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}