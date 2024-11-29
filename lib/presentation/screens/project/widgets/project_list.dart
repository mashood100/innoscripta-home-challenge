import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/project/project_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/project/project_event.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/bottom_sheet/add_project_bottom_sheet.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/project_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProjectList extends StatelessWidget {
  final List<Project> projects;

  const ProjectList({
    super.key,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Slidable(
          key: ValueKey(projects[index].id),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  _handleEdit(context, projects[index]);
                },
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.blue,
                icon: Icons.edit,
                label: AppLocalizations.of(context)!.edit,
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  _handleDelete(context, projects[index]);
                },
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.red,
                icon: Icons.delete,
                label: AppLocalizations.of(context)!.delete,
              ),
            ],
          ),
          child: ProjectItem(
            project: projects[index],
            isPreview: false,
          ),
        ),
        childCount: projects.length,
      ),
    );
  }

  void _handleEdit(BuildContext context, Project project) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddProjectBottomSheet(project: project),
    );
  }

  void _handleDelete(BuildContext context, Project project) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteProject),
        content: Text(AppLocalizations.of(context)!.deleteProjectConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ProjectBloc>().add(DeleteProjectEvent(project.id!));
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      ),
    );
  }
}
