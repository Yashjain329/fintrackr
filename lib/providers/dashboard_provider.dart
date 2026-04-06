import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/transaction_provider.dart';

final dashboardProvider = Provider((ref) {
  final txs = ref.watch(transactionProvider);

  double income = 0;
  double expense = 0;

  for (var tx in txs) {
    if (tx.isIncome) {
      income += tx.amount;
    } else {
      expense += tx.amount;
    }
  }

  return {
    "income": income,
    "expense": expense,
    "balance": income - expense,
  };
});