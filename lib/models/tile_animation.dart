import 'package:selector/assets/constants.dart';
import 'package:selector/helpers/animation_helper.dart';
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
  LottieAnimationTypes animation;

  /// File used in all tile animations
  static const String file = lottieTileAnimationFile;

  /// Getter of lottie animation file
  String get animationFile => file;

  static LottieAnimationTypes _determineAnimation(Tile? tapped, Tile? space) {
    assert(space?.isWhitespace ?? false, 'Space should be the whitespace Tile');

    if (tapped != null && space != null) {
      if (tapped.currentPosition.x < space.currentPosition.x) {
        return LottieAnimationTypes.slideHorizontal;
      }

      if (tapped.currentPosition.y < space.currentPosition.y) {
        return LottieAnimationTypes.slideVertical;
      }
    }

    return LottieAnimationTypes.iin;
  }
}
