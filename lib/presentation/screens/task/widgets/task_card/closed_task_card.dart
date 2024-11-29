import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/core/utils/colors_utils.dart';
import 'package:innoscripta_home_challenge/core/utils/date_utils.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/timer/timer_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/timer/timer_state.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClosedTaskCard extends StatefulWidget {
  final Task task;

  const ClosedTaskCard({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<ClosedTaskCard> createState() => _ClosedTaskCardState();
}

class _ClosedTaskCardState extends State<ClosedTaskCard> {
  bool isExpanded = false;

  String _formatDuration(int seconds) {
    final hours = (seconds / 3600).floor();
    final minutes = ((seconds % 3600) / 60).floor();
    final remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, timerState) {
        final taskTimer = timerState.taskTimers[widget.task.id];
        final timeSpent = taskTimer?.currentDuration ?? 0;

        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
          child: InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: Space.all(),
                  child: Row(
                    children: [
                      Image.asset('assets/done.png', width: 40.r, height: 40.r),
                      Space.x,
                      Expanded(
                        child: Text(
                          widget.task.content ??
                              AppLocalizations.of(context)!.untitledTask,
                          style: AppText.titleMediumBold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: Theme.of(context).hintColor,
                      ),
                    ],
                  ),
                ),
                if (isExpanded) ...[
                  const Divider(),
                  Padding(
                    padding: Space.all(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.task.description?.isNotEmpty ?? false) ...[
                          Text(
                            AppLocalizations.of(context)!.description,
                            style: AppText.titleSmallSemiBold,
                          ),
                          Space.y,
                          Text(
                            widget.task.description ?? '',
                            style: AppText.bodyMedium,
                          ),
                          Space.y2,
                        ],
                        _buildDetailsSection(context, timeSpent),
                        Space.y2,
                        _buildPrioritySection(context),
                        if (widget.task.duration != null) ...[
                          Space.y2,
                          _buildDurationSection(context),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailsSection(BuildContext context, int timeSpent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.taskDetails,
          style: AppText.titleSmallSemiBold,
        ),
        Space.y,
        Container(
          padding: Space.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildDetailRow(
                AppLocalizations.of(context)!.taskId,
                widget.task.id ?? 'N/A',
              ),
              const Divider(height: 16),
              _buildDetailRow(
                AppLocalizations.of(context)!.created,
                AppDateUtils.formatDate(widget.task.createdAt),
              ),
              const Divider(height: 16),
              _buildDetailRow(
                'Time Spent',
                _formatDuration(timeSpent),
              ),
              if (widget.task.due != null) ...[
                const Divider(height: 16),
                _buildDetailRow('Due Date', widget.task.due.toString()),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrioritySection(BuildContext context) {
    final priorityLevel = widget.task.priority ?? 1;
    final color = ColorUtility.getPriorityColor(priorityLevel);
    final label = _getPriorityLabel(priorityLevel);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.priority,
          style: AppText.titleSmallSemiBold,
        ),
        Space.y,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            style: AppText.labelMedium.copyWith(color: color),
          ),
        ),
      ],
    );
  }

  Widget _buildDurationSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.timeSpent,
          style: AppText.titleSmallSemiBold,
        ),
        Space.y,
        Text(
          '${widget.task.duration!.amount} ${widget.task.duration!.unit}',
          style: AppText.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppText.bodyMedium),
        Text(value, style: AppText.bodyMedium),
      ],
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
}
