import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/goal_model.dart';
import '../data/repositories/goal_repository.dart';

final goalProvider =
StateNotifierProvider<GoalNotifier, GoalModel?>(
        (ref) => GoalNotifier());

class GoalNotifier extends StateNotifier<GoalModel?> {
  final _repo = GoalRepository();

  GoalNotifier() : super(null) {
    load();
  }

  void load() {
    state = _repo.getGoal();
  }

  void setGoal(GoalModel goal) {
    _repo.saveGoal(goal);
    state = goal;
  }

  void updateProgress(double amount) {
    if (state == null) return;

    final updated = GoalModel(
      id: state!.id,
      targetAmount: state!.targetAmount,
      savedAmount: state!.savedAmount + amount,
    );

    _repo.saveGoal(updated);
    state = updated;
  }
}