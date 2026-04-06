import 'package:hive/hive.dart';
import '../models/goal_model.dart';

class GoalRepository {
  final box = Hive.box<GoalModel>('goals');

  GoalModel? getGoal() {
    return box.values.isEmpty ? null : box.values.first;
  }

  void saveGoal(GoalModel goal) {
    box.put(goal.id, goal);
  }
}