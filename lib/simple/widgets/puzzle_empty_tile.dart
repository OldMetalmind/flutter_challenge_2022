import 'package:flutter/material.dart';

/// Used to represent an empty space.
///
/// Used under the puzzle and in the background in random positions
///
class PuzzleEmptyTile extends StatelessWidget {
  /// Main Constructor
  const PuzzleEmptyTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(36),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffE7E7E7),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
