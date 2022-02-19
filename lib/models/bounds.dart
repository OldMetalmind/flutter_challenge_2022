import 'package:selector/helpers/animations_bounds_helper.dart';

/// Bounds of animation
///
/// These are related to times in milliseconds
class Bounds {
  /// Main constructor
  const Bounds(this.lower, this.upper)
      : assert(lower < upper, 'Needs to be lower < upper ');

  /// Lower bound of the animation in milliseconds
  final double lower;

  /// Upper bound of the animation in milliseconds
  final double upper;
}

/// Help extension to parse the full animation bound to a fraction to be used in
/// Lottie definition of an animation
extension BoundsExtension on Bounds {
  /// Calculates the fractional of the bound given the max possible value with
  /// what type of bound it has required
  double toFractional(double max, LottieBoundType type) {
    switch (type) {
      case LottieBoundType.lower:
        return lower / max;
      case LottieBoundType.upper:
        return upper / max;
    }
  }
}
