import 'package:selector/assets/constants.dart';

/// Bounds of animation
class Bounds {
  /// Main constructor
  Bounds(this.lower, this.upper);

  /// Lower bound of the animation
  final double lower;

  /// Upper bound of the animation
  final double upper;
}

/// Base class for the definition of all animations
abstract class LottieAnimation {
  /// Main constructor
  LottieAnimation(
    this.iin,
    this.out,
  );

  /// The 'In' animation bounds
  final Bounds iin; // 'in' is a reserved word

  /// The 'Out' animation bounds
  final Bounds out;
}

/// Animation of Buttons
abstract class LottieButtonAnimation extends LottieAnimation {
  /// Main constructor
  LottieButtonAnimation(
    Bounds inAnimation,
    Bounds outAnimation,
  ) : super(inAnimation, outAnimation);
}

/// Animation of the Puzzle Tile
abstract class LottieTilePuzzleAnimation extends LottieAnimation {
  /// Main constructor
  LottieTilePuzzleAnimation(
    Bounds inAnimation,
    Bounds outAnimation,
  ) : super(inAnimation, outAnimation);
}

/// Animation of the Puzzle Tile Hint
abstract class LottieTileHintAnimation extends LottieAnimation {
  /// Main constructor
  LottieTileHintAnimation(
    Bounds inAnimation,
    Bounds outAnimation,
  ) : super(inAnimation, outAnimation);
}

/// Animation of the Star Small
abstract class LottieStarSmallAnimation extends LottieAnimation {
  /// Main constructor
  LottieStarSmallAnimation(
    Bounds inAnimation,
    Bounds outAnimation,
  ) : super(inAnimation, outAnimation);
}

/// Parsers seconds duration given global constants to Milliseconds,
/// used in animation bounds
double animationSecondsToMilliseconds(
  double seconds, {
  double maxSeconds = globalLottieMaxLength,
  double maxMilliseconds = globalAnimationSpeed,
}) =>
    seconds * maxMilliseconds / maxSeconds;

/// Times for lottie animation tile_puzzle.json
class AnimationBounds {
  /// In animation
  static final idle = <double>[
    0,
    animationSecondsToMilliseconds(0.34),
  ];

  /// Hover-in Animation
  static final correct = <double>[
    animationSecondsToMilliseconds(1.51),
    animationSecondsToMilliseconds(2.42),
  ];

  /// Pressed animation
  static final correctScaleOut = <double>[
    animationSecondsToMilliseconds(2.42),
    animationSecondsToMilliseconds(2.58),
  ];

  /// Slide Horizontal animation
  static final slideHorizontal = <double>[
    animationSecondsToMilliseconds(2.58),
    animationSecondsToMilliseconds(3.64),
  ];

  /// Slide Vertical animation
  static final slideVertical = <double>[
    animationSecondsToMilliseconds(3.64),
    animationSecondsToMilliseconds(3.92),
  ];

  /// Slide Normal Scale Out animation
  static final normalScaleOut = <double>[
    animationSecondsToMilliseconds(3.92),
    animationSecondsToMilliseconds(4.64)
  ];
}
