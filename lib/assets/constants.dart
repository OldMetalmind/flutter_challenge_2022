

/// This value is the different between real upper level of animation and
/// 300 milliseconds
const animationGoldenNumber = 15.46667;

const lottieAnimationZLength = 4.64;


const lottieTileAnimationFile = 'assets/animations/tile.json';

/// Times for lottie animation tile.json
/// 0 — 0.34: Scale in -> Idle
/// 1.51 — 2.42: Idle -> Correct
/// 2.42 — 2.58: Correct -> Correct scale out
/// 3.46 — 3.64: Slide Horizontal
/// 3.74 — 3.92: Slide Vertical
/// 4.32 — 4.64: Normal Scale Out
class AnimationBounds {
  static const idle = <double>[0, 0.34];
  static const correct = <double>[1.51, 2.42];
  static const correctScaleOut = <double>[2.42, 2.58];
  static const slideHorizontal = <double>[3.46, 3.64];
  static const slideVertical = <double>[3.74, 3.92];
  static const normalScaleOut = <double>[4.32, 4.64];
}
