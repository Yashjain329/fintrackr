import 'package:flutter/material.dart';
import '../../../data/models/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel tx;

  const TransactionTile({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: tx.isIncome ? Colors.green : Colors.red,
          child: Icon(
            tx.isIncome ? Icons.arrow_downward : Icons.arrow_upward,
            color: Colors.white,
          ),
        ),
        title: Text(
          tx.category,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(tx.note.isEmpty ? "No note" : tx.note),
        trailing: Text(
          "₹${tx.amount}",
          style: TextStyle(
            color: tx.isIncome ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}