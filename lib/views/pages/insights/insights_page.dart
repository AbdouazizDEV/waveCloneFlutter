// lib/views/pages/insights/insights_page.dart
import 'package:flutter/material.dart';
import './widgets/period_selector.dart';
import './widgets/transaction_chart.dart';
import './widgets/statistics_card.dart';

class InsightsPage extends StatefulWidget {
  const InsightsPage({Key? key}) : super(key: key);

  @override
  State<InsightsPage> createState() => _InsightsPageState();
}

class _InsightsPageState extends State<InsightsPage> {
  String _selectedPeriod = 'Today';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView( // Ajout du SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Ajout de cette ligne
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Insights',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      // TODO: Implement menu options
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              PeriodSelector(
                selectedPeriod: _selectedPeriod,
                onPeriodChanged: (value) {
                  setState(() => _selectedPeriod = value);
                },
              ),
              const SizedBox(height: 20),
              SizedBox( // Ajout d'une taille fixe pour le graphique
                height: MediaQuery.of(context).size.height * 0.35,
                child: const TransactionChart(),
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Expanded(
                    child: StatisticsCard(
                      title: 'Income',
                      amount: 3564.50,
                      percentage: 5.6,
                      isIncome: true,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: StatisticsCard(
                      title: 'Expense',
                      amount: 2058.45,
                      percentage: -3.2,
                      isIncome: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Ajouter un espacement en bas
            ],
          ),
        ),
      ),
    );
  }
}