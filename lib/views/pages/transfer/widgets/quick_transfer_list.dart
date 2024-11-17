// lib/views/pages/transfer/widgets/quick_transfer_list.dart
import 'package:flutter/material.dart';

class QuickTransferList extends StatelessWidget {
  const QuickTransferList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildNewContactButton(),
          _buildContactItem(
            name: 'Fatou',
            imageUrl: 'assets/images/contact1.jpg',
          ),
          _buildContactItem(
            name: 'Moussa',
            imageUrl: 'assets/images/contact2.jpg',
          ),
          _buildContactItem(
            name: 'Aminata',
            imageUrl: 'assets/images/contact3.jpg',
          ),
          _buildContactItem(
            name: 'Omar',
            imageUrl: 'assets/images/contact4.jpg',
          ),
        ],
      ),
    );
  }

  Widget _buildNewContactButton() {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              color: Colors.grey,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Nouveau',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required String name,
    required String imageUrl,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imageUrl),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
