// lib/views/pages/transfer/widgets/transfer_type_grid.dart
import 'package:flutter/material.dart';
import '../simple_transfer_modal.dart';
import '../scheduled_transfer_page.dart';
import '../multiple_transfer_page.dart';

class TransferTypeGrid extends StatelessWidget {
  const TransferTypeGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.3,  // Modifié de 1.5 à 1.3 pour donner plus d'espace en hauteur
        children: [
          _buildTransferTypeCard(
            context,
            icon: Icons.phone_android,
            title: 'Transfert Simple',
            subtitle: 'Vers un numéro',
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const SimpleTransferModal(),
              );
            },
          ),
          _buildTransferTypeCard(
            context,
            icon: Icons.schedule,
            title: 'Transfert Planifié',
            subtitle: 'Jour/semaine/mois',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScheduledTransferPage(),
                ),
              );
            },
          ),
          _buildTransferTypeCard(
            context,
            icon: Icons.people,
            title: 'Transfert Multiple',
            subtitle: 'Plusieurs numéros',
            onTap: () {
              // Implémentez la navigation
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MultipleTransferPage(),
                ),
              );
            },
          ),
          _buildTransferTypeCard(
            context,
            icon: Icons.calendar_today,
            title: 'Annuler Planning',
            subtitle: 'Gérer vos planificat...',
            onTap: () {
              // Implémentez la navigation
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransferTypeCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),  // Réduit de 16 à 12
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,  // Ajouté pour minimiser la taille de la colonne
          children: [
            Icon(
              icon,
              color: Colors.purple,
              size: 28,
            ),
            const SizedBox(height: 6),  // Réduit de 8 à 6
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 1,  // Ajouté pour éviter le débordement du texte
              overflow: TextOverflow.ellipsis,  // Ajouté pour gérer le texte trop long
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
              maxLines: 1,  // Ajouté pour éviter le débordement du texte
              overflow: TextOverflow.ellipsis,  // Ajouté pour gérer le texte trop long
            ),
          ],
        ),
      ),
    );
  }
}