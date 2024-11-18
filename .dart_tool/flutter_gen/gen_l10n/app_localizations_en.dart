import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World';

  @override
  String welcome(String appName) {
    return 'Welcome to $appName';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String get projectScreenTitle => 'Project';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get deleteProject => 'Delete Project';

  @override
  String get deleteProjectConfirmation => 'Are you sure you want to delete this project?';

  @override
  String get cancel => 'Cancel';

  @override
  String get untitledProject => 'Untitled Project';

  @override
  String get tapToViewTasks => 'Tap to view task in this project';

  @override
  String get giveProjectName => 'Give your project a name:';

  @override
  String get pleaseEnterTitle => 'Please enter a title';

  @override
  String get noProjectsFound => 'No Projects Found';

  @override
  String get createProjectToStart => 'Create a new project to get started';

  @override
  String get projectTitle => 'Project Title';

  @override
  String get enterProjectName => 'Enter project name';

  @override
  String get projectPreviewLabel => 'How it will look:';

  @override
  String get editProject => 'Edit Project';

  @override
  String get createNewProject => 'Create New Project';

  @override
  String get updateProject => 'Update Project';

  @override
  String get createProject => 'Create Project';

  @override
  String get favoriteProjects => 'Favorite Projects';

  @override
  String get noFavoriteProjects => 'No favorite projects yet';

  @override
  String get createNewProjectTooltip => 'Create New Project';

  @override
  String get createNewTask => 'Create New Task';

  @override
  String get editTask => 'Edit Task';

  @override
  String get taskTitle => 'Task Title';

  @override
  String get enterTaskTitle => 'Enter task title';

  @override
  String get description => 'Description';

  @override
  String get enterTaskDescription => 'Enter task description';

  @override
  String get priority => 'Priority';

  @override
  String get normal => 'Normal';

  @override
  String get medium => 'Medium';

  @override
  String get high => 'High';

  @override
  String get urgent => 'Urgent';

  @override
  String get dueDate => 'Due Date';

  @override
  String get selectDueDate => 'Select due date';

  @override
  String get status => 'Status:';

  @override
  String get createTask => 'Create Task';

  @override
  String get updateTask => 'Update Task';

  @override
  String get deleteTask => 'Delete Task';

  @override
  String get deleteTaskConfirmation => 'Are you sure you want to delete this task?';

  @override
  String get noTodoTasks => 'No todo tasks';

  @override
  String get noInProgressTasks => 'No in progress tasks';

  @override
  String get noCompletedTasks => 'No completed tasks';

  @override
  String get resetTimer => 'Reset Timer';

  @override
  String get resetTimerConfirmation => 'Are you sure you want to reset the timer? You will lose your progress.';

  @override
  String get reset => 'Reset';

  @override
  String get untitledTask => 'Untitled Task';

  @override
  String get taskDetails => 'Task Details';

  @override
  String get taskId => 'Task ID';

  @override
  String get created => 'Created';

  @override
  String get timeSpent => 'Time Spent';

  @override
  String get timer => 'Timer';

  @override
  String get comments => 'Comments';

  @override
  String get viewComments => 'View Comments';

  @override
  String get addComment => 'Add a comment...';

  @override
  String get updateComment => 'Update Comment';

  @override
  String get editComment => 'Edit Comment';

  @override
  String get deleteComment => 'Delete Comment';

  @override
  String get deleteCommentConfirmation => 'Are you sure you want to delete this comment?';

  @override
  String get noComments => 'No comments yet';

  @override
  String get commentUpdated => 'Comment updated successfully';

  @override
  String get commentDeleted => 'Comment deleted successfully';

  @override
  String get commentAdded => 'Comment added successfully';
}
