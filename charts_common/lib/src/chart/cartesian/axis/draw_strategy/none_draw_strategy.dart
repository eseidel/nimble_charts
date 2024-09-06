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

import 'dart:math';

import 'package:charts_common/src/chart/cartesian/axis/axis.dart'
    show AxisOrientation;
import 'package:charts_common/src/chart/cartesian/axis/collision_report.dart'
    show CollisionReport;
import 'package:charts_common/src/chart/cartesian/axis/draw_strategy/tick_draw_strategy.dart';
import 'package:charts_common/src/chart/cartesian/axis/spec/axis_spec.dart'
    show LineStyleSpec, RenderSpec;
import 'package:charts_common/src/chart/cartesian/axis/tick.dart' show Tick;
import 'package:charts_common/src/chart/common/chart_canvas.dart'
    show ChartCanvas;
import 'package:charts_common/src/chart/common/chart_context.dart'
    show ChartContext;
import 'package:charts_common/src/chart/layout/layout_view.dart'
    show ViewMeasuredSizes;
import 'package:charts_common/src/common/color.dart' show Color;
import 'package:charts_common/src/common/graphics_factory.dart'
    show GraphicsFactory;
import 'package:charts_common/src/common/line_style.dart' show LineStyle;
import 'package:charts_common/src/common/style/style_factory.dart'
    show StyleFactory;
import 'package:charts_common/src/common/text_style.dart' show TextStyle;
import 'package:meta/meta.dart' show immutable;

/// Renders no ticks no labels, and claims no space in layout.
/// However, it does render the axis line if asked to by the axis.
@immutable
class NoneRenderSpec<D> extends RenderSpec<D> {
  const NoneRenderSpec({this.axisLineStyle});
  final LineStyleSpec? axisLineStyle;

  @override
  TickDrawStrategy<D> createDrawStrategy(
    ChartContext context,
    GraphicsFactory graphicFactory,
  ) =>
      NoneDrawStrategy<D>(
        graphicFactory,
        axisLineStyleSpec: axisLineStyle,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NoneRenderSpec;

  @override
  int get hashCode => 0;
}

class NoneDrawStrategy<D> implements TickDrawStrategy<D> {
  NoneDrawStrategy(
    GraphicsFactory graphicsFactory, {
    LineStyleSpec? axisLineStyleSpec,
  })  : axisLineStyle = StyleFactory.style
            .createAxisLineStyle(graphicsFactory, axisLineStyleSpec),
        noneTextStyle = graphicsFactory.createTextPaint()
          ..color = Color.transparent
          ..fontSize = 0;
  LineStyle axisLineStyle;
  TextStyle noneTextStyle;

  @override
  void updateTickWidth(
    List<Tick<D>> ticks,
    int maxWidth,
    int maxHeight,
    AxisOrientation orientation, {
    bool collision = false,
  }) {}

  @override
  CollisionReport<D> collides(
    List<Tick<D>>? ticks,
    AxisOrientation? orientation,
  ) =>
      CollisionReport(ticksCollide: false, ticks: ticks);

  @override
  void decorateTicks(List<Tick<D>> ticks) {
    // Even though no text is rendered, the text style for each element should
    // still be set to handle the case of the draw strategy being switched to
    // a different draw strategy. The new draw strategy will try to animate
    // the old ticks out and the text style property is used.
    for (final tick in ticks) {
      tick.textElement!.textStyle = noneTextStyle;
    }
  }

  @override
  void drawAxisLine(
    ChartCanvas canvas,
    AxisOrientation orientation,
    Rectangle<int> axisBounds,
  ) {
    Point<num> start;
    Point<num> end;

    switch (orientation) {
      case AxisOrientation.top:
        start = axisBounds.bottomLeft;
        end = axisBounds.bottomRight;

      case AxisOrientation.bottom:
        start = axisBounds.topLeft;
        end = axisBounds.topRight;
      case AxisOrientation.right:
        start = axisBounds.topLeft;
        end = axisBounds.bottomLeft;
      case AxisOrientation.left:
        start = axisBounds.topRight;
        end = axisBounds.bottomRight;
    }

    canvas.drawLine(
      points: [start, end],
      dashPattern: axisLineStyle.dashPattern,
      fill: axisLineStyle.color,
      stroke: axisLineStyle.color,
      strokeWidthPx: axisLineStyle.strokeWidth.toDouble(),
    );
  }

  @override
  void draw(
    ChartCanvas canvas,
    Tick<D> tick, {
    required AxisOrientation orientation,
    required Rectangle<int> axisBounds,
    required Rectangle<int> drawAreaBounds,
    required bool isFirst,
    required bool isLast,
    bool collision = false,
  }) {}

  @override
  ViewMeasuredSizes measureHorizontallyDrawnTicks(
    List<Tick<D>> ticks,
    int maxWidth,
    int maxHeight, {
    bool collision = false,
  }) =>
      ViewMeasuredSizes.zero;

  @override
  ViewMeasuredSizes measureVerticallyDrawnTicks(
    List<Tick<D>> ticks,
    int maxWidth,
    int maxHeight, {
    bool collision = false,
  }) =>
      ViewMeasuredSizes.zero;
}
