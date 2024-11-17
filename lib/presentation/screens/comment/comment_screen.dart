import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/domain/entity/comment/comment.dart';
import 'package:innoscripta_home_challenge/presentation/screens/comment/widgets/comment_card.dart';
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
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

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
                  onDelete: () => _handleDeleteComment(commentState.comments[index]),
                  onUpdate: () => _showUpdateCommentSheet(commentState.comments[index]),
                );
              },
            ),
          ),
          _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: Space.all(),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                hintText: 'Add a comment...',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
          ),
          Space.x1,
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _handleAddComment,
          ),
        ],
      ),
    );
  }

  void _handleAddComment() {
    if (_commentController.text.trim().isEmpty) return;

    final comment = Comment(
      content: _commentController.text,
      projectId: widget.projectId,
      taskId: widget.taskId,
    );

    ref.read(commentStateProvider.notifier).createComment(comment);
    _commentController.clear();
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
