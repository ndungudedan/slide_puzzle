// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// The animation builder of [PickatarShareDialog].
class PickatarShareDialogAnimatedBuilder extends StatelessWidget {
  const PickatarShareDialogAnimatedBuilder({
    Key? key,
    required this.builder,
    required this.animation,
    this.child,
  }) : super(key: key);

  final MyTransitionBuilder builder;
  final Listenable animation;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return builder(
          context,
          child,
          PickatarShareDialogEnterAnimation(animation as AnimationController),
        );
      },
      child: child,
    );
  }
}

typedef MyTransitionBuilder = Widget Function(
  BuildContext context,
  Widget? child,
  PickatarShareDialogEnterAnimation animation,
);

class PickatarShareDialogEnterAnimation {
  PickatarShareDialogEnterAnimation(this.controller)
      : scoreOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0, 0.6, curve: Curves.easeOut),
          ),
        ),
        scoreOffset = Tween<Offset>(
          begin: const Offset(-0.3, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0, 0.6, curve: Curves.easeOut),
          ),
        ),
        shareYourScoreOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.25, 0.80, curve: Curves.easeOut),
          ),
        ),
        shareYourScoreOffset = Tween<Offset>(
          begin: const Offset(-0.065, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.25, 0.80, curve: Curves.easeOut),
          ),
        ),
        socialButtonsOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.42, 1, curve: Curves.easeOut),
          ),
        ),
        socialButtonsOffset = Tween<Offset>(
          begin: const Offset(-0.045, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.42, 1, curve: Curves.easeOut),
          ),
        );

  final AnimationController controller;
  final Animation<double> scoreOpacity;
  final Animation<Offset> scoreOffset;
  final Animation<double> shareYourScoreOpacity;
  final Animation<Offset> shareYourScoreOffset;
  final Animation<double> socialButtonsOpacity;
  final Animation<Offset> socialButtonsOffset;
}
