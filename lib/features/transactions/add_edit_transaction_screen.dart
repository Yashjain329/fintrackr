import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/transaction_provider.dart';
import '../../data/models/transaction_model.dart';
import 'package:uuid/uuid.dart';

class AddEditTransactionScreen extends ConsumerStatefulWidget {
  const AddEditTransactionScreen({super.key});

  @override
  ConsumerState<AddEditTransactionScreen> createState() =>
      _AddEditTransactionScreenState();
}

class _AddEditTransactionScreenState
    extends ConsumerState<AddEditTransactionScreen> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  bool isIncome = false;
  String category = "General";

  void _save() {
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter amount")),
      );
      return;
    }

    final amount = double.tryParse(_amountController.text);

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid amount")),
      );
      return;
    }

    final tx = TransactionModel(
      id: const Uuid().v4(),
      amount: amount,
      category: category,
      date: DateTime.now(),
      isIncome: isIncome,
      note: _noteController.text,
    );

    ref.read(transactionProvider.notifier).add(tx);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Transaction added")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Transaction")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Amount"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: "Note"),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text("Income"),
              value: isIncome,
              onChanged: (v) => setState(() => isIncome = v),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _save,
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}