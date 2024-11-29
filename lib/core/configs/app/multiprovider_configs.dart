import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_home_challenge/core/configs/app/main_app.dart';
import 'package:innoscripta_home_challenge/data/source/network/project/projects_api_service.dart';
import 'package:innoscripta_home_challenge/data/repository/comment/comments_repository_impl.dart';
import 'package:innoscripta_home_challenge/data/repository/project/projects_repository_impl.dart';
import 'package:innoscripta_home_challenge/data/repository/task/task_storage_repository_impl.dart';
import 'package:innoscripta_home_challenge/data/repository/task/tasks_repository_impl.dart';
import 'package:innoscripta_home_challenge/data/source/network/comment/comments_api_service.dart';
import 'package:innoscripta_home_challenge/data/source/network/task/tasks_api_service.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/comment/comments_use_cases.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/project/projects_use_cases.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/task/task_storage_use_cases.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/task/tasks_use_cases.dart';
import 'package:innoscripta_home_challenge/main.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/comment/comment_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/language/language_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/project/project_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/task/task_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/theme/theme_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/timer/timer_bloc.dart';

// ================== Initialize repositories ====================================
final projectRepository = ProjectsRepositoryImpl(api: ProjectsApiService());
final taskRepository = TasksRepositoryImpl(api: TasksApiService());
final commentRepository = CommentsRepositoryImpl(api: CommentsApiService());
final taskStorageRepository = TaskStorageRepositoryImpl(
  localStorage,
);
// ==================  Use Cases with their required repositories====================================
final projectsUseCases = ProjectsUseCases(repository: projectRepository);
final tasksUseCases = TasksUseCases(repository: taskRepository);
final taskStorageUseCases =
    TaskStorageUseCases(repository: taskStorageRepository);
final commentsUseCases = CommentsUseCases(repository: commentRepository);

// ==================  Bloc Provider ====================================

var blocApplication = MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => ProjectBloc(
        projectUseCase: projectsUseCases,
      ),
    ),
    BlocProvider(
      create: (context) => TaskBloc(
        taskUseCase: tasksUseCases,
        taskStorageUseCases: taskStorageUseCases,
      ),
    ),
    BlocProvider(
      create: (context) => CommentBloc(
        commentUseCase: commentsUseCases,
      ),
    ),
    BlocProvider(
      create: (context) => LanguageBloc(),
    ),
    BlocProvider(
      create: (context) => ThemeBloc(),
    ),
    BlocProvider(
      create: (context) => TimerBloc(
        taskBloc: context.read<TaskBloc>(),
      ),
    ),
  ],
  child: const HomeChallenge(),
);
