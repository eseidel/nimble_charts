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

import 'dart:ui' as ui;

import 'package:nimble_charts/flutter.dart';
import 'package:nimble_charts_common/common.dart' as common show Color;

// ignore: avoid_classes_with_only_static_members
/// Utility class for converting between common and Flutter colors.
class ColorUtil {
  /// Converts a common color to a Flutter color.
  static ui.Color toDartColor(common.Color color) => color.toDartColor();

  /// Converts a Flutter color to a common color.
  static common.Color fromDartColor(ui.Color color) => color.fromDartColor();
}

/// Extension methods for common colors.
extension ColorExtensions on Color {
  /// Converts a common color to a Flutter color.
  ui.Color toDartColor() => ui.Color.fromARGB(a, r, g, b);

  /// Returns a new color with the alpha channel multiplied by the given value.
  Color withAlpha(double alpha) => Color(
        r: r,
        g: g,
        b: b,
        a: (a * alpha).round(),
      );
}

/// Extension methods for Flutter colors.
extension UIColorExtensions on ui.Color {
  /// Converts a Flutter color to a common color.
  common.Color fromDartColor() => common.Color(
        r: red,
        g: green,
        b: blue,
        a: alpha,
      );
}
