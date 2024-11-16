import 'package:flutter/material.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/presentation/routes/app_routes.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';
import 'package:go_router/go_router.dart';

class ProjectItem extends StatelessWidget {
  final Project project;

  const ProjectItem({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Space.h.add(Space.v),
      child: ListTile(
        leading: Container(
          width: 24,
          height: 24,
          // decoration: BoxDecoration(
          //   color: Color(int.parse('0xFF${project.color?.substring(1)}')),
          //   shape: BoxShape.circle,
          // ),
        ),
        title: Text(
          project.name ?? 'Untitled Project',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          '${project.commentCount ?? 0} comments',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: project.isFavorite == true
            ? const Icon(Icons.star, color: Colors.amber)
            : null,
        onTap: () {
          context.pushNamed(
            AppRoute.projectDetails.name,
            pathParameters: {'id': project.id ?? ''},
          );
        },
      ),
    );
  }
}
