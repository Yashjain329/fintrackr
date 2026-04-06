import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final bool isIncome;

  @HiveField(5)
  final String note;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.date,
    required this.isIncome,
    required this.note,
  });
}
