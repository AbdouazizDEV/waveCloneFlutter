import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;

  const PaymentCard({
    Key? key,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF9C27B0),  // Purple
            Color(0xFF673AB7),  // Deep Purple
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Motif de fond
          Positioned.fill(
            child: CustomPaint(
              painter: CardPatternPainter(),
            ),
          ),
          // Contenu de la carte
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Payment Card',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Logos des cartes
                    Row(
                      children: [
                        _buildCardLogo('Mastercard'),
                        const SizedBox(width: 8),
                        _buildCardLogo('Visa'),
                        const SizedBox(width: 8),
                        _buildCardLogo('Amazon'),
                        const SizedBox(width: 8),
                        _buildCardLogo('JCB'),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                // Numéro de carte
                Text(
                  _formatCardNumber(cardNumber),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 20),
                // Nom du titulaire et date d'expiration
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Card Holder Name',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cardHolderName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Expiry Date',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          expiryDate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardLogo(String name) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      // Ici vous pouvez utiliser de vraies images de logo
      child: Center(
        child: Text(
          name[0],
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }

  String _formatCardNumber(String number) {
    const chunk = 4;
    List<String> chunks = [];
    
    for (var i = 0; i < number.length; i += chunk) {
      int end = (i + chunk < number.length) ? i + chunk : number.length;
      chunks.add(number.substring(i, end));
    }
    
    return chunks.join(' ');
  }
}

// Peintre personnalisé pour le motif de fond
class CardPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    
    // Créer un motif géométrique
    path.moveTo(size.width * 0.7, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.4);
    path.close();

    path.moveTo(size.width * 0.6, size.height);
    path.lineTo(size.width, size.height * 0.6);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}