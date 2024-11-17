import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/presentation/shared/widgets/shimmer/base_shimmer.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';

class TaskCardShimmer extends StatelessWidget {
  const TaskCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
      child: Container(
        width: 300.r,
        padding: Space.all(),
        margin: EdgeInsets.symmetric(vertical: 10.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: UIProps.radius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 18.r,
                  height: 18.r,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Space.x,
                Container(
                  width: 200.r,
                  height: 20.r,
                  color: Colors.white,
                ),
              ],
            ),
            Space.y1,
            Container(
              width: double.infinity,
              height: 40.r,
              color: Colors.white,
            ),
            Space.y1,
            Container(
              width: 100.r,
              height: 20.r,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
