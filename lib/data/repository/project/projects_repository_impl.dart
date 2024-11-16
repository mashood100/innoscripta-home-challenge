import 'dart:convert' as convert;

import 'package:innoscripta_home_challenge/data/dto/project/project_dto.dart';
import 'package:innoscripta_home_challenge/data/source/network/project/projects_api_service.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/domain/repository/project/projects_repository.dart';

class ProjectsRepositoryImpl implements ProjectsRepository {
  final ProjectsApiService _api;

  ProjectsRepositoryImpl({
    required ProjectsApiService api,
  }) : _api = api;

  @override
  Future<Project> create(Project project) async {
    try {
      Map<String, dynamic> payload = project.toDto().toMap();
      payload.removeWhere((key, value) => value == null);

      final responseString = await _api.create(payload);
      final Map<String, dynamic> responseBody =
          convert.jsonDecode(responseString);

      return Project.fromDto(ProjectDto.fromMap(responseBody));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Project> update(Project project) async {
    try {
      final responseString = await _api.update(project);
      final Map<String, dynamic> responseBody =
          convert.jsonDecode(responseString);

      return Project.fromDto(ProjectDto.fromMap(responseBody));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String? id) async {
    try {
      await _api.delete(id ?? "");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Project> get(String id) async {
    try {
      final responseString = await _api.get(id);
      final Map<String, dynamic> responseBody =
          convert.jsonDecode(responseString);

      return Project.fromDto(ProjectDto.fromMap(responseBody));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Project>> getAll() async {
    try {
      final responseString = await _api.getAll();
      final List<dynamic> responseBody = convert.jsonDecode(responseString);

      return responseBody
          .map((projectMap) => Project.fromDto(ProjectDto.fromMap(projectMap)))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
