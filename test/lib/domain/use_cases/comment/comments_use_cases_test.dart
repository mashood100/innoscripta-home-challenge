import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/comment/comments_use_cases.dart';

import '../../../../fixtures/comment/comment_fixtures.dart';
import '../../repository/comment/comments_repository_test.mocks.dart';


void main() {
  late CommentsUseCases useCase;
  late MockCommentsRepository mockRepository;

  setUp(() {
    mockRepository = MockCommentsRepository();
    useCase = CommentsUseCases(repository: mockRepository);
  });

  group('CommentsUseCases', () {
    test('create should return created Comment', () async {
      final comment = CommentFixtures.mockComment();
      when(mockRepository.create(comment)).thenAnswer((_) async => comment);

      final result = await useCase.create(comment);
      verify(mockRepository.create(comment)).called(1);
      expect(result, equals(comment));
    });

    test('create should rethrow exception', () async {
      final comment = CommentFixtures.mockComment();
      when(mockRepository.create(comment)).thenThrow(Exception('Error'));

      expect(() => useCase.create(comment), throwsException);
      verify(mockRepository.create(comment)).called(1);
    });

    test('getAllForTask should return list of Comments', () async {
      final comments = CommentFixtures.mockCommentList();
      final taskId = 'task-1';
      when(mockRepository.getAllForTask(taskId)).thenAnswer((_) async => comments);

      final result = await useCase.getAllForTask(taskId);
      verify(mockRepository.getAllForTask(taskId)).called(1);
      expect(result, equals(comments));
    });

    test('getAllForProject should return list of Comments', () async {
      final comments = CommentFixtures.mockCommentList();
      final projectId = 'project-1';
      when(mockRepository.getAllForProject(projectId))
          .thenAnswer((_) async => comments);

      final result = await useCase.getAllForProject(projectId);
      verify(mockRepository.getAllForProject(projectId)).called(1);
      expect(result, equals(comments));
    });
  });
}
