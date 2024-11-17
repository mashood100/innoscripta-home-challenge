import 'dart:convert' as convert;
import 'package:innoscripta_home_challenge/data/dto/comment/comment_dto.dart';
import 'package:innoscripta_home_challenge/data/source/network/comment/comments_api_service.dart';
import 'package:innoscripta_home_challenge/domain/entity/comment/comment.dart';
import 'package:innoscripta_home_challenge/domain/repository/comment/comments_repository.dart';

class CommentsRepositoryImpl implements CommentsRepository {
  final CommentsApiService _api;

  CommentsRepositoryImpl({
    required CommentsApiService api,
  }) : _api = api;

  @override
  Future<Comment> create(Comment comment) async {
    try {
      Map<String, dynamic> payload = comment.toDto().toMap();
      payload.removeWhere((key, value) => value == null);

      final responseString = await _api.create(payload);
      final Map<String, dynamic> responseBody =
          convert.jsonDecode(responseString);

      return Comment.fromDto(CommentDto.fromMap(responseBody));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Comment> update(Comment comment) async {
    try {
      final responseString = await _api.update(comment);
      final Map<String, dynamic> responseBody =
          convert.jsonDecode(responseString);

      return Comment.fromDto(CommentDto.fromMap(responseBody));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _api.delete(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Comment> get(String id) async {
    try {
      final responseString = await _api.get(id);
      final Map<String, dynamic> responseBody =
          convert.jsonDecode(responseString);

      return Comment.fromDto(CommentDto.fromMap(responseBody));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Comment>> getAllForTask(String taskId) async {
    try {
      final responseString = await _api.getAllForTask(taskId);
      final List<dynamic> responseBody = convert.jsonDecode(responseString);

      return responseBody
          .map((commentMap) => Comment.fromDto(CommentDto.fromMap(commentMap)))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Comment>> getAllForProject(String projectId) async {
    try {
      final responseString = await _api.getAllForProject(projectId);
      final List<dynamic> responseBody = convert.jsonDecode(responseString);

      return responseBody
          .map((commentMap) => Comment.fromDto(CommentDto.fromMap(commentMap)))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
