import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_home_challenge/domain/entity/comment/comment.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/comment/comments_use_cases.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/comment/comment_event.dart';
import 'dart:developer';

import 'package:innoscripta_home_challenge/presentation/bloc/comment/comment_state.dart';
import 'package:innoscripta_home_challenge/presentation/shared/widgets/snackbars/snackbar_helper.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentsUseCases _commentUseCase;

  CommentBloc({required CommentsUseCases commentUseCase})
      : _commentUseCase = commentUseCase,
        super(CommentState.initial()) {
    on<CreateCommentEvent>(_createComment);
    on<GetAllTaskCommentsEvent>(_getAllTaskComments);
    on<GetAllProjectCommentsEvent>(_getAllProjectComments);
    on<UpdateCommentEvent>(_updateComment);
    on<DeleteCommentEvent>(_deleteComment);
  }

  Future<void> _createComment(
    CreateCommentEvent event,
    Emitter<CommentState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CommentStatus.loading));
      Comment response = await _commentUseCase.create(event.comment);

      final updatedComments = [response, ...state.comments];
      emit(state.copyWith(
        status: CommentStatus.success,
        comments: updatedComments,
      ));

      SnackbarHelper.snackbarWithTextOnly('Comment added successfully');
    } catch (error) {
      emit(state.copyWith(
        status: CommentStatus.error,
        errorMessage: error.toString(),
      ));
      SnackbarHelper.snackbarWithTextOnly('Failed to add comment');
    }
  }

  Future<void> _getAllTaskComments(
    GetAllTaskCommentsEvent event,
    Emitter<CommentState> emit,
  ) async {
    try {
      emit(state.copyWith(
        comments: [],
        status: CommentStatus.loading,
      ));
      
      final comments = await _commentUseCase.getAllForTask(event.taskId);
      emit(state.copyWith(
        status: CommentStatus.success,
        comments: comments,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CommentStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _getAllProjectComments(
    GetAllProjectCommentsEvent event,
    Emitter<CommentState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CommentStatus.loading));
      final comments = await _commentUseCase.getAllForProject(event.projectId);
      emit(state.copyWith(
        status: CommentStatus.success,
        comments: comments,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CommentStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _updateComment(
    UpdateCommentEvent event,
    Emitter<CommentState> emit,
  ) async {
    final initialState = state;
    try {
      final updatedComments = state.comments.map((c) {
        return c.id == event.comment.id ? event.comment : c;
      }).toList();

      emit(state.copyWith(comments: updatedComments));
      await _commentUseCase.update(event.comment);
      SnackbarHelper.snackbarWithTextOnly('Comment updated successfully');
    } catch (e) {
      emit(initialState);
      SnackbarHelper.snackbarWithTextOnly('Failed to update comment');
      log('Update comment error: $e');
    }
  }

  Future<void> _deleteComment(
    DeleteCommentEvent event,
    Emitter<CommentState> emit,
  ) async {
    try {
      await _commentUseCase.delete(event.commentId);

      final updatedComments = 
          state.comments.where((comment) => comment.id != event.commentId).toList();

      emit(state.copyWith(
        status: CommentStatus.success,
        comments: updatedComments,
      ));

      SnackbarHelper.snackbarWithTextOnly('Comment deleted successfully');
    } catch (e) {
      emit(state.copyWith(
        status: CommentStatus.error,
        errorMessage: e.toString(),
      ));
      SnackbarHelper.snackbarWithTextOnly('Failed to delete comment');
      log('Delete comment error: $e');
    }
  }
}