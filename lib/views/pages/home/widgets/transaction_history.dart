import 'package:flutter/material.dart';
import './transaction_item.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Transaction History',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigation vers toutes les transactions
                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        const TransactionItem(
          name: 'Walker Evans',
          time: '22:28 PM',
          amount: '+560.00',
          type: 'Sent',
          imageUrl: 'assets/images/avatar1.png',
        ),
        const TransactionItem(
          name: 'Young Clarke',
          time: '11:19 PM',
          amount: '-250.00',
          type: 'Incoming Request',
          imageUrl: 'assets/images/avatar2.png',
        ),
      ],
    );
  }
}