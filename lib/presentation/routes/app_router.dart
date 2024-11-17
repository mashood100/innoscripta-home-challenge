import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/presentation/routes/app_routes.dart';
import 'package:innoscripta_home_challenge/presentation/screens/language/language_screen.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/project_screen.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/bottom_sheet/add_project_bottom_sheet.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/tasks_screen.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/create_task_screen.dart';
import 'package:innoscripta_home_challenge/presentation/screens/comment/comment_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.projects.name,
      builder: (context, state) => const ProjectScreen(),
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
        GoRoute(
          path: 'task-screen/:id',
          name: AppRoute.projectDetails.name,
          builder: (context, state) {
            final projectId = state.pathParameters['id']!;
            return TasksScreen(projectID: projectId);
          },
        ),
        GoRoute(
          path: 'create-task/:projectId',
          name: AppRoute.createTask.name,
          builder: (context, state) {
            final projectId = state.pathParameters['projectId']!;
            final task = state.extra as Task?;
            return CreateTaskScreen(
              projectId: projectId,
              task: task,
            );
          },
        ),
        GoRoute(
          path: 'comments/:projectId/:taskId',
          name: AppRoute.comments.name,
          builder: (context, state) => CommentScreen(
            projectId: state.pathParameters['projectId']!,
            taskId: state.pathParameters['taskId']!,
          ),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Error: ${state.error}'),
    ),
  ),
);
