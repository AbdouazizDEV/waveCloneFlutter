import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionButton(icon: Icons.send, label: 'Send'),
          _buildActionButton(icon: Icons.download, label: 'Request'),
          _buildActionButton(icon: Icons.add, label: 'Top Up'),
          _buildActionButton(icon: Icons.logout, label: 'Withdraw'),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
  }) {
    return Column(
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
    );
  }
}