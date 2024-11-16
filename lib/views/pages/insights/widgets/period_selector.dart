// lib/views/pages/insights/widgets/period_selector.dart
import 'package:flutter/material.dart';

class PeriodSelector extends StatelessWidget {
  final String selectedPeriod;
  final Function(String) onPeriodChanged;

  const PeriodSelector({
    Key? key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Show Chart in',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: selectedPeriod,
            items: ['Today', 'Week', 'Month', 'Year']
                .map((period) => DropdownMenuItem(
                      value: period,
                      child: Text(period),
                    ))
                .toList(),
            onChanged: (value) => onPeriodChanged(value!),
            underline: const SizedBox(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}