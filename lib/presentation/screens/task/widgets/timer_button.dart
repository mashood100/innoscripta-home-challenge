import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';

class TimerButton extends ConsumerWidget {
  final Task task;

  const TimerButton({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerProvider);
    final taskTimer = timerState.taskTimers[task.id];

    final currentDuration = taskTimer?.currentDuration ?? 0;
    final isRunning = ref.watch(timerProvider.notifier).isTimerRunning(task.id!);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            final notifier = ref.read(timerProvider.notifier);
            if (isRunning) {
              notifier.pauseTimer(task.id!);
            } else {
              notifier.startTimer(
                task,
              );
            }
          },
        ),
        Text(
          formatDuration(currentDuration),
        ),
      ],
    );
  }

  String formatDuration(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
