import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/core/utils/colors_utils.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/presentation/theme/app_typography.dart';

class TaskHeader extends StatelessWidget {
  final Project project;
  final int totalTasks;

  const TaskHeader({
    super.key,
    required this.project,
    required this.totalTasks,
  });

  @override
  Widget build(BuildContext context) {
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
                    radius: 10.r,
                    backgroundColor:
                        ColorUtility.getColorFromString(project.color!),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
