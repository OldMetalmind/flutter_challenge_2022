/// Duration of All animations (in Seconds)
const globalAnimationSpeed = 0.300;

/// Duration of All animations (in Milliseconds)
const globalAnimationDuration = Duration(milliseconds: 300);

/// Maximum Lottie Animation the Lottie file (in Seconds)
const globalLottieMaxLength = 4.64;

/// File with all animations in sequence
const lottieTileAnimationFile = 'assets/animations/tile.json';

/// Parsers seconds duration given global constants to Milliseconds,
/// used in animation bounds
double animationSecondsToMilliseconds(
  double seconds, {
  double maxSeconds = globalLottieMaxLength,
  double maxMilliseconds = globalAnimationSpeed,
}) =>
    seconds * maxMilliseconds / maxSeconds;

/// Times for lottie animation tile.json
/// 0 — 0.34: Scale in -> Idle
/// 1.51 — 2.42: Idle -> Correct
/// 2.42 — 2.58: Correct -> Correct scale out
/// 3.46 — 3.64: Slide Horizontal
/// 3.74 — 3.92: Slide Vertical
/// 4.32 — 4.64: Normal Scale Out
class AnimationBounds {
  /// Idle animation
  static final idle = <double>[
    0,
    animationSecondsToMilliseconds(0.34),
  ];

  /// Correct Animation
  static final correct = <double>[
    animationSecondsToMilliseconds(1.51),
    animationSecondsToMilliseconds(2.42),
  ];

  /// Correct Scale Out animation
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
