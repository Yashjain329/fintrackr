import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/transaction_model.dart';
import '../../data/models/goal_model.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(TransactionModelAdapter());
    Hive.registerAdapter(GoalModelAdapter());

    await Hive.openBox<TransactionModel>('transactions');
    await Hive.openBox<GoalModel>('goals');
  }
}