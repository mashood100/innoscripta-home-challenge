import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isEditing;

  const SubmitButton({
    Key? key,
    required this.onPressed,
    required this.isEditing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        isEditing ? 'Update Project' : 'Create Project',
      ),
    );
  }
}
