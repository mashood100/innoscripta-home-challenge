import 'package:equatable/equatable.dart';
import 'package:innoscripta_home_challenge/data/dto/comment/comment_dto.dart';
import 'comment_attachment.dart';

class Comment extends CommentDto with EquatableMixin {
  Comment({
    super.id,
    super.content,
    super.postedAt,
    super.projectId,
    super.taskId,
    CommentAttachment? attachment,
  }) : super(attachment: attachment);

  @override
  List<Object?> get props => [
        id,
        content,
        postedAt,
        projectId,
        taskId,
        attachment,
      ];

  Comment copyWith({
    String? id,
    String? content,
    DateTime? postedAt,
    String? projectId,
    String? taskId,
    CommentAttachment? attachment,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      postedAt: postedAt ?? this.postedAt,
      projectId: projectId ?? this.projectId,
      taskId: taskId ?? this.taskId,
      attachment: attachment ?? this.attachment,
    );
  }

  CommentDto toDto() {
    return CommentDto(
      id: id,
      content: content,
      postedAt: postedAt,
      projectId: projectId,
      taskId: taskId,
      attachment: attachment,
    );
  }

  static Comment fromDto(CommentDto dto) {
    return Comment(
      id: dto.id,
      content: dto.content,
      postedAt: dto.postedAt,
      projectId: dto.projectId,
      taskId: dto.taskId,
      attachment: dto.attachment,
    );
  }
}
