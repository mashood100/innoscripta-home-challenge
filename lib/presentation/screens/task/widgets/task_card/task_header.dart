import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/core/utils/colors_utils.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';
import 'package:innoscripta_home_challenge/presentation/theme/app_typography.dart';

class TaskHeader extends ConsumerWidget {
  final Project project;
  final int totalTasks;

  const TaskHeader({
    super.key,
    required this.project,
    required this.totalTasks,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.name ?? 'Project',
                      style: AppText.titleLargeSemiBold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '$totalTasks tasks',
                      style: AppText.bodySmall.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.r, left: 10.r),
                  child: CircleAvatar(
                    radius: 8.r,
                    backgroundColor:
                        ColorUtility.getColorFromString(project.color!),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}
