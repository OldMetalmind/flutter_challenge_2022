import 'package:selector/assets/constants.dart';

/// Types of animation that exist
enum LottieAnimationTypes {
  /// enter in scene
  iin,

  /// exit scene
  out,

  /// pressed with mouse or finger
  pressed,

  /// hovered by mouse
  hoverIn,

  /// When hovered out by mouse
  hoverOut,

  /// The correct indication animation
  correct,

  /// Existing correct animation
  correctOut,

  /// Entering correct animation
  correctIn,

  /// Sliding horizontal animation, only used in puzzle tile
  slideHorizontal,

  /// Sliding horizontal, only used in puzzle tile
  slideVertical,
}

/// Bounds of animation
///
/// These are related to times in milliseconds
class Bounds {
  /// Main constructor
  Bounds(this.lower, this.upper);

  /// Lower bound of the animation in milliseconds
  final double lower;

  /// Upper bound of the animation in milliseconds
  final double upper;
}

/// Base class for the definition of all animations
abstract class LottieAnimation {
  /// Main constructor
  LottieAnimation({
    required this.iin,
    required this.out,
    required this.lottie,
  });

  /// File that has the animation
  final String lottie;

  /// The 'In' animation bounds in milliseconds
  /// 'in' is a reserved word 😔
  final Bounds iin;

  /// The 'Out' animation bounds in milliseconds
  final Bounds out;

  /// Returns the Bound for the animation
  Bounds getBoundByAnimationType(LottieAnimationTypes type);
}

/// Animation of Buttons
///
/// Buttons there are only 2 : Primary and Secondary
///
/// argument 'isPrimary' will define what kind of animation to show
class LottieButtonAnimation extends LottieAnimation {
  /// Main constructor
  LottieButtonAnimation({
    required Bounds iin,
    required this.hoverIn,
    required this.pressed,
    required this.hoverOut,
    required Bounds out,
    required bool isPrimary,
  }) : super(
          iin: iin,
          out: out,
          lottie: isPrimary
              ? lottieButtonPrimaryAnimationFile
              : lottieButtonSecondaryAnimationFile,
        );

  /// Bounds for animation of mouse hover in in milliseconds
  final Bounds hoverIn;

  /// Bounds for animation of pressed in milliseconds
  final Bounds pressed;

  /// Bounds for animation of mouse hover out in milliseconds
  final Bounds hoverOut;

  @override
  Bounds getBoundByAnimationType(LottieAnimationTypes type) {
    switch (type) {
      case LottieAnimationTypes.iin:
        return iin;
      case LottieAnimationTypes.out:
        return out;
      case LottieAnimationTypes.pressed:
        return pressed;
      case LottieAnimationTypes.hoverIn:
        return hoverIn;
      case LottieAnimationTypes.hoverOut:
        return hoverOut;
      case LottieAnimationTypes.correct:
      case LottieAnimationTypes.correctOut:
      case LottieAnimationTypes.correctIn:
      case LottieAnimationTypes.slideHorizontal:
      case LottieAnimationTypes.slideVertical:
        throw Exception('Animation has no animation for this type');
    }
  }
}

/// Animation of the Puzzle Tile
class LottieTilePuzzleAnimation extends LottieAnimation {
  /// Main constructor
  LottieTilePuzzleAnimation({
    required Bounds iin,
    required Bounds out,
    required this.correct,
    required this.slideHorizontal,
    required this.slideVertical,
  }) : super(
          iin: iin,
          out: out,
          lottie: lottieTileAnimationFile,
        );

  /// Bounds for animation when is correct in milliseconds
  final Bounds correct;

  /// Bounds for animation when slides horizontally in milliseconds
  final Bounds slideHorizontal;

  /// Bounds for animation when slides vertically in milliseconds
  final Bounds slideVertical;
  @override
  Bounds getBoundByAnimationType(LottieAnimationTypes type) {
    switch (type) {
      case LottieAnimationTypes.iin:
        return iin;
      case LottieAnimationTypes.out:
        return out;
      case LottieAnimationTypes.correct:
        return correct;
      case LottieAnimationTypes.slideHorizontal:
        return slideHorizontal;
      case LottieAnimationTypes.slideVertical:
        return slideVertical;

      case LottieAnimationTypes.correctOut:
      case LottieAnimationTypes.correctIn:
      case LottieAnimationTypes.pressed:
      case LottieAnimationTypes.hoverIn:
      case LottieAnimationTypes.hoverOut:
        throw Exception('Animation has no animation for this type');
    }
  }
}

/// Animation of the Puzzle Tile Hint
class LottieTileHintAnimation extends LottieAnimation {
  /// Main constructor
  LottieTileHintAnimation({
    required Bounds iin,
    required Bounds out,
    required this.correctOut,
    required this.correctIn,
    required this.correct,
  }) : super(
          iin: iin,
          out: out,
          lottie: lottieTileHintAnimationFile,
        );

  /// Bounds for animation hint is correct in milliseconds
  final Bounds correct;

  /// Bounds for animation hint is correct out in milliseconds
  final Bounds correctOut;

  /// Bounds for animation hint is correct In in milliseconds
  final Bounds correctIn;

