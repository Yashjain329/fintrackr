
import 'package:hive/hive.dart';
import '../models/transaction_model.dart';

class TransactionRepository {
  final box = Hive.box<TransactionModel>('transactions');

  List<TransactionModel> getAll() => box.values.toList();

  void add(TransactionModel tx) => box.put(tx.id, tx);
  void delete(String id) => box.delete(id);
  void update(TransactionModel tx) => box.put(tx.id, tx);
}
