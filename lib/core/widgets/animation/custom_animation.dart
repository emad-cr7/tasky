import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CustomAnimation extends StatelessWidget {
  const CustomAnimation({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: AnimationConfiguration.staggeredList(
        position: 1,
        duration: Duration(milliseconds: 500),
        child: SlideAnimation(child: FadeInAnimation(child: child)),
      ),
    );
  }
}
