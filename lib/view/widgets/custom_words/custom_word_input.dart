import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/gradients.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import '../../../viewmodels/game_view_model.dart';

class CustomWordInput extends StatefulWidget {
  const CustomWordInput({super.key});

  @override
  State<CustomWordInput> createState() => _CustomWordInputState();
}

class _CustomWordInputState extends State<CustomWordInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<GameViewModel>().addCustomWord(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            textInputAction: TextInputAction.done,
            onSubmitted: (String _) => _submit(),
            style: AppTypography.body.copyWith(color: AppColors.white),
            decoration: InputDecoration(
              hintText: 'Type a word or phrase',
              hintStyle: AppTypography.body
                  .copyWith(color: AppColors.secondary),
              filled: true,
              fillColor: AppColors.surfaceDark,
              contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(16),
                vertical: getProportionateScreenHeight(14),
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenWidth(18)),
                borderSide: const BorderSide(color: AppColors.blueSoft),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenWidth(18)),
                borderSide: const BorderSide(color: AppColors.blueSoft),
              ),
            ),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(10)),
        Material(
          type: MaterialType.transparency,
          child: Ink(
            decoration: BoxDecoration(
              gradient: AppGradients.yellowButton,
              borderRadius:
                  BorderRadius.circular(getProportionateScreenWidth(18)),
            ),
            child: InkWell(
              borderRadius:
                  BorderRadius.circular(getProportionateScreenWidth(18)),
              onTap: _submit,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(18),
                  vertical: getProportionateScreenHeight(16),
                ),
                child: Text(
                  'Add',
                  style: AppTypography.button.copyWith(
                    color: AppColors.ink,
                    fontSize: getProportionateScreenWidth(16),
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
