import 'package:flutter/material.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/bottom_sheet/add_project_bottom_sheet.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddProjectButton extends StatelessWidget {
  const AddProjectButton({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
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
