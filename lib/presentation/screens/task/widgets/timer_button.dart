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
              notifier.startTimer(task);
            }
          },
        ),
        Text(
          formatDuration(currentDuration),
        ),
        IconButton(
          icon: const Icon(Icons.restart_alt),
          onPressed: () => _showResetConfirmation(context, ref),
        ),
      ],
    );
  }

  Future<void> _showResetConfirmation(BuildContext context, WidgetRef ref) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Timer'),
          content: const Text('Are you sure you want to reset the timer? You will lose your progress.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref.read(timerProvider.notifier).resetTimer(task.id!);
                Navigator.of(context).pop();
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  String formatDuration(int seconds) {
    final hours = (seconds / 3600).floor();
    final minutes = ((seconds % 3600) / 60).floor();
    final remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}