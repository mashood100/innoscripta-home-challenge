import 'package:flutter/material.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/create_task_screen.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/timer_button.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskCard extends ConsumerWidget {
  final Task task;

  const TaskCard({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LongPressDraggable<Task>(
      data: task,
      feedback: Material(
        elevation: 4,
        borderRadius: UIProps.radius,
        child: SizedBox(
          width: 200,
          child: _buildCardContent(context, isDragging: true),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _buildCardContent(context),
      ),
      child: _buildCardContent(context),
    );
  }

  Widget _buildCardContent(BuildContext context, {bool isDragging = false}) {
    return Container(
      width: 200,
      height: 180,
      padding: Space.all(),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: UIProps.radius,
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  task.content ?? 'Untitled Task',
                  style: AppText.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _buildPriorityIndicator(context),
              IconButton(
                  onPressed: () async {
                    await showMaterialModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => CreateTaskScreen(
                        task: task,
                      ),
                    );
                  },
                  icon: Icon(Icons.edit))
            ],
          ),
          Space.y1,
          if (task.description != null) ...[
            Text(
              task.description!,
              style: AppText.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Space.y1,
          ],
          const SizedBox(height: 8),
          _buildLabels(context),
          if (task.due != null) ...[
            Space.y1,
            _buildDueDate(context),
          ],
          if (task.labels!.contains('in_progress')) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer(
                  builder: (context, ref, _) {
                    // final timerState = ref.watch(timerProvider);
                    // final isRunning = timerState.runningTaskId == task.id;

                    return Row(
                      children: [
                        TimerButton(
                          task: task,
                        )
                        // IconButton(
                        //   icon:
                        //       Icon(isRunning ? Icons.pause : Icons.play_arrow),
                        //   onPressed: () {
                        //     final notifier = ref.read(timerProvider.notifier);
                        //     if (isRunning) {
                        //       notifier.stopTimer();
                        //     } else {
                        //       notifier.startTimer(task);
                        //     }
                        //   },
                        // ),
                        // Text(
                        //   ref.read(timerProvider.notifier).getFormattedDuration(
                        //         isRunning
                        //             ? timerState.currentDuration
                        //             : (task.duration ?? 0),
                        //       ),
                        // ),
                      ],
                    );
                  },
                ),
              ],
            ),
            Space.y1,
          ],
        ],
      ),
    );
  }

  Widget _buildPriorityIndicator(BuildContext context) {
    final priorityLevel = task.priority ?? 1;
    final color = _getPriorityColor(priorityLevel);
    final label = _getPriorityLabel(priorityLevel);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: AppText.labelSmall.copyWith(color: color),
      ),
    );
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 4:
        return Colors.red;
      case 3:
        return Colors.orange;
      case 2:
        return Colors.yellow.shade800;
      default:
        return Colors.green;
    }
  }

  String _getPriorityLabel(int priority) {
    switch (priority) {
      case 4:
        return 'Urgent';
      case 3:
        return 'High';
      case 2:
        return 'Medium';
      default:
        return 'Normal';
    }
  }

  Widget _buildLabels(BuildContext context) {
    final displayLabels = task.labels
            ?.where(
              (label) => !['todo', 'in_progress', 'completed'].contains(label),
            )
            .toList() ??
        [];

    if (displayLabels.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: displayLabels.map((label) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            style: AppText.labelSmall.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDueDate(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          size: 16,
          color: Theme.of(context).hintColor,
        ),
        Space.x,
        Text(
          task.due.toString(),
          style: AppText.labelSmall.copyWith(
            color: Theme.of(context).hintColor,
          ),
        ),
      ],
    );
  }
}
