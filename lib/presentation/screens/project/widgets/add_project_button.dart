import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/bottom_sheet/add_project_bottom_sheet.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddProjectButton extends ConsumerWidget {
  const AddProjectButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        showMaterialModalBottomSheet(
          context: context,
          builder: (context) => const AddProjectBottomSheet(),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
