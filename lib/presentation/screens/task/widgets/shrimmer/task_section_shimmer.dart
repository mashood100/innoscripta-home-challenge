import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/presentation/shared/widgets/shimmer/base_shimmer.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';

class TaskSectionShimmer extends StatelessWidget {
  const TaskSectionShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Space.all(),
          child: BaseShimmer(
            child: Container(
              width: 150.r,
              height: 24.r,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: Space.h,
          child: Row(
            children: List.generate(
              3,
              (index) => Padding(
                padding: EdgeInsets.only(right: 8.r),
                child: BaseShimmer(
                  child: Container(
                    width: 300.r,
                    height: 150.r,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: UIProps.radius,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
