import 'package:hive/hive.dart';

part 'goal_model.g.dart';

@HiveType(typeId: 1)
class GoalModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double targetAmount;

  @HiveField(2)
  final double savedAmount;

  GoalModel({
    required this.id,
    required this.targetAmount,
    required this.savedAmount,
  });
}