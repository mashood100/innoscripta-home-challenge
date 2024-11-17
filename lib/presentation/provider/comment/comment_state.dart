import 'package:equatable/equatable.dart';
import 'package:innoscripta_home_challenge/domain/entity/comment/comment.dart';

enum CommentProviderState { initial, loading, success, error }

class CommentState extends Equatable {
  final CommentProviderState status;
  final List<Comment> comments;
  final String errorMessage;

  const CommentState({
    required this.status,
    required this.comments,
    this.errorMessage = '',
  });

  factory CommentState.initial() {
    return const CommentState(
      status: CommentProviderState.initial,
      comments: [],
    );
  }

  CommentState copyWith({
    CommentProviderState? status,
    List<Comment>? comments,
    String? errorMessage,
  }) {
    return CommentState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, comments, errorMessage];
}
