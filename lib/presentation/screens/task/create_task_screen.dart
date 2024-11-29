import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/others/task_form_fields.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/task/task_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/task/task_event.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/task/task_state.dart';
import 'package:innoscripta_home_challenge/data/dto/task/task_dto.dart';
import 'package:innoscripta_home_challenge/core/utils/date_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateTaskScreen extends StatefulWidget {
  final Task? task;
  final String projectId;

  const CreateTaskScreen({
    super.key,
    this.task,
    required this.projectId,
  });

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
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
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state.status == TaskStatus.success) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.task == null
              ? AppLocalizations.of(context)!.createNewTask
              : AppLocalizations.of(context)!.editTask),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: Space.all(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                    child: Text(widget.task == null
                        ? AppLocalizations.of(context)!.createTask
                        : AppLocalizations.of(context)!.updateTask),
                  ),
                ],
              ),
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

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        id: widget.task?.id,
        content: StringUtils.cleanText(_titleController.text),
        description: StringUtils.cleanText(_descriptionController.text),
        due: _dueDate != null
            ? Due(datetime: AppDateUtils.formatDate(_dueDate!))
            : null,
        priority: _priority,
        labels: _selectedLabels,
        projectId: widget.projectId,
      );

      if (widget.task == null) {
        context.read<TaskBloc>().add(
              CreateTaskEvent(task.copyWith(parentId: widget.projectId)),
            );
      } else {
        context.read<TaskBloc>().add(UpdateTaskEvent(task));
      }
    }
  }
}
