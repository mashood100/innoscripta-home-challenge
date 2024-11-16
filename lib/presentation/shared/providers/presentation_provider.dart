import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/presentation/provider/project/project_state.dart';
import 'package:innoscripta_home_challenge/presentation/provider/project/project_state_notifier.dart';
import 'package:innoscripta_home_challenge/presentation/provider/task/task_state.dart';
import 'package:innoscripta_home_challenge/presentation/provider/task/task_state_notifier.dart';

final projectStateProvider =
    StateNotifierProvider<ProjectStateNotifier, ProjectState>(
  (ref) => ProjectStateNotifier(
    ref: ref,
  ),
);

final taskStateProvider = StateNotifierProvider<TaskStateNotifier, TaskState>(
  (ref) => TaskStateNotifier(
    ref: ref,
  ),
);
