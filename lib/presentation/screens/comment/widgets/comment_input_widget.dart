import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_home_challenge/core/utils/date_utils.dart';
import 'package:innoscripta_home_challenge/domain/entity/comment/comment.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/comment/comment_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/comment/comment_event.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommentInputWidget extends StatefulWidget {
  final String projectId;
  final String taskId;

  const CommentInputWidget({
    super.key,
    required this.projectId,
    required this.taskId,
  });

  @override
  State<CommentInputWidget> createState() => _CommentInputWidgetState();
}

class _CommentInputWidgetState extends State<CommentInputWidget> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                ),
              ),
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.addComment,
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                maxLines: 2,
              ),
            ),
          ),
          Space.x2,
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: _handleAddComment,
            ),
          ),
        ],
      ),
    );
  }

  void _handleAddComment() {
    if (_commentController.text.trim().isEmpty) return;

    final comment = Comment(
      content: StringUtils.cleanText(_commentController.text),
      projectId: widget.projectId,
      taskId: widget.taskId,
    );

    context.read<CommentBloc>().add(CreateCommentEvent(comment));
    _commentController.clear();
  }
}
