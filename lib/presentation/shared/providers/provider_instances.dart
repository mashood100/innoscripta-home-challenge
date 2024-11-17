import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/presentation/provider/project/project_state.dart';
import 'package:innoscripta_home_challenge/presentation/provider/project/project_state_notifier.dart';
import 'package:innoscripta_home_challenge/presentation/provider/task/task_state.dart';
import 'package:innoscripta_home_challenge/presentation/provider/task/task_state_notifier.dart';
import 'package:innoscripta_home_challenge/presentation/provider/timer/timer_notifier.dart';
import 'package:innoscripta_home_challenge/presentation/provider/timer/timer_state.dart';
import 'package:innoscripta_home_challenge/presentation/provider/theme/theme_provider.dart';
import 'package:innoscripta_home_challenge/presentation/provider/comment/comment_state_notifier.dart';
import 'package:innoscripta_home_challenge/presentation/provider/comment/comment_state.dart';

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

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  return TimerNotifier(
    ref: ref,
  );
});

final commentStateProvider =
    StateNotifierProvider<CommentStateNotifier, CommentState>((ref) {
  return CommentStateNotifier(ref: ref);
});
