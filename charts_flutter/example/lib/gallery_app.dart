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

import 'package:example/picker/tag_selection_screen.dart';
import 'package:flutter/material.dart';

/// The root widget of the application.
class GalleryApp extends StatelessWidget {
  /// Creates a [GalleryApp].
  const GalleryApp({required this.themeMode, super.key});

  /// The current theme mode of the application.
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'nimble_charts Gallery',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeMode,
        home: const TagSelectionScreen(),
      );
}
