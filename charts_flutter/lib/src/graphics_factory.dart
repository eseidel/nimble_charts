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

import 'package:flutter/widgets.dart'
    show BuildContext, DefaultTextStyle, MediaQuery;
import 'package:nimble_charts/src/line_style.dart' show LineStyle;
import 'package:nimble_charts/src/text_element.dart' show TextElement;
import 'package:nimble_charts/src/text_style.dart' show TextStyle;
import 'package:nimble_charts_common/common.dart' as common
    show GraphicsFactory, LineStyle, TextElement, TextStyle;

class GraphicsFactory implements common.GraphicsFactory {
  GraphicsFactory(
    BuildContext context, {
    GraphicsFactoryHelper helper = const GraphicsFactoryHelper(),
  })  : textScaleFactor = helper.getTextScaleFactorOf(context),
        defaultTextStyle = DefaultTextStyle.of(context);
  final double textScaleFactor;
  final DefaultTextStyle defaultTextStyle;

  /// Returns a [TextStyle] object.
  @override
  common.TextStyle createTextPaint() =>
      TextStyle()..fontFamily = defaultTextStyle.style.fontFamily;

  /// Returns a text element from [text].
  @override
  common.TextElement createTextElement(String text) =>
      TextElement(text, textScaleFactor: textScaleFactor)
        ..textStyle = createTextPaint();

  @override
  common.LineStyle createLinePaint() => LineStyle();
}

/// Wraps the MediaQuery function to allow for testing.
class GraphicsFactoryHelper {
  const GraphicsFactoryHelper();

  double getTextScaleFactorOf(BuildContext context) =>
      MediaQuery.textScaleFactorOf(context);
}
