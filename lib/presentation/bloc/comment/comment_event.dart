import 'package:innoscripta_home_challenge/domain/entity/comment/comment.dart';

abstract class CommentEvent {}

class CreateCommentEvent extends CommentEvent {
  final Comment comment;
  CreateCommentEvent(this.comment);
}

class GetAllTaskCommentsEvent extends CommentEvent {
  final String taskId;
  GetAllTaskCommentsEvent(this.taskId);
}

class GetAllProjectCommentsEvent extends CommentEvent {
  final String projectId;
  GetAllProjectCommentsEvent(this.projectId);
}

class UpdateCommentEvent extends CommentEvent {
  final Comment comment;
  UpdateCommentEvent(this.comment);
}

class DeleteCommentEvent extends CommentEvent {
  final String commentId;
  DeleteCommentEvent(this.commentId);
}