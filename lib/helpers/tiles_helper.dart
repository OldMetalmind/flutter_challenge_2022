import 'package:selector/helpers/animations_bounds_helper.dart';
import 'package:selector/models/tile.dart';

LottieAnimationType determineAnimation(Tile? tapped, Tile? space) {
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
