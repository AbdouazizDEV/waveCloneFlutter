// lib/views/pages/scan/widgets/qr_overlay.dart
import 'package:flutter/material.dart';

class QROverlay extends StatelessWidget {
  const QROverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 320,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // Coins supérieurs
          Positioned(
            top: 0,
            left: 0,
            child: _buildCorner(),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Transform.rotate(
              angle: 3.14159 / 2,
              child: _buildCorner(),
            ),
          ),
          // Coins inférieurs
          Positioned(
            bottom: 0,
            right: 0,
            child: Transform.rotate(
              angle: 3.14159,
              child: _buildCorner(),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Transform.rotate(
              angle: -3.14159 / 2,
              child: _buildCorner(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.deepPurple.withOpacity(0.8),
            width: 4,
          ),
          top: BorderSide(
            color: Colors.deepPurple.withOpacity(0.8),
            width: 4,
          ),
        ),
      ),
    );
  }
}