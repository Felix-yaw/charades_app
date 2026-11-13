import 'package:flutter/material.dart';

import '../../../core/constants/gradients.dart';
import '../../../core/utils/size_config.dart';

class SoftBackground extends StatelessWidget {
  const SoftBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppGradients.background),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: getProportionateScreenHeight(-110),
            right: getProportionateScreenWidth(-90),
            child: Container(
              width: getProportionateScreenWidth(300),
              height: getProportionateScreenWidth(300),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppGradients.glowPurple,
              ),
            ),
          ),
          Positioned(
            bottom: getProportionateScreenHeight(-130),
            left: getProportionateScreenWidth(-100),
            child: Container(
              width: getProportionateScreenWidth(340),
              height: getProportionateScreenWidth(340),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppGradients.glowBlue,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
