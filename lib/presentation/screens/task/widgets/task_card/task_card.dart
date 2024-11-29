import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/core/utils/colors_utils.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/task/task_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/task/task_event.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/others/task_details_bottom_sheet.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/others/timer_button.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<Task>(
      data: task,
      feedback: Material(
        elevation: 4,
        borderRadius: UIProps.radius,
        child: SizedBox(
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
        child: _buildCardContent(context),
      ),
    );
  }

  // ================================ Other Widget ==========================

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
              _getTaskIcon(task.labels?.first ?? 'todo'),
              Space.x,
              Expanded(
                child: Text(
                  task.content ?? AppLocalizations.of(context)!.untitledTask,
                  style: AppText.titleMediumBold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (task.description != "") ...[
            Space.y,
            Text(
              task.description ?? "",
              style: AppText.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (task.due != null) ...[
            Space.y1,
          ],
          Space.y,
          Row(
            children: [
              Text(
                "${AppLocalizations.of(context)!.priority}: ",
                style: AppText.labelMediumSemiBold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              _buildPriorityIndicator(context),
            ],
          ),
          if (task.labels!.contains('in_progress')) ...[
            Space.y1,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TimerButton(
                  task: task,
                )
              ],
            ),
          ],
          if (task.labels!.contains('completed')) ...[
            Space.y1,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.r),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      context.read<TaskBloc>().add(CloseTaskEvent(task));
                    },
                    icon: Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 20.r,
                    ),
                    label: Text(
                      "Mark as completed",
                      style: AppText.labelMedium.copyWith(
                        color: Colors.green,
                      ),
                    ),
                  ),
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

  Widget _getTaskIcon(String label) {
    switch (label) {
      case 'completed':
        return Image.asset('assets/done.png', width: 18.r, height: 18.r);
      case 'in_progress':
        return Image.asset('assets/inprogress.png', width: 18.r, height: 18.r);
      case 'todo':
        return Image.asset('assets/todo.png', width: 18.r, height: 18.r);
      default:
        return Image.asset('assets/todo.png', width: 18.r, height: 18.r);
    }
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
