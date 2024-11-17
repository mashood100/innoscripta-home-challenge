import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
      padding: Space.all(),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          Space.y2,
          _buildContent(context),
          Space.y2,
          _buildActions(context, ref),
          Space.y2,
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            task.content ?? 'Untitled Task',
            style: AppText.titleLarge,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (task.description != null && task.description!.isNotEmpty) ...[
          Text('Description', style: AppText.titleMedium),
          Space.y1,
          Text(task.description!, style: AppText.bodyMedium),
          Space.y2,
        ],
        Row(
          children: [
            _buildPriorityChip(context),
            Space.x1,
            if (task.due != null) _buildDueDate(context),
          ],
        ),
        Space.y2,
        if (task.labels != null && task.labels!.isNotEmpty) ...[
          Text('Labels', style: AppText.titleMedium),
          Space.y1,
          _buildLabels(context),
        ],
        if (task.labels!.contains('in_progress')) ...[
          Space.y2,
          Text('Timer', style: AppText.titleMedium),
          Space.y1,
          Center(child: TimerButton(task: task)),
        ],
      ],
    );
  }

  Widget _buildPriorityChip(BuildContext context) {
    final priorityColors = {
      1: Colors.green,
      2: Colors.yellow.shade800,
      3: Colors.orange,
      4: Colors.red,
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

  Widget _buildDueDate(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today,
            size: 16,
            color: Theme.of(context).primaryColor,
          ),
          Space.x,
          Text(
            task.due.toString(),
            style: AppText.labelMedium.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
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
            ),
            ElevatedButton.icon(
              onPressed: () => _showDeleteConfirmation(context, ref),
              icon: const Icon(Icons.delete),
              label: const Text('Delete'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
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
            ),
          ),
        ),
      ],
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
}
