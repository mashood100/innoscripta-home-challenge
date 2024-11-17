import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/core/utils/colors_utils.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';

class ProjectColorSelector extends ConsumerWidget {
  final String selectedColor;
  final Function(String) onColorSelected;
  final List<String> colors;

  const ProjectColorSelector({
    Key? key,
    required this.selectedColor,
    required this.onColorSelected,
    this.colors = const ['red', 'yellow', 'green', 'orange', 'blue'],
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Select Color:', style: AppText.bodyMedium),
        Space.y1,
        Wrap(
          spacing: 12,
          children: colors.map((color) {
            return GestureDetector(
              onTap: () => onColorSelected(color),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: ColorUtility.getColorFromString(color),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selectedColor == color
                        ? Colors.black
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
