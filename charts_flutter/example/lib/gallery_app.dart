// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:example/main.dart';
import 'package:example/original.dart';
import 'package:example/picker/tag_selection_screen.dart';
import 'package:flutter/material.dart';

class GalleryApp extends StatelessWidget {
  const GalleryApp({super.key});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: appState,
        builder: (_, currentState, __) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: currentState.isOriginal
              ? 'Charts Gallery'
              : 'nimble_charts Gallery',
          theme: currentState.isOriginal
              ? null
              : ThemeData(
                  colorScheme: currentState.themeMode == ThemeMode.dark
                      ? ColorScheme.fromSeed(
                          seedColor: const Color.fromRGBO(0, 147, 173, 1),
                          brightness: Brightness.dark,
                        )
                      : ColorScheme.fromSeed(
                          seedColor: const Color.fromRGBO(0, 147, 173, 1),
                        ),
                ),
          darkTheme: ThemeData.dark(),
          themeMode: currentState.themeMode,
          home:
              currentState.isOriginal ? Original() : const TagSelectionScreen(),
        ),
      );
}
