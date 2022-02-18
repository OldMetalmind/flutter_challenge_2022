import 'package:selector/assets/constants.dart';
import 'package:selector/helpers/animations_bounds_helper.dart';
import 'package:selector/models/tile.dart';

/// Model assistant for animation
class TileAnimation {
  /// Basic constructor
  TileAnimation(this.animation);

  /// Constructor based on the tiles passes
  TileAnimation.fromTiles(
    Tile? tapped,
    Tile? space,
  ) : this(
          _determineAnimation(tapped, space),
        );

  /// What is the state of this tile
  LottieAnimationType animation;

  /// File used in all tile animations
  static const String file = lottieTileAnimationFile;

  /// Getter of lottie animation file
  String get animationFile => file;

  static LottieAnimationType _determineAnimation(Tile? tapped, Tile? space) {
    assert(space?.isWhitespace ?? false, 'Space should be the whitespace Tile');

    if (tapped != null && space != null) {
      if (tapped.currentPosition.x < space.currentPosition.x) {
        return LottieAnimationType.slideHorizontal;
      }

      if (tapped.currentPosition.y < space.currentPosition.y) {
        return LottieAnimationType.slideVertical;
      }
    }

    return LottieAnimationType.iin;
  }
}
