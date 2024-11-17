import 'package:innoscripta_home_challenge/domain/entity/comment/comment.dart';

abstract class CommentsRepository {
  Future<Comment> create(Comment comment);
  Future<Comment> update(Comment comment);
  Future<void> delete(String id);
  Future<Comment> get(String id);
  Future<List<Comment>> getAllForTask(String taskId);
  Future<List<Comment>> getAllForProject(String projectId);
}
