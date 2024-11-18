import 'dart:convert';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/domain/repository/task/task_storage_repository.dart';
import 'package:innoscripta_home_challenge/data/dto/task/task_dto.dart';

class TaskStorageUseCases {
  final TaskStorageRepository _repository;

  TaskStorageUseCases({required TaskStorageRepository repository})
      : _repository = repository;

  Future<List<Task>> getClosedTasks() async {
    try {
      final closedTasksJson = await _repository.getClosedTasks() ?? [];
      return closedTasksJson.map((taskJson) {
        String decodedString = jsonDecode(taskJson);
        Map<String, dynamic> taskMap = jsonDecode(decodedString);
        return Task.fromDto(TaskDto.fromMap(taskMap));
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveClosedTasks(List<Task> tasks) async {
    try {
      final closedTasksJson = tasks.map((task) => jsonEncode(task.toJson())).toList();
      await _repository.saveClosedTasks(closedTasksJson);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearClosedTasks() async {
    try {
      await _repository.clearClosedTasks();
    } catch (e) {
      rethrow;
    }
  }
}