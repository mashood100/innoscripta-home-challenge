import 'dart:convert';
import 'package:innoscripta_home_challenge/domain/entity/comment/comment_attachment.dart';

class CommentDto {
  String? id;
  String? content;
  DateTime? postedAt;
  String? projectId;
  String? taskId;
  CommentAttachment? attachment;

  CommentDto({
    this.id,
    this.content,
    this.postedAt,
    this.projectId,
    this.taskId,
    this.attachment,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'posted_at': postedAt?.toIso8601String(),
      'project_id': projectId,
      'task_id': taskId,
      'attachment': attachment?.toMap(),
    };
  }

  factory CommentDto.fromMap(Map<String, dynamic> map) {
    return CommentDto(
      id: map['id']?.toString(),
      content: map['content'],
      postedAt: map['posted_at'] != null 
          ? DateTime.parse(map['posted_at']) 
          : null,
      projectId: map['project_id']?.toString(),
      taskId: map['task_id']?.toString(),
      attachment: map['attachment'] != null 
          ? CommentAttachment.fromMap(map['attachment']) 
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentDto.fromJson(String source) =>
      CommentDto.fromMap(json.decode(source));
}
