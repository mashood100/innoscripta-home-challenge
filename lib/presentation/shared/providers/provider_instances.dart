// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:innoscripta_home_challenge/main.dart';
// import 'package:innoscripta_home_challenge/presentation/provider/project/project_state.dart';
// import 'package:innoscripta_home_challenge/presentation/provider/project/project_state_notifier.dart';
// import 'package:innoscripta_home_challenge/presentation/provider/task/task_state.dart';
// import 'package:innoscripta_home_challenge/presentation/provider/task/task_state_notifier.dart';
// import 'package:innoscripta_home_challenge/presentation/provider/timer/timer_notifier.dart';
// import 'package:innoscripta_home_challenge/presentation/provider/timer/timer_state.dart';
// import 'package:innoscripta_home_challenge/presentation/provider/theme/theme_provider.dart';
// import 'package:innoscripta_home_challenge/presentation/provider/comment/comment_state_notifier.dart';
// import 'package:innoscripta_home_challenge/presentation/provider/comment/comment_state.dart';
// import 'package:innoscripta_home_challenge/data/repository/task/task_storage_repository_impl.dart';
// import 'package:innoscripta_home_challenge/domain/use_cases/task/task_storage_use_cases.dart';

// final projectStateProvider =
//     StateNotifierProvider<ProjectStateNotifier, ProjectState>(
//   (ref) => ProjectStateNotifier(

//   ),
// );


// final taskStorageProvider = Provider<TaskStorageUseCases>((ref) {
//   return TaskStorageUseCases(
//     repository: TaskStorageRepositoryImpl(
//       localStorage,
//     ),
//   );
// });

// final taskStateProvider =
//     StateNotifierProvider<TaskStateNotifier, TaskState>((ref) {
//   return TaskStateNotifier(

//     taskStorageUseCases: ref.watch(taskStorageProvider),
//   );
// });

// final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
//   return ThemeNotifier();
// });

// final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) {
//   return TimerNotifier(
//     ref: ref,
//   );
// });

// final commentStateProvider =
//     StateNotifierProvider<CommentStateNotifier, CommentState>((ref) {
//   return CommentStateNotifier();
// });
// final localeProvider = StateProvider<Locale>((ref) => const Locale('en', 'US'));
