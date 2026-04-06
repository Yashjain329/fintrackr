import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/transaction_provider.dart';
import 'widgets/category_chart.dart';


class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txs = ref.watch(transactionProvider);

    if (txs.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No data yet")),
      );
    }

    final Map<String, double> categoryTotals = {};

    for (var tx in txs) {
      if (!tx.isIncome) {
        categoryTotals[tx.category] =
            (categoryTotals[tx.category] ?? 0) + tx.amount;
      }
    }

    final topCategory = categoryTotals.entries.isEmpty
        ? "None"
        : categoryTotals.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    final totalExpense = txs
        .where((e) => !e.isIncome)
        .fold(0.0, (a, b) => a + b.amount);

    double thisWeek = 0;
    double lastWeek = 0;

    final now = DateTime.now();

    for (var tx in txs) {
      final diff = now.difference(tx.date).inDays;

      if (!tx.isIncome) {
        if (diff <= 7) {
          thisWeek += tx.amount;
        } else if (diff <= 14) {
          lastWeek += tx.amount;
        }
      }
    }

    double change = lastWeek == 0
        ? 0
        : ((thisWeek - lastWeek) / lastWeek) * 100;

    String message;

    if (change > 20) {
      message = "You're spending significantly more this week";
    } else if (change < -20) {
      message = "Great job! You're saving more this week";
    } else {
      message = "Your spending is stable";
    }

    const SizedBox(height: 16);
    const CategoryChart();

    return Scaffold(
      appBar: AppBar(title: const Text("Insights")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: const Text("Top Spending Category"),
              subtitle: Text(topCategory),
            ),
            ListTile(
              title: const Text("Total Expenses"),
              subtitle: Text("₹$totalExpense"),
            ),
            ListTile(
              title: const Text("Weekly Spending Change"),
              subtitle: Text(
                change == 0
                    ? "No previous data"
                    : "${change.toStringAsFixed(1)}% ${change > 0 ? "increase" : "decrease"}",
              ),
            ),
            ListTile(
              title: const Text("Smart Insight"),
              subtitle: Text(message),
            ),
          ],
        ),
      ),
    );
  }
}

