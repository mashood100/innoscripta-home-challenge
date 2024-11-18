import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/domain/entity/comment/comment.dart';
import 'package:innoscripta_home_challenge/presentation/screens/comment/widgets/comment_card.dart';
import 'package:innoscripta_home_challenge/presentation/screens/comment/widgets/comment_input_widget.dart';
import 'package:innoscripta_home_challenge/presentation/screens/comment/widgets/update_comment_sheet.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';

class CommentScreen extends ConsumerStatefulWidget {
  final String projectId;
  final String taskId;

  const CommentScreen({
    Key? key,
    required this.projectId,
    required this.taskId,
  }) : super(key: key);

  @override
  ConsumerState<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    final commentState = ref.watch(commentStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: Space.all(),
              itemCount: commentState.comments.length,
              itemBuilder: (context, index) {
                return CommentCard(
                  comment: commentState.comments[index],
                  onDelete: () =>
                      _handleDeleteComment(commentState.comments[index]),
                  onUpdate: () =>
                      _showUpdateCommentSheet(commentState.comments[index]),
                );
              },
            ),
          ),
          CommentInputWidget(
            projectId: widget.projectId,
            taskId: widget.taskId,
          ),
        ],
      ),
    );
  }

  void _handleDeleteComment(Comment comment) {
    ref.read(commentStateProvider.notifier).deleteComment(comment.id!);
  }

  void _showUpdateCommentSheet(Comment comment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => UpdateCommentSheet(comment: comment),
    );
  }
}
