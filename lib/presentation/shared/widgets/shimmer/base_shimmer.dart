import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BaseShimmer extends StatelessWidget {
  final Widget child;

  const BaseShimmer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Shimmer.fromColors(
      baseColor: brightness == Brightness.light
          ? Colors.grey[300]!
          : const Color.fromARGB(255, 42, 42, 42),
      highlightColor: brightness == Brightness.light
          ? Colors.grey[100]!
          : const Color.fromARGB(255, 42, 42, 42),
      child: child,
    );
  }
}
