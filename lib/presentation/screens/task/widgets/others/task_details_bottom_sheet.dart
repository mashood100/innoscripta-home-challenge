import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innoscripta_home_challenge/core/utils/date_utils.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/presentation/routes/app_routes.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/others/timer_button.dart';

class TaskDetailsBottomSheet extends ConsumerWidget {
  final Task task;

  const TaskDetailsBottomSheet({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: Space.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16, top: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            _buildHeader(context),
            Space.y2,
            _buildContent(context),
            Space.y2,
            _buildActions(context, ref),
            Space.y2,
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              task.content ?? 'Untitled Task',
              style: AppText.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            style: IconButton.styleFrom(
              backgroundColor: Colors.grey.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description Section
        Visibility(
          visible: task.description != null && task.description!.isNotEmpty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Description', style: AppText.titleMediumSemiBold),
              Space.y1,
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxHeight: 200),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    task.description ?? '',
                    style: AppText.bodyMedium,
                  ),
                ),
              ),
              Space.y2,
            ],
          ),
        ),

        // Priority Section
        Text('Priority:', style: AppText.titleMediumSemiBold),
        Space.y1,
        _buildPriorityChip(context),
        Space.y2,

        // Task Details Section
        Text('Task Details', style: AppText.titleMediumSemiBold),
        Space.y1,
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildDetailRow('Task ID', task.id ?? 'N/A'),
              const Divider(height: 16),
              _buildDetailRow(
                  'Created', AppDateUtils.formatDate(task.createdAt)),
              if (task.due != null) ...[
                const Divider(height: 16),
                _buildDetailRow('Due Date', task.due.toString()),
              ],
              const Divider(height: 16),
              Consumer(
                builder: (context, ref, child) {
                  final timerState = ref.watch(timerProvider);
                  final taskTimer = timerState.taskTimers[task.id];
                  final currentDuration = taskTimer?.currentDuration ?? 0;
                  return _buildDetailRow(
                    'Time Spent',
                    _formatDuration(currentDuration),
                  );
                },
              ),
            ],
          ),
        ),
        Space.y2,

        // Timer Section (existing code)
        if (task.labels!.contains('in_progress')) ...[
          Space.y2,
          Text('Timer', style: AppText.titleMediumSemiBold),
          Space.y1,
          Center(child: TimerButton(task: task)),
        ],
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppText.bodyMedium.copyWith()),
        Text(value, style: AppText.bodyMedium),
      ],
    );
  }

  Widget _buildPriorityChip(BuildContext context) {
    final priorityColors = {
      1: const Color(0xFF4CAF50),
      2: const Color(0xFFFFC107),
      3: const Color(0xFFFF9800),
      4: const Color(0xFFF44336),
    };
    final priorityLabels = {
      1: 'Normal',
      2: 'Medium',
      3: 'High',
      4: 'Urgent',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: priorityColors[task.priority]?.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        priorityLabels[task.priority] ?? 'Normal',
        style: AppText.labelMedium.copyWith(
          color: priorityColors[task.priority],
        ),
      ),
    );
  }

  Widget _buildLabels(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: task.labels!.map((label) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            label,
            style: AppText.labelMedium.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    context.pushNamed(
                      AppRoute.createTask.name,
                      pathParameters: {'projectId': task.projectId!},
                      extra: task,
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Space.x2,
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showDeleteConfirmation(context, ref),
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.onError,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Space.y2,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                context.pushNamed(
                  AppRoute.comments.name,
                  pathParameters: {
                    'projectId': task.projectId!,
                    'taskId': task.id!,
                  },
                );
              },
              icon: const Icon(Icons.comment),
              label: const Text('View Comments'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(taskStateProvider.notifier).deleteTask(task);
              if (context.mounted) {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Close bottom sheet
              }
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(int seconds) {
    final hours = (seconds / 3600).floor();
    final minutes = ((seconds % 3600) / 60).floor();
    return '${hours}h ${minutes}m';
  }
}
