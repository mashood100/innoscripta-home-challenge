import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';

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
        TextFormField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: 'Task Title',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a title';
            }
            return null;
          },
        ),
        Space.y2,
        TextFormField(
          controller: descriptionController,
          decoration: const InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(),
          ),
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
        Text('Priority', style: AppText.titleSmall),
        Space.y1,
        SegmentedButton<int>(
          segments: const [
            ButtonSegment(value: 1, label: Text('Normal')),
            ButtonSegment(value: 2, label: Text('Medium')),
            ButtonSegment(value: 3, label: Text('High')),
            ButtonSegment(value: 4, label: Text('Urgent')),
          ],
          selected: {priority},
          onSelectionChanged: (Set<int> newSelection) {
            onPriorityChanged(newSelection.first);
          },
        ),
      ],
    );
  }

  Widget _buildDueDatePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Due Date', style: AppText.titleSmall),
        Space.y1,
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            dueDate != null
                ? '${dueDate!.day}/${dueDate!.month}/${dueDate!.year}'
                : 'Select due date',
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
        Text('Labels', style: AppText.titleSmall),
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
