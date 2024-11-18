import 'package:shared_preferences/shared_preferences.dart';
import 'package:innoscripta_home_challenge/domain/repository/task/task_storage_repository.dart';

class TaskStorageRepositoryImpl implements TaskStorageRepository {
  static const String _closedTasksKey = 'closed_tasks';
  final SharedPreferences _prefs;

  TaskStorageRepositoryImpl(this._prefs);

  @override
  Future<void> saveClosedTasks(List<String> tasks) async {
    await _prefs.setStringList(_closedTasksKey, tasks);
  }

  @override
  Future<List<String>?> getClosedTasks() async {
    return _prefs.getStringList(_closedTasksKey);
  }

  @override
  Future<void> clearClosedTasks() async {
    await _prefs.remove(_closedTasksKey);
  }
}