  @override
  Bounds getBoundByAnimationType(LottieAnimationTypes type) {
    switch (type) {
      case LottieAnimationTypes.iin:
        return iin;
      case LottieAnimationTypes.out:
        return out;
      case LottieAnimationTypes.correct:
        return correct;
      case LottieAnimationTypes.correctOut:
        return correctOut;
      case LottieAnimationTypes.correctIn:
        return correctIn;
      case LottieAnimationTypes.pressed:
      case LottieAnimationTypes.hoverIn:
      case LottieAnimationTypes.hoverOut:
      case LottieAnimationTypes.slideHorizontal:
      case LottieAnimationTypes.slideVertical:
        throw Exception('Animation has no animation for this type');
    }
  }
}

/// Animation of the Star Small
class LottieStarSmallAnimation extends LottieAnimation {
  /// Main constructor
  LottieStarSmallAnimation({
    required Bounds iin,
    required Bounds out,
    required this.correct,
    required this.correctOut,
  }) : super(
          iin: iin,
          out: out,
          lottie: lottieStarAnimationFile,
        );

  /// Bounds for animation marked level as done in milliseconds
  final Bounds correct;

  /// Bounds for animation animation !correct in milliseconds
  final Bounds correctOut;
  @override
  Bounds getBoundByAnimationType(LottieAnimationTypes type) {
    switch (type) {
      case LottieAnimationTypes.iin:
        return iin;
      case LottieAnimationTypes.out:
        return out;
      case LottieAnimationTypes.correct:
        return correct;
      case LottieAnimationTypes.correctOut:
        return correctOut;
      case LottieAnimationTypes.pressed:
      case LottieAnimationTypes.hoverIn:
      case LottieAnimationTypes.hoverOut:
      case LottieAnimationTypes.correctIn:
      case LottieAnimationTypes.slideHorizontal:
      case LottieAnimationTypes.slideVertical:
        throw Exception('Animation has no animation for this type');
    }
  }
}

/// Animation of the Star Small
///
///
/// result:  Used to determine what is the result number to be presented
///
class LottieResultAnimation extends LottieAnimation {
  /// Main constructor
  LottieResultAnimation({
    required Bounds iin,
    required Bounds out,
    required int result,
  })  : assert(
          result >= 0 && result < 4,
          'Result Animation only exist 4 of them between from 0 through 3',
        ),
        super(
          iin: iin,
          out: out,
          lottie: lottieResultAnimations[result],
        );
  @override
  Bounds getBoundByAnimationType(LottieAnimationTypes type) {
    switch (type) {
      case LottieAnimationTypes.iin:
        return iin;
      case LottieAnimationTypes.out:
        return out;
      case LottieAnimationTypes.pressed:
      case LottieAnimationTypes.hoverIn:
      case LottieAnimationTypes.hoverOut:
      case LottieAnimationTypes.correct:
      case LottieAnimationTypes.correctOut:
      case LottieAnimationTypes.correctIn:
      case LottieAnimationTypes.slideHorizontal:
      case LottieAnimationTypes.slideVertical:
        throw Exception('Animation has no animation for this type');
    }
  }
}

/// All Lottie animations
class LottieAnimations {
  /// Button primary
  static final primaryButton = LottieButtonAnimation(
    iin: Bounds(0, 1000),
    hoverIn: Bounds(1000, 2000),
    pressed: Bounds(2000, 3000),
    hoverOut: Bounds(3000, 4000),
    out: Bounds(4000, 5000),
    isPrimary: true,
  );

  /// Button secondary
  static final secondaryButton = LottieButtonAnimation(
    iin: Bounds(0, 1000),
    hoverIn: Bounds(1000, 2000),
    pressed: Bounds(2000, 3000),
    hoverOut: Bounds(3000, 4000),
    out: Bounds(4000, 5000),
    isPrimary: false,
  );

  /// Tile puzzle
  static final tilePuzzle = LottieTilePuzzleAnimation(
    iin: Bounds(0, 1000),
    correct: Bounds(2000, 3000),
    slideHorizontal: Bounds(4000, 5000),
    slideVertical: Bounds(5000, 6000),
    out: Bounds(6000, 7000),
  );

  /// Tile Hint
  static final tileHint = LottieTileHintAnimation(
    iin: Bounds(0, 1000),
    out: Bounds(1000, 2000),
    correctOut: Bounds(3000, 4000),
    correctIn: Bounds(4000, 5000),
    correct: Bounds(5000, 6000),
  );

  /// Start Small
  static final starSmall = LottieStarSmallAnimation(
    iin: Bounds(0, 1000),
    out: Bounds(1000, 2000),
    correct: Bounds(3000, 4000),
    correctOut: Bounds(4000, 5000),
  );

  /// Result 0 used in the final board
  static final result0 = LottieResultAnimation(
    iin: Bounds(0, 300),
    out: Bounds(300, 400),
    result: 0,
  );

  /// Result 0 used in the final board
  static final result1 = LottieResultAnimation(
    iin: Bounds(0, 300),
    out: Bounds(300, 400),
    result: 1,
  );

  /// Result 0 used in the final board
  static final result2 = LottieResultAnimation(
    iin: Bounds(0, 300),
    out: Bounds(300, 400),
    result: 2,
  );

  /// Result 0 used in the final board
  static final result3 = LottieResultAnimation(
    iin: Bounds(0, 300),
    out: Bounds(300, 400),
    result: 3,
  );
}
