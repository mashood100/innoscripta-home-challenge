import 'package:innoscripta_home_challenge/configs/api/api_service.dart';

class ProjectsApiService extends ApiService {
  ProjectsApiService() : super();

  Future<String> getAll() async {
    try {
      final requestData = RequestData(
        '/projects',
        RequestType.GET,
      );
      final response = await makeRequest(requestData);
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> create(Map<String, dynamic> project) async {
    try {
      final requestData = RequestData(
        '/projects',
        RequestType.POST,
        payload: {
          'name': project['name'],
          'color': project['color'],
        },
      );
      final response = await makeRequest(requestData);
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> update(String id, Map<String, dynamic> project) async {
    try {
      final requestData = RequestData(
        '/projects/$id',
        RequestType.POST,
        payload: {
          'name': project['name'],
          'color': project['color'],
          'is_favorite': project['is_favorite'],
        },
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
        '/projects/$id',
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
        '/v1/projects/$ids',
        RequestType.DELETE,
      );
      await makeRequest(requestData);
    } catch (e) {
      rethrow;
    }
  }
}
