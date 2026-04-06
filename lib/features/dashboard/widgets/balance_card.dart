import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/transaction_provider.dart';

class BalanceCard extends ConsumerWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);

    double income = 0;
    double expense = 0;

    for (var tx in transactions) {
      if (tx.isIncome) {
        income += tx.amount;
      } else {
        expense += tx.amount;
      }
    }

    final balance = income - expense;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Current Balance",
                style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Text("₹${balance.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.headlineMedium),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Income: ₹${income.toStringAsFixed(0)}"),
                Text("Expense: ₹${expense.toStringAsFixed(0)}"),
              ],
            )
          ],
        ),
      ),
    );
  }
}