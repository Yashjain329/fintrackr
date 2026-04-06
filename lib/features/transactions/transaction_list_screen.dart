import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/transaction_provider.dart';
import 'add_edit_transaction_screen.dart';
import 'widgets/transaction_tile.dart';
import 'widgets/filter_bar.dart';
import '../../shared/widgets/empty_state.dart';

class TransactionListScreen extends ConsumerStatefulWidget {
  const TransactionListScreen({super.key});

  @override
  ConsumerState<TransactionListScreen> createState() =>
      _TransactionListScreenState();
}

class _TransactionListScreenState
    extends ConsumerState<TransactionListScreen> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(transactionProvider.notifier);
    final all = ref.watch(transactionProvider);

    final transactions =
    query.isEmpty ? all : provider.search(query);

    return Scaffold(
      appBar: AppBar(title: const Text("Transactions")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const AddEditTransactionScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: FilterBar(onSearch: (q) {
              setState(() => query = q);
            }),
          ),
          Expanded(
            child: transactions.isEmpty
                ? const EmptyState(message: "No transactions found")
                : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return Dismissible(
                  key: Key(tx.id),
                  background: Container(color: Colors.red),
                  onDismissed: (_) {
                    ref
                        .read(transactionProvider.notifier)
                        .delete(tx.id);
                  },
                  child: TransactionTile(tx: tx),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}