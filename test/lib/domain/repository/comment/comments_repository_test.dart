import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:innoscripta_home_challenge/domain/repository/comment/comments_repository.dart';

import '../../../../fixtures/comment/comment_fixtures.dart';
import 'comments_repository_test.mocks.dart';


@GenerateMocks([CommentsRepository])
void main() {
  late MockCommentsRepository repository;

  setUp(() {
    repository = MockCommentsRepository();
  });

  group('CommentsRepository', () {
    test('create should return a Comment', () async {
      final comment = CommentFixtures.mockComment();
      when(repository.create(comment)).thenAnswer((_) async => comment);

      final result = await repository.create(comment);
      verify(repository.create(comment)).called(1);
      expect(result, equals(comment));
    });

    test('update should return updated Comment', () async {
      final comment = CommentFixtures.mockComment();
      when(repository.update(comment)).thenAnswer((_) async => comment);

      final result = await repository.update(comment);
      verify(repository.update(comment)).called(1);
      expect(result, equals(comment));
    });

    test('delete should complete successfully', () async {
      final commentId = 'comment-1';
      when(repository.delete(commentId)).thenAnswer((_) async => null);

      await repository.delete(commentId);
      verify(repository.delete(commentId)).called(1);
    });

    test('getAllForTask should return list of Comments', () async {
      final comments = CommentFixtures.mockCommentList();
      final taskId = 'task-1';
      when(repository.getAllForTask(taskId)).thenAnswer((_) async => comments);

      final result = await repository.getAllForTask(taskId);
      verify(repository.getAllForTask(taskId)).called(1);
      expect(result, equals(comments));
    });

    test('getAllForProject should return list of Comments', () async {
      final comments = CommentFixtures.mockCommentList();
      final projectId = 'project-1';
      when(repository.getAllForProject(projectId)).thenAnswer((_) async => comments);

      final result = await repository.getAllForProject(projectId);
      verify(repository.getAllForProject(projectId)).called(1);
      expect(result, equals(comments));
    });
  });
}