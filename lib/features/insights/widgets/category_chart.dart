import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/transaction_provider.dart';

class CategoryChart extends ConsumerWidget {
  const CategoryChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txs = ref.watch(transactionProvider);

    final Map<String, double> data = {};

    for (var tx in txs) {
      if (!tx.isIncome) {
        data[tx.category] = (data[tx.category] ?? 0) + tx.amount;
      }
    }

    return Column(
      children: data.entries.map((e) {
        return ListTile(
          title: Text(e.key),
          trailing: Text("₹${e.value}"),
        );
      }).toList(),
    );
  }
}