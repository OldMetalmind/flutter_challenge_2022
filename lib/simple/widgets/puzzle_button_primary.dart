import 'package:flutter/material.dart';
import 'package:seletter/helpers/animations_bounds_helper.dart';
import 'package:seletter/simple/widgets/puzzle_button_base.dart';

/// Primary Button that loads by default the respective lottie animation
class PuzzleButtonPrimary extends PuzzleButtonBase {
  /// Main Constructor
  const PuzzleButtonPrimary({
    Key? key,
    required String text,
    required VoidCallback onTap,
  }) : super(
          key: key,
          text: text,
          onTap: onTap,
          animation: LottieAnimations.primaryButton,
        );
}
