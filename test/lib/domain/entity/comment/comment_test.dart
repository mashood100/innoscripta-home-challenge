import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_home_challenge/data/dto/comment/comment_dto.dart';
import 'package:innoscripta_home_challenge/domain/entity/comment/comment.dart';

import '../../../../fixtures/comment/comment_fixtures.dart';

void main() {
  group('Comment', () {
    test('should create Comment instance with correct values', () {
      final comment = CommentFixtures.mockComment();

      expect(comment.id, 'comment-1');
      expect(comment.content, 'Test Comment');
      expect(comment.postedAt, DateTime(2024, 1, 1));
      expect(comment.projectId, 'project-1');
      expect(comment.taskId, 'task-1');
      expect(comment.attachment, isNotNull);
    });

    test('copyWith should return new instance with updated values', () {
      final comment = CommentFixtures.mockComment();
      final updatedComment = comment.copyWith(
        content: 'Updated Comment',
        projectId: 'project-2',
      );

      expect(updatedComment.id, comment.id);
      expect(updatedComment.content, 'Updated Comment');
      expect(updatedComment.projectId, 'project-2');
      expect(updatedComment.postedAt, comment.postedAt);
    });

    test('toDto should convert Comment to CommentDto', () {
      final comment = CommentFixtures.mockComment();
      final dto = comment.toDto();

      expect(dto, isA<CommentDto>());
      expect(dto.id, comment.id);
      expect(dto.content, comment.content);
      expect(dto.postedAt, comment.postedAt);
    });

    test('fromDto should convert CommentDto to Comment', () {
      final dto = CommentDto(
        id: 'test-id',
        content: 'Test Content',
        postedAt: DateTime(2024, 1, 1),
      );

      final comment = Comment.fromDto(dto);

      expect(comment, isA<Comment>());
      expect(comment.id, dto.id);
      expect(comment.content, dto.content);
      expect(comment.postedAt, dto.postedAt);
    });
  });
}