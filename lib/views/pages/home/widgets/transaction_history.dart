// lib/views/pages/home/widgets/transaction_history.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import './transaction_item.dart';
import '../../../../services/transaction_service.dart';
import '../../../../services/http/dio_client.dart';
import '../../../../models/transaction.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  late Future<Map<String, dynamic>> _transactionsFuture;
  final _dateFormat = DateFormat('dd/MM/yyyy HH:mm');

  @override
  void initState() {
    super.initState();
    final transactionService = TransactionService(context.read<DioClient>());
    _transactionsFuture = transactionService.getTransactionHistory();
  }

  String _getTransactionIcon(Transaction transaction) {
    if (transaction.type.libelle == 'TRANSFERT_SIMPLE') {
      return transaction.isExpediteur ? '➡️' : '⬅️';
    } else if (transaction.type.libelle == 'TRANSFERT_MULTIPLE') {
      return '🔄';
    }
    return '💰';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _transactionsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Erreur: ${snapshot.error}'),
          );
        }

        final transactions = snapshot.data!['transactions'] as List<Transaction>;
        final stats = snapshot.data!['stats'] as TransactionStats;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard(
                    'Envoyé',
                    stats.totalEnvoye,
                    stats.nombreEnvois.toString(),
                    Colors.red.shade100,
                    Icons.arrow_upward,
                  ),
                  _buildStatCard(
                    'Reçu',
                    stats.totalRecu,
                    stats.nombreReceptions.toString(),
                    Colors.green.shade100,
                    Icons.arrow_downward,
                  ),
                ],
              ),
            ),
            
            // Transactions Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Historique des transactions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigation vers toutes les transactions
                    },
                    child: const Text('Voir tout'),
                  ),
                ],
              ),
            ),

            // Transactions List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return TransactionItem(
                  name: transaction.autrePartie.fullName,
                  time: _dateFormat.format(transaction.date),
                  amount: '${transaction.isExpediteur ? "-" : "+"}${transaction.montant}',
                  type: transaction.type.libelle,
                  icon: _getTransactionIcon(transaction),
                  status: transaction.status,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(String title, String amount, String count, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16),
              const SizedBox(width: 4),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            '$count transactions',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}