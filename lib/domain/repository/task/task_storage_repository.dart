abstract class TaskStorageRepository {
  Future<void> saveClosedTasks(List<String> tasks);
  Future<List<String>?> getClosedTasks();
  Future<void> clearClosedTasks();
}