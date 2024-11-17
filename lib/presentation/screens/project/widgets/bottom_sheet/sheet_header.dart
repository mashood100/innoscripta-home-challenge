import 'package:flutter/material.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';

class SheetHeader extends StatelessWidget {
  final bool isEditing;

  const SheetHeader({
    Key? key,
    required this.isEditing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        Space.y1,
        Text(
          isEditing ? 'Edit Project' : 'Create New Project',
          style: AppText.headlineSmallBold,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
