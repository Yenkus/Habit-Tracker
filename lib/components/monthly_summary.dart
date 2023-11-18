import 'package:flutter/material.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int> dataset;
  final String startDate;
  const MonthlySummary(
      {super.key, required this.dataset, required this.startDate});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
