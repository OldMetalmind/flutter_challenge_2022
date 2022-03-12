import 'package:flutter/cupertino.dart';

/// Named route for Homepage
const String pageHome = '/';

/// Named route for GamePage
const String pageGame = '/game';

/// Named route for FinishPage
const String pageFinish = '/finish';

/// Helper class to wrap [Navigator] to be easier to call the needed navigation
class PuzzleNavigator {
  /// Navigates to the last success page of the Puzzle
  static void navigateToFinish(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      pageFinish,
    );
  }

  /// Navigates to the game page
  static void navigateToGame(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      pageGame,
    );
  }

  /// Navigates to the home page
  static void navigateToHome(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      pageHome,
    );
  }
}
