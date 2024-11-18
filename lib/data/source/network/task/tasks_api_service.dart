import 'package:innoscripta_home_challenge/core/configs/api/api_service.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';

class TasksApiService extends ApiService {
  TasksApiService() : super();

  Future<String> getAll(String projectId) async {
    try {
      final requestData = RequestData(
        '/tasks',
        queryParameters: {'project_id': projectId},
        RequestType.GET,
      );

      final response = await makeRequest(requestData);

      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> create(Map<String, dynamic> task) async {
    try {
      final requestData = RequestData(
        '/tasks',
        RequestType.POST,
        payload: task,
      );
      final response = await makeRequest(requestData);
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> update(Task task) async {
    try {
      final requestData = RequestData(
        '/tasks/${task.id}',
        RequestType.POST,
        payload: task.toMap(),
      );
      final response = await makeRequest(requestData);

      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> get(String id) async {
    try {
      final requestData = RequestData(
        '/tasks/$id',
        RequestType.GET,
      );
      final response = await makeRequest(requestData);
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(Task task) async {
    try {
      final requestData = RequestData(
        '/tasks/${task.id}',
        RequestType.DELETE,
      );
      await makeRequest(requestData);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> close(Task task) async {
    try {
      final requestData = RequestData(
        '/tasks/${task.id}/close',
        RequestType.DELETE,
      );
      await makeRequest(requestData);
    } catch (e) {
      rethrow;
    }
  }
}
