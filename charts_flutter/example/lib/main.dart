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

import 'dart:developer';
import 'package:example/gallery_app.dart';
import 'package:flutter/material.dart';

import 'package:nimble_charts/flutter.dart' as charts;

typedef AppState = ({
  ThemeMode themeMode,
  bool isOriginal,
  bool useRandomData
});

extension AppStateExtension on AppState {
  AppState withThemeMode(ThemeMode themeMode) => (
        themeMode: themeMode,
        isOriginal: isOriginal,
        useRandomData: useRandomData,
      );

  AppState copyWith({
    ThemeMode? themeMode,
    bool? isOriginal,
    bool? useRandomData,
  }) =>
      (
        themeMode: themeMode ?? this.themeMode,
        isOriginal: isOriginal ?? this.isOriginal,
        useRandomData: useRandomData ?? this.useRandomData,
      );
}

final ValueNotifier<AppState> appState = ValueNotifier(
  (
    themeMode: ThemeMode.system,
    isOriginal: false,
    useRandomData: true,
  ),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ValueListenableBuilder(
      valueListenable: appState,
      builder: (_, themeMode, __) => const GalleryApp(),
    ),
  );
}

/// TODO: Use this somewhere
// ignore: unused_element
void _setupPerformance() {
  // Change [printPerformance] to true and set the app to release mode to
  // print performance numbers to console. By default, Flutter builds in debug
  // mode and this mode is slow. To build in release mode, specify the flag
  // blaze-run flag "--define flutter_build_mode=release".
  // The build target must also be an actual device and not the emulator.
  charts.Performance.time = Timeline.startSync;
  charts.Performance.timeEnd = (_) => Timeline.finishSync();
}
