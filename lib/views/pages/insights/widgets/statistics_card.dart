// lib/views/pages/insights/widgets/statistics_card.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsCard extends StatelessWidget {
  final String title;
  final double amount;
  final double percentage;
  final bool isIncome;

  const StatisticsCard({
    Key? key,
    required this.title,
    required this.amount,
    required this.percentage,
    required this.isIncome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isIncome ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${percentage > 0 ? '+' : ''}$percentage%',
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 40,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: _generateSpots(isIncome),
                    isCurved: true,
                    color: color,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: color.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<FlSpot> _generateSpots(bool isIncome) {
    if (isIncome) {
      return [
        const FlSpot(0, 2),
        const FlSpot(1, 2.3),
        const FlSpot(2, 2),
        const FlSpot(3, 2.6),
        const FlSpot(4, 2.4),
        const FlSpot(5, 2.8),
      ];
    } else {
      return [
        const FlSpot(0, 2.5),
        const FlSpot(1, 2.2),
        const FlSpot(2, 2.4),
        const FlSpot(3, 2.1),
        const FlSpot(4, 2.3),
        const FlSpot(5, 1.8),
      ];
    }
  }
}