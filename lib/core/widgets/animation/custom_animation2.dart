import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CustomAnimation2 extends StatelessWidget {
  const CustomAnimation2({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: AnimationConfiguration.staggeredList(
        position: 1,
        duration: const Duration(milliseconds: 500),
        child: SlideAnimation(
          horizontalOffset: -100,
          child: FadeInAnimation(
            child: child,
          ),
        )
      ),
    );
  }
}
