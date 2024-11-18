import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/task_input_field.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final DateTime? dueDate;
  final int priority;
  final List<String> selectedLabels;
  final Function(DateTime?) onDueDateChanged;
  final Function(int) onPriorityChanged;
  final Function(List<String>) onLabelsChanged;

  const TaskFormFields({
    Key? key,
    required this.titleController,
    required this.descriptionController,
    required this.dueDate,
    required this.priority,
    required this.selectedLabels,
    required this.onDueDateChanged,
    required this.onPriorityChanged,
    required this.onLabelsChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TaskInputField(
          controller: titleController,
          labelText: AppLocalizations.of(context)!.taskTitle,
          hintText: AppLocalizations.of(context)!.enterTaskTitle,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Title is required' : null,
        ),
        Space.y2,
        TaskInputField(
          controller: descriptionController,
          labelText: AppLocalizations.of(context)!.description,
          hintText: AppLocalizations.of(context)!.enterTaskDescription,
          maxLines: 3,
        ),
        Space.y2,
        _buildPrioritySelector(context),
        Space.y2,
        _buildDueDatePicker(context),
        Space.y2,
        _buildLabelsSelector(context),
      ],
    );
  }

  Widget _buildPrioritySelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.priority, style: AppText.titleSmall),
        Space.y1,
        SegmentedButton<int>(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(
              value: 1,
              label: Text(AppLocalizations.of(context)!.normal, style: TextStyle(fontSize: 12.sp)),
            ),
            ButtonSegment(
              value: 2,
              label: Text(AppLocalizations.of(context)!.medium, style: TextStyle(fontSize: 12.sp)),
            ),
            ButtonSegment(
              value: 3,
              label: Text(AppLocalizations.of(context)!.high, style: TextStyle(fontSize: 12.sp)),
            ),
            ButtonSegment(
              value: 4,
              label: Text(AppLocalizations.of(context)!.urgent, style: TextStyle(fontSize: 12.sp)),
            ),
          ],
          selected: {priority},
          onSelectionChanged: (Set<int> newSelection) {
            onPriorityChanged(newSelection.first);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  switch (priority) {
                    case 1:
                      return Colors.green.withOpacity(0.5);
                    case 2:
                      return Colors.blue.withOpacity(0.5);
                    case 3:
                      return Colors.orange.withOpacity(0.5);
                    case 4:
                      return Colors.red.withOpacity(0.5);
                    default:
                      return Colors.grey.withOpacity(0.5);
                  }
                }
                return Colors.transparent;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDueDatePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.dueDate, style: AppText.titleSmall),
        Space.y1,
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            dueDate != null
                ? '${dueDate!.day}/${dueDate!.month}/${dueDate!.year}'
                : AppLocalizations.of(context)!.selectDueDate,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (dueDate != null)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => onDueDateChanged(null),
                ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: dueDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) onDueDateChanged(date);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabelsSelector(BuildContext context) {
    final availableLabels = [
      'todo',
      'in_progress',
      'completed',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.status, style: AppText.titleSmall),
        Space.y1,
        Wrap(
          spacing: 8.r,
          runSpacing: 8.r,
          children: availableLabels.map((label) {
            final isSelected = selectedLabels.contains(label);
            return ChoiceChip(
              label: Text(label),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  onLabelsChanged([label]);
                } else {
                  onLabelsChanged([]);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
