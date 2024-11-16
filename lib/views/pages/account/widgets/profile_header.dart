// lib/views/pages/account/widgets/profile_header.dart
import 'package:flutter/material.dart';
import 'qr_code_modal.dart';
class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;

  const ProfileHeader({
    Key? key,
    required this.name,
    required this.email,
    required this.imageUrl,
  }) : super(key: key);

  void _showQRCode(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => QRCodeModal(
        data: 'PayWise:$email', // Vous pouvez modifier les données à encoder
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.deepPurple.shade100,
            backgroundImage: AssetImage(imageUrl),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  email,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () => _showQRCode(context),
          ),
        ],
      ),
    );
  }
}