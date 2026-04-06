import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/transaction_model.dart';
import '../data/repositories/transaction_repository.dart';

final transactionProvider =
StateNotifierProvider<TransactionNotifier, List<TransactionModel>>(
        (ref) => TransactionNotifier());

class TransactionNotifier extends StateNotifier<List<TransactionModel>> {
  final _repo = TransactionRepository();

  TransactionNotifier() : super([]) {
    load();
  }

  void load() {
    state = _repo.getAll();
  }

  void add(TransactionModel tx) {
    _repo.add(tx);
    load();
  }

  void update(TransactionModel tx) {
    _repo.update(tx);
    load();
  }

  void delete(String id) {
    _repo.delete(id);
    load();
  }

  List<TransactionModel> search(String query) {
    return state
        .where((tx) =>
    tx.category.toLowerCase().contains(query.toLowerCase()) ||
        tx.note.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  double totalIncome() =>
      state.where((e) => e.isIncome).fold(0, (a, b) => a + b.amount);

  double totalExpense() =>
      state.where((e) => !e.isIncome).fold(0, (a, b) => a + b.amount);
}