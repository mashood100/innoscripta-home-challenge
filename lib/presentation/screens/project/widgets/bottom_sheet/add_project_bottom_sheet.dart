import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';
import 'project_color_selector.dart';
import 'project_name_input.dart';
import 'project_preview.dart';
import 'sheet_header.dart';
import 'submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddProjectBottomSheet extends ConsumerStatefulWidget {
  final Project? project;

  const AddProjectBottomSheet({
    super.key,
    this.project,
  });

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
    _titleController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectStateNotifier = ref.read(projectStateProvider.notifier);

    return Material(
      child: SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SheetHeader(isEditing: widget.project != null),
              Space.y1,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(AppLocalizations.of(context)!.giveProjectName,
                        style: AppText.bodyMedium),
                    Space.y1,
                    ProjectNameInput(
                      controller: _titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                       return AppLocalizations.of(context)!.pleaseEnterTitle;
                        }
                        return null;
                      },
                    ),
                    Space.y1,
                    ProjectColorSelector(
                      selectedColor: _selectedColor,
                      onColorSelected: (color) {
                        setState(() {
                          _selectedColor = color;
                        });
                      },
                      colors: _colors,
                    ),
                    Space.y1,
                    ProjectPreview(
                      project: Project(
                        id: widget.project?.id,
                        name: _titleController.text.isEmpty
                            ? AppLocalizations.of(context)!.untitledProject
                            : _titleController.text,
                        color: _selectedColor,
                        isFavorite: widget.project?.isFavorite ?? false,
                      ),
                    ),
                    Space.yf(40),
                    SubmitButton(
                      isEditing: widget.project != null,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (widget.project != null) {
                            projectStateNotifier.updateProject(
                              widget.project!.copyWith(
                                name: _titleController.text,
                                color: _selectedColor,
                              ),
                            );
                          } else {
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
                    Space.yf(40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
