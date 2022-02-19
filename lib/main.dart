// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:selector/app/app.dart';
import 'package:selector/bootstrap.dart';
import 'package:selector/game/bloc/game_bloc.dart';

/// Global logger
Logger logger = Logger();

void main() {
  bootstrap(
    () => BlocProvider(
      create: (context) => GameBloc(),
      child: const App(),
    ),
  );
}
