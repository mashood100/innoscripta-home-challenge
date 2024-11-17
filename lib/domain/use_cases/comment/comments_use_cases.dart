import 'package:innoscripta_home_challenge/domain/entity/comment/comment.dart';
import 'package:innoscripta_home_challenge/domain/repository/comment/comments_repository.dart';

class CommentsUseCases {
  CommentsUseCases({
    required CommentsRepository repository,
  }) : _repository = repository;

  final CommentsRepository _repository;

  Future<Comment> create(Comment comment) async {
    try {
      return await _repository.create(comment);
    } catch (e) {
      rethrow;
    }
  }

  Future<Comment> update(Comment comment) async {
    try {
      return await _repository.update(comment);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      return await _repository.delete(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<Comment> get(String id) async {
    try {
      return await _repository.get(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Comment>> getAllForTask(String taskId) async {
    try {
      return await _repository.getAllForTask(taskId);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Comment>> getAllForProject(String projectId) async {
    try {
      return await _repository.getAllForProject(projectId);
    } catch (e) {
      rethrow;
    }
  }
}
