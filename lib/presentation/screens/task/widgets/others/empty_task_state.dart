import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';

class EmptyTaskState extends StatelessWidget {
  final String status;

  const EmptyTaskState({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 150.h,
      margin: Space.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        borderRadius: UIProps.radius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 40.r,
            color: Colors.grey,
          ),
          Space.y1,
          Text(
            'No ${status.replaceAll('_', ' ')} tasks',
            style: AppText.bodyMedium,
          ),
        ],
      ),
    );
  }
}
