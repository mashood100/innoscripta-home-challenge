import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/data/repository/comment/comments_repository_impl.dart';
import 'package:innoscripta_home_challenge/data/source/network/comment/comments_api_service.dart';
import 'package:innoscripta_home_challenge/domain/entity/comment/comment.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/comment/comments_use_cases.dart';
import 'package:innoscripta_home_challenge/presentation/provider/comment/comment_state.dart';
import 'package:innoscripta_home_challenge/presentation/shared/widgets/snackbars/snackbar_helper.dart';

class CommentStateNotifier extends StateNotifier<CommentState> {
  CommentStateNotifier()  : 
        _commentUseCase = CommentsUseCases(
          repository: CommentsRepositoryImpl(api: CommentsApiService()),
        ),
        super(CommentState.initial());


  final CommentsUseCases _commentUseCase;

  Future<void> createComment(Comment comment) async {
    try {
      state = state.copyWith(status: CommentProviderState.loading);
      Comment response = await _commentUseCase.create(comment);

      final updatedComments = [response, ...state.comments];
      state = state.copyWith(
        status: CommentProviderState.success,
        comments: updatedComments,
      );

      SnackbarHelper.snackbarWithTextOnly('Comment added successfully');
    } catch (error) {
      state = state.copyWith(
        status: CommentProviderState.initial,
        errorMessage: error.toString(),
      );
      SnackbarHelper.snackbarWithTextOnly('Failed to add comment');
    }
  }

  Future<void> getAllTaskComments(String taskId) async {
    try {
      state = state.copyWith(status: CommentProviderState.loading);
      final comments = await _commentUseCase.getAllForTask(taskId);
      state = state.copyWith(
        status: CommentProviderState.success,
        comments: comments,
      );
    } catch (e) {
      state = state.copyWith(
        status: CommentProviderState.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> getAllProjectComments(String projectId) async {
    try {
      state = state.copyWith(status: CommentProviderState.loading);
      final comments = await _commentUseCase.getAllForProject(projectId);
      state = state.copyWith(
        status: CommentProviderState.success,
        comments: comments,
      );
    } catch (e) {
      state = state.copyWith(
        status: CommentProviderState.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> updateComment(Comment comment) async {
    final initialState = state;
    try {
      final updatedComments = state.comments.map((c) {
        return c.id == comment.id ? comment : c;
      }).toList();

      state = state.copyWith(
        comments: updatedComments,
      );

      await _commentUseCase.update(comment);
      SnackbarHelper.snackbarWithTextOnly('Comment updated successfully');
    } catch (e) {
      state = initialState;
      SnackbarHelper.snackbarWithTextOnly('Failed to update comment');
      log('Update comment error: $e');
    }
  }

  Future<void> deleteComment(String commentId) async {
    try {
      await _commentUseCase.delete(commentId);

      final updatedComments = state.comments
          .where((comment) => comment.id != commentId)
          .toList();
      
      state = state.copyWith(
        status: CommentProviderState.success,
        comments: updatedComments,
      );

      SnackbarHelper.snackbarWithTextOnly('Comment deleted successfully');
    } catch (e) {
      state = state.copyWith(
        status: CommentProviderState.initial,
        errorMessage: e.toString(),
      );
      SnackbarHelper.snackbarWithTextOnly('Failed to delete comment');
      log('Delete comment error: $e');
    }
  }
}
