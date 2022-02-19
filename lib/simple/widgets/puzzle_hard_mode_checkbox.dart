import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:selector/game/bloc/game_bloc.dart';

/// Checkbox to activate the hard mode of this game
class PuzzleHardModeCheckbox extends StatefulWidget {
  /// Main Constructor
  const PuzzleHardModeCheckbox({
    Key? key,
    this.value = false,
  }) : super(key: key);

  /// Value of the checkbox to know if it is ticked or not
  final bool value;

  @override
  State<PuzzleHardModeCheckbox> createState() => _PuzzleHardModeCheckboxState();
}

class _PuzzleHardModeCheckboxState extends State<PuzzleHardModeCheckbox> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Hard mode'),
        Checkbox(
          value: _value,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _value = value;
                context.read<GameBloc>().add(
                      UpdateHardModeEvent(value: _value),
                    );
              });
            }
          },
        ),
      ],
    );
  }
}
