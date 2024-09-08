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

import 'dart:math' show Rectangle;
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';
import 'package:nimble_charts/flutter.dart';
import 'package:nimble_charts/src/chart_canvas.dart' as cc;
import 'package:nimble_charts/src/graphics_factory.dart' as gf;
import 'package:nimble_charts_common/common.dart' as common;

/// Flutter widget responsible for painting a common SymbolRenderer from the
/// chart.
///
/// If you want to customize the symbol, then use [CustomSymbolRenderer].
class SymbolRendererCanvas implements SymbolRendererBuilder {
  SymbolRendererCanvas(this.commonSymbolRenderer, this.dashPattern);
  final common.SymbolRenderer commonSymbolRenderer;
  final List<int>? dashPattern;

  @override
  Widget build(
    BuildContext context, {
    required Size size,
    common.Color? color,
    bool enabled = true,
  }) {
    if (color != null && !enabled) {
      color = common.Color(
        r: color.r,
        g: color.g,
        b: color.b,
        a: (color.a * 0.26).round(),
      );
    }

    return SizedBox.fromSize(
      size: size,
      child: CustomPaint(
        painter: _SymbolCustomPaint(
          context,
          commonSymbolRenderer,
          ui.Color.fromARGB(
            color?.a ?? 255,
            color?.r ?? 0,
            color?.g ?? 0,
            color?.b ?? 0,
          ),
          dashPattern,
        ),
      ),
    );
  }
}

/// Convenience class allowing you to pass your Widget builder through the
/// common chart so that it is created for you by the Legend.
///
/// This allows a custom SymbolRenderer in Flutter without having to create
/// a completely custom legend.
abstract class CustomSymbolRenderer extends common.SymbolRenderer
    implements SymbolRendererBuilder {
  CustomSymbolRenderer() : super(isSolid: false);

  /// Must override this method to build the custom Widget with the given color
  /// as
  @override
  Widget build(
    BuildContext context, {
    required Size size,
    Color? color,
    bool enabled = true,
  });

  @override
  void paint(
    common.ChartCanvas canvas,
    Rectangle<num> bounds, {
    List<int>? dashPattern,
    common.Color? fillColor,
    common.FillPatternType? fillPattern,
    common.Color? strokeColor,
    double? strokeWidthPx,
  }) {
    // Intentionally ignored (never called).
  }

  @override
  bool shouldRepaint(common.SymbolRenderer oldRenderer) =>
      false; // Repainting is handled directly in Flutter.
}

/// Common interface for [CustomSymbolRenderer] & [SymbolRendererCanvas] for
/// convenience for [LegendEntryLayout].
abstract class SymbolRendererBuilder {
  Widget build(
    BuildContext context, {
    required Size size,
    Color? color,
    bool enabled,
  });
}

/// The Widget which fulfills the guts of [SymbolRendererCanvas] actually
/// painting the symbol to a canvas using [CustomPainter].
class _SymbolCustomPaint extends CustomPainter {
  _SymbolCustomPaint(
    this.context,
    this.symbolRenderer,
    this.color,
    this.dashPattern,
  );
  final BuildContext context;
  final common.SymbolRenderer symbolRenderer;
  final ui.Color? color;
  final List<int>? dashPattern;

  @override
  void paint(Canvas canvas, Size size) {
    final bounds =
        Rectangle<num>(0, 0, size.width.toInt(), size.height.toInt());
    final commonColor = color == null
        ? null
        : common.Color(
            r: color!.red,
            g: color!.green,
            b: color!.blue,
            a: color!.alpha,
          );
    symbolRenderer.paint(
      cc.ChartCanvas(canvas, gf.GraphicsFactory(context)),
      bounds,
      fillColor: commonColor,
      strokeColor: commonColor,
      dashPattern: dashPattern,
    );
  }

  @override
  bool shouldRepaint(_SymbolCustomPaint oldDelegate) =>
      symbolRenderer.shouldRepaint(oldDelegate.symbolRenderer);
}
