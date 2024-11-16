import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';

class AddProjectBottomSheet extends ConsumerStatefulWidget {
  final Project? project;

  const AddProjectBottomSheet({
    Key? key,
    this.project,
  }) : super(key: key);

  @override
  ConsumerState<AddProjectBottomSheet> createState() =>
      _AddProjectBottomSheetState();
}

class _AddProjectBottomSheetState extends ConsumerState<AddProjectBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  String _selectedColor = 'red';

  final List<String> _colors = ['red', 'yellow', 'green', 'orange', 'blue'];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.project?.name ?? '');
    if (widget.project != null) {
      _selectedColor = widget.project!.color ?? "green";
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectStateNotifier = ref.read(projectStateProvider.notifier);
    return Container(
      padding: EdgeInsets.only(
          // bottom: MediaQuery.of(context).viewInsets.bottom,
          // left: AppSpacing.l,
          // right: AppSpacing.l,
          // top: AppSpacing.l,
          ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _BuildHeader(isEditing: widget.project != null),
            Space.x1,
            _BuildTitleField(controller: _titleController),
            Space.x1,
            _BuildColorDropdown(
              selectedColor: _selectedColor,
              colors: _colors,
              onColorChanged: (value) {
                setState(() {
                  _selectedColor = value!;
                });
              },
            ),
            Space.x1,
            _BuildSubmitButton(
              isEditing: widget.project != null,
              onSubmit: () {
                if (_formKey.currentState!.validate()) {
                  if (widget.project != null) {
                    // Update existing project
                    projectStateNotifier.updateProject(
                      widget.project!.copyWith(
                        name: _titleController.text,
                        color: _selectedColor,
                      ),
                    );
                  } else {
                    // Create new project
                    projectStateNotifier.createProject(
                      Project(
                        name: _titleController.text,
                        color: _selectedColor,
                      ),
                    );
                  }
                  Navigator.pop(context);
                }
              },
            ),
            Space.x1,
          ],
        ),
      ),
    );
  }
}

class _BuildHeader extends StatelessWidget {
  final bool isEditing;

  const _BuildHeader({required this.isEditing});

  @override
  Widget build(BuildContext context) {
    return Text(
      isEditing ? 'Edit Project' : 'Add New Project',
      style: AppText.titleLarge,
      textAlign: TextAlign.center,
    );
  }
}

class _BuildTitleField extends StatelessWidget {
  final TextEditingController controller;

  const _BuildTitleField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Project Title',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a title';
        }
        return null;
      },
    );
  }
}

class _BuildColorDropdown extends StatelessWidget {
  final String selectedColor;
  final List<String> colors;
  final Function(String?) onColorChanged;

  const _BuildColorDropdown({
    required this.selectedColor,
    required this.colors,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedColor,
      decoration: const InputDecoration(
        labelText: 'Project Color',
        border: OutlineInputBorder(),
      ),
      items: colors.map((color) {
        return DropdownMenuItem(
          value: color,
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: _getColor(color),
                  shape: BoxShape.circle,
                ),
              ),
              Space.x1,
              Text(color.toUpperCase()),
            ],
          ),
        );
      }).toList(),
      onChanged: onColorChanged,
    );
  }

  Color _getColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.yellow;
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.orange;
      case 'blue':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}

class _BuildSubmitButton extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onSubmit;

  const _BuildSubmitButton({
    required this.isEditing,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSubmit,
      child: Text(isEditing ? 'Update Project' : 'Create Project'),
    );
  }
}
