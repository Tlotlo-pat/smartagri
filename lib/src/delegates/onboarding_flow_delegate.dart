import 'package:flutter/material.dart';

class OnboardingFlowDelegate extends FlowDelegate {
  final AnimationController controller;

  OnboardingFlowDelegate(this.controller);
  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final child1 = context.getChildSize(0) ?? const Size(0, 0);
    final child2 = context.getChildSize(1) ?? const Size(0, 0);
    final child3 = context.getChildSize(1) ?? const Size(0, 0);
    context.paintChild(
      0,
      transform: Matrix4.translationValues(
        (size.width - child1.width / 1.5) * controller.value - 25,
        (size.height - child1.height / 1.5) * controller.value - 25,
        6,
      ),
    );
    context.paintChild(
      1,
      transform: Matrix4.translationValues(
        (-(child2.width / 1.5) + controller.value),
        size.height / 2,
        6,
      ),
    );
    context.paintChild(
      2,
      transform: Matrix4.translationValues(
        ((size.width * .6) * (1 - controller.value)) + 50,
        (size.height * .2),
        6,
      ),
    );
    context.paintChild(
      3,
      transform: Matrix4.translationValues(
        (size.width * .6) * (1 - controller.value),
        (size.height * .4) * (1 + controller.value),
        6,
      ),
    );
    // context.paintChild(1);
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return true;
  }
}
