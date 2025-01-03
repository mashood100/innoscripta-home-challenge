import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_home_challenge/core/utils/date_utils.dart';
import 'package:innoscripta_home_challenge/domain/entity/comment/comment.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/comment/comment_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/comment/comment_event.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateCommentSheet extends StatefulWidget {
  final Comment comment;

  const UpdateCommentSheet({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  State<UpdateCommentSheet> createState() => _UpdateCommentSheetState();
}

class _UpdateCommentSheetState extends State<UpdateCommentSheet> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.comment.content);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context)!.updateComment,
              style: AppText.titleLarge),
          Space.y2,
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            maxLines: null,
            autofocus: true,
          ),
          Space.y2,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              Space.x1,
              ElevatedButton(
                onPressed: _handleUpdate,
                child: const Text('Update'),
              ),
            ],
          ),
          Space.y1,
        ],
      ),
    );
  }

  void _handleUpdate() {
    if (_controller.text.trim().isEmpty) return;

    final updatedComment = widget.comment.copyWith(
      content: StringUtils.cleanText(_controller.text),
    );

    context.read<CommentBloc>().add(UpdateCommentEvent(updatedComment));
    Navigator.pop(context);
  }
}
