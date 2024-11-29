import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_home_challenge/domain/entity/comment/comment.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/comment/comment_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/comment/comment_event.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/comment/comment_state.dart';
import 'package:innoscripta_home_challenge/presentation/screens/comment/widgets/comment_card.dart';
import 'package:innoscripta_home_challenge/presentation/screens/comment/widgets/comment_input_widget.dart';
import 'package:innoscripta_home_challenge/presentation/screens/comment/widgets/update_comment_sheet.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';

class CommentScreen extends StatefulWidget {
  final String projectId;
  final String taskId;

  const CommentScreen({
    super.key,
    required this.projectId,
    required this.taskId,
  });

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  void _loadComments() {
    context.read<CommentBloc>().add(GetAllTaskCommentsEvent(widget.taskId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: BlocBuilder<CommentBloc, CommentState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: Space.all(),
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) {
                    return CommentCard(
                      comment: state.comments[index],
                      onDelete: () => _handleDeleteComment(state.comments[index]),
                      onUpdate: () => _showUpdateCommentSheet(state.comments[index]),
                    );
                  },
                ),
              ),
              CommentInputWidget(
                projectId: widget.projectId,
                taskId: widget.taskId,
              ),
            ],
          );
        },
      ),
    );
  }

  void _handleDeleteComment(Comment comment) {
    context.read<CommentBloc>().add(DeleteCommentEvent(comment.id!));
  }

  void _showUpdateCommentSheet(Comment comment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => UpdateCommentSheet(comment: comment),
    );
  }
}
