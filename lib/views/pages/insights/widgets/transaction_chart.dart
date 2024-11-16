// lib/views/pages/insights/widgets/transaction_chart.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TransactionChart extends StatelessWidget {
  const TransactionChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            horizontalInterval: 100,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey[300],
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}.5',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 100,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          barGroups: [
            _generateGroup(0, 340, 400),
            _generateGroup(1, 240, 430),
            _generateGroup(2, 300, 360),
            _generateGroup(3, 340, 330),
            _generateGroup(4, 260, 320),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _generateGroup(int x, double income, double expense) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barsSpace: 4,
      barRods: [
        BarChartRodData(
          toY: income,
          color: Colors.green[300],
          width: 12,
          borderRadius: BorderRadius.circular(2),
        ),
        BarChartRodData(
          toY: expense,
          color: Colors.red[300],
          width: 12,
          borderRadius: BorderRadius.circular(2),
        ),
      ],
    );
  }
}