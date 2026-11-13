import 'package:flutter/material.dart';

import '../../../core/utils/size_config.dart';
import 'got_it_button.dart';
import 'pass_button.dart';

class RoundActionButtons extends StatelessWidget {
  const RoundActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(24),
      ),
      child: Row(
        children: [
          const Expanded(child: PassButton()),
          SizedBox(width: getProportionateScreenWidth(14)),
          const Expanded(child: GotItButton()),
        ],
      ),
    );
  }
}
