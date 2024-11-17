import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/core/utils/colors_utils.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/task_details_bottom_sheet.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/timer_button.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';
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
      child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => TaskDetailsBottomSheet(task: task),
            );
          },
          child: _buildCardContent(context)),
    );
  }

  Widget _buildCardContent(BuildContext context, {bool isDragging = false}) {
    return Container(
      margin: isDragging ? null : EdgeInsets.only(top: 10.r, bottom: 10.r),
      width: 300.r,
      padding: Space.all(),
      decoration: BoxDecoration(
        boxShadow: isDragging
            ? null
            : const [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 8,
                  color: Color.fromARGB(76, 89, 89, 89),
                ),
              ],
        color: Theme.of(context).cardColor,
        borderRadius: UIProps.radius,
        border: Border.all(
          color: ColorUtility.getPriorityColor(task.priority ?? 1),
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
                  style: AppText.titleMediumBold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Space.x,
              _buildPriorityIndicator(context),
            ],
          ),
          if (task.description != null) ...[
            Text(
              task.description!,
              style: AppText.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
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
                    return TimerButton(
                      task: task,
                    );
                  },
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPriorityIndicator(BuildContext context) {
    final priorityLevel = task.priority ?? 1;
    final color = ColorUtility.getPriorityColor(priorityLevel);
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
