import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/core/utils/colors_utils.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/project/project_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/project/project_event.dart';
import 'package:innoscripta_home_challenge/presentation/routes/app_routes.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProjectItem extends StatelessWidget {
  final Project project;
  final bool isPreview;

  const ProjectItem({
    super.key,
    required this.project,
    required this.isPreview,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Space.h.add(Space.v),
      child: InkWell(
        onTap: () {
          if (isPreview) return;
          context.pushNamed(
            AppRoute.projectDetails.name,
            pathParameters: {'projectId': project.id.toString()},
            extra: project,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorUtility.getColorFromString(project.color!),
              width: 2,
            ),
            color: ColorUtility.getColorFromString(project.color!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        project.name ?? AppLocalizations.of(context)!.untitledProject,
                        style: AppText.headlineMediumSemiBold.cl(Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.tapToViewTasks,
                        style: AppText.bodySmall.cl(Colors.white),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        project.isFavorite ? Icons.star : Icons.star_border,
                        color: project.isFavorite ? Colors.amber : null,
                      ),
                      onPressed: () {
                        context.read<ProjectBloc>().add(
                          UpdateProjectEvent(
                            project.copyWith(isFavorite: !project.isFavorite),
                          ),
                        );
                      },
                    ),
                    Icon(
                      size: 40.r,
                      Icons.chevron_right,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
