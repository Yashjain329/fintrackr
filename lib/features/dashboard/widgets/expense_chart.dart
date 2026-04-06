import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/transaction_provider.dart';

class ExpenseChart extends ConsumerWidget {
  const ExpenseChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txs = ref.watch(transactionProvider);

    final Map<String, double> categoryMap = {};

    for (var tx in txs) {
      if (!tx.isIncome) {
        categoryMap[tx.category] =
            (categoryMap[tx.category] ?? 0) + tx.amount;
      }
    }

    final bars = categoryMap.entries.toList();

    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: bars.isEmpty
              ? const Center(child: Text("No expense data"))
              : BarChart(
            BarChartData(
              barGroups: List.generate(
                bars.length,
                    (i) => BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(toY: bars[i].value),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}