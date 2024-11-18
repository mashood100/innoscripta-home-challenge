import 'package:innoscripta_home_challenge/domain/entity/comment/comment.dart';
import 'package:innoscripta_home_challenge/domain/entity/comment/comment_attachment.dart';

class CommentFixtures {
  static CommentAttachment mockCommentAttachment() {
    return CommentAttachment(
      fileName: 'test.pdf',
      fileType: 'application/pdf',
      fileUrl: 'https://test.com/files/test.pdf',
      resourceType: 'file',
    );
  }

  static Comment mockComment() {
    return Comment(
      id: 'comment-1',
      content: 'Test Comment',
      postedAt: DateTime(2024, 1, 1),
      projectId: 'project-1',
      taskId: 'task-1',
      attachment: mockCommentAttachment(),
    );
  }

  static List<Comment> mockCommentList() {
    return [
      mockComment(),
      Comment(
        id: 'comment-2',
        content: 'Second Comment',
        postedAt: DateTime(2024, 1, 2),
        projectId: 'project-1',
        taskId: 'task-1',
      ),
    ];
  }
}