import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/presentation/shared/widgets/shimmer/base_shimmer.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';

class TaskHeaderShimmer extends StatelessWidget {
  const TaskHeaderShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
      child: Row(
        children: [
          Container(
            width: 24.r,
            height: 24.r,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          Space.x2,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200.r,
                  height: 24.r,
                  color: Colors.white,
                ),
                Space.y1,
                Container(
                  width: 100.r,
                  height: 16.r,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
