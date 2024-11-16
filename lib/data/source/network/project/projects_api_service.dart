import 'package:innoscripta_home_challenge/core/configs/api/api_service.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';

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

  Future<String> update(Project project) async {
    try {
      final requestData = RequestData(
        '/projects/${project.id}',
        RequestType.POST,
        payload: {
          'name': project.name,
          'color': project.color,
          'is_favorite': project.isFavorite,
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

  Future<void> delete(String id) async {
    try {
      final requestData = RequestData(
        '/projects/$id',
        RequestType.DELETE,
      );
      await makeRequest(requestData);
    } catch (e) {
      rethrow;
    }
  }
}
