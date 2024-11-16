
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/task_form_fields.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';
import 'package:innoscripta_home_challenge/data/dto/task/task_dto.dart';
import 'package:innoscripta_home_challenge/core/utils/date_utils.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  final Task? task;

  const CreateTaskScreen({Key? key, this.task, required this.projectId})
      : super(key: key);
  final String projectId;
  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _dueDate;
  int _priority = 1;
  List<String> _selectedLabels = ['todo'];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.content);
    _descriptionController =
        TextEditingController(text: widget.task?.description);
    if (widget.task != null) {
      _dueDate = AppDateUtils.parseDate(widget.task?.due?.datetime);
      _priority = widget.task?.priority ?? 1;
      _selectedLabels = widget.task?.labels?.toList() ?? ['todo'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: Space.all(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context),
                Space.y2,
                TaskFormFields(
                  titleController: _titleController,
                  descriptionController: _descriptionController,
                  dueDate: _dueDate,
                  priority: _priority,
                  selectedLabels: _selectedLabels,
                  onDueDateChanged: (date) => setState(() => _dueDate = date),
                  onPriorityChanged: (value) =>
                      setState(() => _priority = value),
                  onLabelsChanged: (labels) =>
                      setState(() => _selectedLabels = labels),
                ),
                Space.y2,
                ElevatedButton(
                  onPressed: _saveTask,
                  child:
                      Text(widget.task == null ? 'Create Task' : 'Update Task'),
                ),
                Space.y2,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveTask() async {
    if (_formKey.currentState!.validate()) {
      final taskNotifier = ref.read(taskStateProvider.notifier);
      final task = Task(
        id: widget.task?.id,
        content: _titleController.text,
        description: _descriptionController.text,
        due: _dueDate != null
            ? Due(datetime: AppDateUtils.formatDate(_dueDate!))
            : null,
        priority: _priority,
        labels: _selectedLabels,
        projectId: widget.projectId,
      );

      if (widget.task == null) {
        await taskNotifier
            .createTask(task.copyWith(parentId: widget.projectId));
      } else {
        await taskNotifier.updateTask(task);
      }

      if (mounted) Navigator.pop(context);
    }
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.task == null ? 'Create New Task' : 'Edit Task',
          style: AppText.titleLarge,
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
