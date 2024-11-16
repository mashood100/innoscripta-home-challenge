import 'dart:developer';

import 'package:innoscripta_home_challenge/configs/api/api_service.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';

class TasksApiService extends ApiService {
  TasksApiService() : super();

  Future<String> getAll() async {
    try {
      final requestData = RequestData(
        '/tasks',
        queryParameters: {'project_id': "2343546180"},
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

  Future<void> delete(String ids) async {
    try {
      final requestData = RequestData(
        '/tasks/$ids',
        RequestType.DELETE,
      );
      await makeRequest(requestData);
    } catch (e) {
      rethrow;
    }
  }
}
