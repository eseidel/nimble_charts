// Copyright 2021 the Charts project authors. Please see the AUTHORS file
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

import 'dart:math' show Point, Rectangle;

import 'package:charts_common/common.dart' show Color, Link, LinkOrientation;
import 'package:charts_common/src/chart/common/chart_canvas.dart';
import 'package:charts_common/src/chart/common/datum_details.dart';
import 'package:charts_common/src/chart/common/processed_series.dart';
import 'package:charts_common/src/chart/common/series_datum.dart';
import 'package:charts_common/src/chart/common/series_renderer.dart';
import 'package:charts_common/src/chart/link/link_renderer_config.dart';
import 'package:charts_common/src/common/math.dart' show NullablePoint;
import 'package:charts_common/src/data/series.dart' show AttributeKey;

const linkElementsKey =
    AttributeKey<List<LinkRendererElement>>('LinkRenderer.elements');

class LinkRenderer<D> extends BaseSeriesRenderer<D> {
  factory LinkRenderer({String? rendererId, LinkRendererConfig<D>? config}) =>
      LinkRenderer._internal(
        rendererId: rendererId ?? defaultRendererID,
        config: config ?? LinkRendererConfig(),
      );

  LinkRenderer._internal({required super.rendererId, required this.config})
      : super(
          layoutPaintOrder: config.layoutPaintOrder,
          symbolRenderer: config.symbolRenderer,
        );

  /// Default renderer ID for the Sankey Chart
  static const defaultRendererID = 'sankey';

  // List of renderer elements to be drawn on the canvas
  final _seriesLinkMap = <String, List<LinkRendererElement>>{};

  /// Link Renderer Config
  final LinkRendererConfig<D> config;

  @override
  void preprocessSeries(List<MutableSeries<D>> seriesList) {
    for (final series in seriesList) {
      final elements = <LinkRendererElement>[];
      for (var linkIndex = 0; linkIndex < series.data.length; linkIndex++) {
        final element = LinkRendererElement(
          series.data[linkIndex].link,
          series.data[linkIndex].orientation,
          series.data[linkIndex].fillColor,
        );
        elements.add(element);
      }
      series.setAttr(linkElementsKey, elements);
    }
  }

  @override
  void update(List<ImmutableSeries<D>> seriesList, bool isAnimating) {
    for (final series in seriesList) {
      final elementsList = series.getAttr(linkElementsKey)!;
      _seriesLinkMap.putIfAbsent(series.id, () => elementsList);
    }
  }

  @override
  void paint(ChartCanvas canvas, double animationPercent) {
    /// Paint the renderer elements on the canvas using drawLink.
    _seriesLinkMap.forEach((k, v) => _drawAllLinks(v, canvas));
  }

  void _drawAllLinks(List<LinkRendererElement> links, ChartCanvas canvas) {
    for (final element in links) {
      canvas.drawLink(element.link, element.orientation, element.fillColor);
    }
  }

  @override
  DatumDetails<D> addPositionToDetailsForSeriesDatum(
    DatumDetails<D> details,
    SeriesDatum<D> seriesDatum,
  ) {
    const chartPosition = Point<double>(0, 0);
    return DatumDetails.from(
      details,
      chartPosition: NullablePoint.from(chartPosition),
    );
  }

  /// Datum details of nearest link.
  @override
  List<DatumDetails<D>> getNearestDatumDetailPerSeries(
    Point<double> chartPoint,
    bool byDomain,
    Rectangle<int>? boundsOverride, {
    bool selectOverlappingPoints = false,
    bool selectExactEventLocation = false,
  }) =>
      <DatumDetails<D>>[];
}

class LinkRendererElement {
  LinkRendererElement(this.link, this.orientation, this.fillColor);
  final Link link;
  final LinkOrientation orientation;
  final Color fillColor;
}
