import 'package:innoscripta_home_challenge/core/configs/api/api_service.dart';
import 'package:innoscripta_home_challenge/domain/entity/comment/comment.dart';

class CommentsApiService extends ApiService {
  CommentsApiService() : super();

  Future<String> getAllForTask(String taskId) async {
    try {
      final requestData = RequestData(
        '/comments/',
        RequestType.GET,
        queryParameters: {'task_id': taskId},
      );
      final response = await makeRequest(requestData);
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getAllForProject(String projectId) async {
    try {
      final requestData = RequestData(
        '/comments',
        RequestType.GET,
        queryParameters: {'project_id': projectId},
      );
      final response = await makeRequest(requestData);
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> create(Map<String, dynamic> comment) async {
    try {
      final requestData = RequestData(
        '/comments',
        RequestType.POST,
        payload: comment,
      );
      final response = await makeRequest(requestData);
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> update(Comment comment) async {
    try {
      final requestData = RequestData(
        '/comments/${comment.id}',
        RequestType.POST,
        payload: comment.toMap(),
      );
      final response = await makeRequest(requestData);

      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      final requestData = RequestData(
        '/comments/$id',
        RequestType.DELETE,
      );
      await makeRequest(requestData);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> get(String id) async {
    try {
      final requestData = RequestData(
        '/comments/$id',
        RequestType.GET,
      );
      final response = await makeRequest(requestData);
      return response.body;
    } catch (e) {
      rethrow;
    }
  }
}
