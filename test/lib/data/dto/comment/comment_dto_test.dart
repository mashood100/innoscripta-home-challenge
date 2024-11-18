import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_home_challenge/data/dto/comment/comment_dto.dart';
import '../../../../fixtures/comment/comment_dto_fixtures.dart';

void main() {
  group('CommentDto', () {
    test('should create CommentDto with default values', () {
      final dto = CommentDto();
      
      expect(dto.id, isNull);
      expect(dto.content, isNull);
      expect(dto.postedAt, isNull);
      expect(dto.projectId, isNull);
      expect(dto.taskId, isNull);
      expect(dto.attachment, isNull);
    });

    test('fromMap should create CommentDto with correct values', () {
      final map = CommentDtoFixtures.mockCommentMap();
      final dto = CommentDto.fromMap(map);

      expect(dto.id, 'comment-1');
      expect(dto.content, 'Test Comment');
      expect(dto.postedAt, DateTime.parse('2024-01-01T00:00:00Z'));
      expect(dto.projectId, 'project-1');
      expect(dto.taskId, 'task-1');
      expect(dto.attachment?.fileName, 'test.pdf');
      expect(dto.attachment?.fileType, 'application/pdf');
    });

    test('toMap should convert CommentDto to Map correctly', () {
      final map = CommentDtoFixtures.mockCommentMap();
      final dto = CommentDto.fromMap(map);
      final resultMap = dto.toMap();

      expect(resultMap['id'], 'comment-1');
      expect(resultMap['content'], 'Test Comment');
      expect(resultMap['posted_at'], '2024-01-01T00:00:00.000Z');
      expect(resultMap['project_id'], 'project-1');
      expect(resultMap['task_id'], 'task-1');
      expect(resultMap['attachment']['file_name'], 'test.pdf');
    });
  });
}