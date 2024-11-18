import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:innoscripta_home_challenge/data/repository/comment/comments_repository_impl.dart';
import 'package:innoscripta_home_challenge/data/source/network/comment/comments_api_service.dart';
import '../../../../fixtures/comment/comment_fixtures.dart';
import '../../../../fixtures/comment/comment_dto_fixtures.dart';
import 'comments_repository_impl_test.mocks.dart';

@GenerateMocks([CommentsApiService])
void main() {
  late CommentsRepositoryImpl repository;
  late MockCommentsApiService mockApiService;

  setUp(() {
    mockApiService = MockCommentsApiService();
    repository = CommentsRepositoryImpl(api: mockApiService);
  });

  group('CommentsRepositoryImpl', () {
    test('create should return Comment from API response', () async {
      final comment = CommentFixtures.mockComment();
      when(mockApiService.create(any))
          .thenAnswer((_) async => CommentDtoFixtures.mockCommentJson());

      final result = await repository.create(comment);
      
      verify(mockApiService.create(any)).called(1);
      expect(result.id, 'comment-1');
      expect(result.content, 'Test Comment');
    });

    test('getAllForTask should return list of Comments', () async {
      when(mockApiService.getAllForTask('task-1'))
          .thenAnswer((_) async => CommentDtoFixtures.mockCommentListJson());

      final result = await repository.getAllForTask('task-1');
      
      verify(mockApiService.getAllForTask('task-1')).called(1);
      expect(result.length, 2);
      expect(result.first.id, 'comment-1');
      expect(result.first.content, 'Test Comment');
    });

    test('getAllForProject should return list of Comments', () async {
      when(mockApiService.getAllForProject('project-1'))
          .thenAnswer((_) async => CommentDtoFixtures.mockCommentListJson());

      final result = await repository.getAllForProject('project-1');
      
      verify(mockApiService.getAllForProject('project-1')).called(1);
      expect(result.length, 2);
      expect(result.first.id, 'comment-1');
    });

    test('should throw exception when API fails', () async {
      when(mockApiService.getAllForTask('task-1'))
          .thenThrow(Exception('API Error'));

      expect(() => repository.getAllForTask('task-1'), throwsException);
      verify(mockApiService.getAllForTask('task-1')).called(1);
    });
  });
}