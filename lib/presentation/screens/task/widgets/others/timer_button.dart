import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        Container(
          decoration: BoxDecoration(
            color: isRunning 
              ? Colors.orange.withOpacity(0.1)
              : Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(
              isRunning ? Icons.pause : Icons.play_arrow,
              color: isRunning ? Colors.orange : Colors.green,
            ),
            onPressed: () {
              final notifier = ref.read(timerProvider.notifier);
              if (isRunning) {
                notifier.pauseTimer(task.id!);
              } else {
                notifier.startTimer(task);
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            formatDuration(currentDuration),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.restart_alt,
              color: Colors.red,
            ),
            onPressed: () => _showResetConfirmation(context, ref),
          ),
        ),
      ],
    );
  }

  Future<void> _showResetConfirmation(BuildContext context, WidgetRef ref) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.resetTimer),
          content: Text(AppLocalizations.of(context)!.resetTimerConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                ref.read(timerProvider.notifier).resetTimer(task.id!);
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.reset),
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
