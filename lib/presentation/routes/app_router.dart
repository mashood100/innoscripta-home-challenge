import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/presentation/routes/app_routes.dart';
import 'package:innoscripta_home_challenge/presentation/screens/language/language_screen.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/project_screen.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/bottom_sheet/add_project_bottom_sheet.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/tasks_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.projects.name,
      builder: (context, state) => const TasksScreen(),
      routes: [
        GoRoute(
          path: 'languages',
          name: AppRoute.languages.name,
          builder: (context, state) => const LanguageScreen(),
        ),
        GoRoute(
          path: 'edit-project',
          name: AppRoute.editProject.name,
          builder: (context, state) {
            final project = state.extra as Project;
            return AddProjectBottomSheet(project: project);
          },
        ),
        GoRoute(
          path: 'add-project',
          name: AppRoute.addProject.name,
          builder: (context, state) => const AddProjectBottomSheet(),
        ),
        // GoRoute(
        //   path: 'project/:id',
        //   name: AppRoute.projectDetails.name,
        //   builder: (context, state) {
        //     final projectId = state.pathParameters['id']!;
        //     return ProjectDetailScreen(projectId: projectId);
        //   },
        // ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Error: ${state.error}'),
    ),
  ),
);
