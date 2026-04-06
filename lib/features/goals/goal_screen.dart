import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/transaction_provider.dart';

class GoalScreen extends ConsumerWidget {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txs = ref.watch(transactionProvider);

    double saved = txs
        .where((e) => e.isIncome)
        .fold(0.0, (a, b) => a + b.amount);

    double spent = txs
        .where((e) => !e.isIncome)
        .fold(0.0, (a, b) => a + b.amount);

    double net = saved - spent;

    double target = 10000;
    double progress = (net / target).clamp(0, 1);
    double remaining = target - net;

    return Scaffold(
      appBar: AppBar(title: const Text("Savings Goal")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Goal: ₹$target"),
            const SizedBox(height: 20),
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 10),
            Text("Saved: ₹${net.toStringAsFixed(2)}"),
            Text("Remaining: ₹${remaining.toStringAsFixed(2)}"),
          ],
        ),
      ),
    );
  }
}