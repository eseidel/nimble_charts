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

import 'package:charts_common/src/chart/cartesian/axis/spec/axis_spec.dart'
    show TextStyleSpec;
import 'package:charts_common/src/chart/common/chart_canvas.dart'
    show FillPatternType;
import 'package:charts_common/src/chart/common/datum_details.dart'
    show DomainFormatter, MeasureFormatter;
import 'package:charts_common/src/common/color.dart' show Color;
import 'package:charts_common/src/common/typed_registry.dart'
    show TypedKey, TypedRegistry;

class Series<T, D> {
  factory Series({
    required String id,
    required List<T> data,
    String? displayName,
    Color? seriesColor,
    bool overlaySeries = false,
    String? seriesCategory,
  }) {
    // Wrap typed accessors.
    dynamic domainFn(int? index) => domainFn(data[index!]);
    dynamic measureFn(int? index) => measureFn(data[index!]);
    final areaColorFn = areaColorFn == null
        ? null
        : (index) => areaColorFn(data[index!], index);
    final colorFn =
        colorFn == null ? null : (index) => colorFn(data[index!], index);
    final dashPatternFn = dashPatternFn == null
        ? null
        : (index) => dashPatternFn(data[index!], index);
    final domainFormatterFn = domainFormatterFn == null
        ? null
        : (index) => domainFormatterFn(data[index!], index);
    final domainLowerBoundFn = domainLowerBoundFn == null
        ? null
        : (index) => domainLowerBoundFn(data[index!], index);
    final domainUpperBoundFn = domainUpperBoundFn == null
        ? null
        : (index) => domainUpperBoundFn(data[index!], index);
    final fillColorFn = fillColorFn == null
        ? null
        : (index) => fillColorFn(data[index!], index);
    final patternColorFn = patternColorFn == null
        ? null
        : (index) => patternColorFn(data[index!], index);
    final fillPatternFn = fillPatternFn == null
        ? null
        : (index) => fillPatternFn(data[index!], index);
    final labelAccessorFn = labelAccessorFn == null
        ? null
        : (index) => labelAccessorFn(data[index!], index);
    final insideLabelStyleAccessorFn = insideLabelStyleAccessorFn == null
        ? null
        : (index) => insideLabelStyleAccessorFn(data[index!], index);
    final outsideLabelStyleAccessorFn = outsideLabelStyleAccessorFn == null
        ? null
        : (index) => outsideLabelStyleAccessorFn(data[index!], index);
    final measureFormatterFn = measureFormatterFn == null
        ? null
        : (index) => measureFormatterFn(data[index!], index);
    final measureLowerBoundFn = measureLowerBoundFn == null
        ? null
        : (index) => measureLowerBoundFn(data[index!], index);
    final measureUpperBoundFn = measureUpperBoundFn == null
        ? null
        : (index) => measureUpperBoundFn(data[index!], index);
    final measureOffsetFn = measureOffsetFn == null
        ? null
        : (index) => measureOffsetFn(data[index!], index);
    final radiusPxFn =
        radiusPxFn == null ? null : (index) => radiusPxFn(data[index!], index);
    final strokeWidthPxFn = strokeWidthPxFn == null
        ? null
        : (index) => strokeWidthPxFn(data[index!], index);
    final keyFn = keyFn == null ? null : (index) => keyFn(data[index!], index);

    return Series._internal(
      id: id,
      data: data,
      domainFn: domainFn,
      measureFn: measureFn,
      displayName: displayName,
      areaColorFn: areaColorFn,
      colorFn: colorFn,
      dashPatternFn: dashPatternFn,
      domainFormatterFn: domainFormatterFn,
      domainLowerBoundFn: domainLowerBoundFn,
      domainUpperBoundFn: domainUpperBoundFn,
      fillColorFn: fillColorFn,
      fillPatternFn: fillPatternFn,
      keyFn: keyFn,
      patternColorFn: patternColorFn,
      labelAccessorFn: labelAccessorFn,
      insideLabelStyleAccessorFn: insideLabelStyleAccessorFn,
      outsideLabelStyleAccessorFn: outsideLabelStyleAccessorFn,
      measureFormatterFn: measureFormatterFn,
      measureLowerBoundFn: measureLowerBoundFn,
      measureUpperBoundFn: measureUpperBoundFn,
      measureOffsetFn: measureOffsetFn,
      overlaySeries: overlaySeries,
      radiusPxFn: radiusPxFn,
      seriesCategory: seriesCategory,
      seriesColor: seriesColor,
      strokeWidthPxFn: strokeWidthPxFn,
    );
  }

  Series._internal({
    required this.id,
    required this.data,
    required this.domainFn,
    required this.measureFn,
    required this.displayName,
    required this.areaColorFn,
    required this.colorFn,
    required this.dashPatternFn,
    required this.domainFormatterFn,
    required this.domainLowerBoundFn,
    required this.domainUpperBoundFn,
    required this.fillColorFn,
    required this.fillPatternFn,
    required this.patternColorFn,
    required this.keyFn,
    required this.labelAccessorFn,
    required this.insideLabelStyleAccessorFn,
    required this.outsideLabelStyleAccessorFn,
    required this.measureFormatterFn,
    required this.measureLowerBoundFn,
    required this.measureUpperBoundFn,
    required this.measureOffsetFn,
    required this.overlaySeries,
    required this.radiusPxFn,
    required this.seriesCategory,
    required this.seriesColor,
    required this.strokeWidthPxFn,
  });
  final String id;
  final String? displayName;

  /// Overlay series provided supplemental information on a chart, but are not
  /// considered to be primary data. They should not be selectable by user
  /// interaction.
  final bool overlaySeries;

  final String? seriesCategory;

  /// Color which represents the entire series in legends.
  ///
  /// If this is not provided in the original series object, it will be inferred
  /// from the color of the first datum in the series.
  ///
  /// If this is provided, but no [colorFn] is provided, then it will be treated
  /// as the color for each datum in the series.
  ///
  /// If neither are provided, then the chart will insert colors for each series
  /// on the chart using a mapping function.
  final Color? seriesColor;

  final List<T> data;

  /// [keyFn] defines a globally unique identifier for each datum.
  ///
  /// The key for each datum is used during chart animation to smoothly
  /// transition data still in the series to its new state.
  ///
  /// Note: This is currently an optional function that is not fully used by all
  /// series renderers yet.
  final AccessorFn<String>? keyFn;

  final AccessorFn<D> domainFn;
  final AccessorFn<DomainFormatter<D>>? domainFormatterFn;
  final AccessorFn<D?>? domainLowerBoundFn;
  final AccessorFn<D?>? domainUpperBoundFn;
  final AccessorFn<num?> measureFn;
  final AccessorFn<MeasureFormatter>? measureFormatterFn;
  final AccessorFn<num?>? measureLowerBoundFn;
  final AccessorFn<num?>? measureUpperBoundFn;
  final AccessorFn<num>? measureOffsetFn;

  /// [areaColorFn] returns the area color for a given data value. If not
  /// provided, then some variation of the main [colorFn] will be used (e.g.
  /// 10% opacity).
  ///
  /// This color is used for supplemental information on the series, such as
  /// confidence intervals or area skirts.
  final AccessorFn<Color>? areaColorFn;

  /// [colorFn] returns the rendered stroke color for a given data value.
  ///
  /// If this is not provided, then [seriesColor] will be used for every datum.
  ///
  /// If neither are provided, then the chart will insert colors for each series
  /// on the chart using a mapping function.
  final AccessorFn<Color>? colorFn;

  /// [dashPatternFn] returns the dash pattern for a given data value.
  final AccessorFn<List<int>?>? dashPatternFn;

  /// [fillColorFn] returns the rendered fill color for a given data value. If
  /// not provided, then [colorFn] will be used as a fallback.
  final AccessorFn<Color?>? fillColorFn;

  /// [patternColorFn] returns the background color of tile when a
  /// [FillPatternType] beside `solid` is used. If not provided, then
  /// background color is used.
  final AccessorFn<Color>? patternColorFn;

  final AccessorFn<FillPatternType>? fillPatternFn;
  final AccessorFn<num>? radiusPxFn;
  final AccessorFn<num?>? strokeWidthPxFn;
  final AccessorFn<String>? labelAccessorFn;
  final AccessorFn<TextStyleSpec>? insideLabelStyleAccessorFn;
  final AccessorFn<TextStyleSpec>? outsideLabelStyleAccessorFn;

  // TODO: should this be immutable as well? If not, should any of
  // the non-required ones be final?
  final SeriesAttributes attributes = SeriesAttributes();

  void setAttribute<R>(AttributeKey<R> key, R value) {
    attributes.setAttr(key, value);
  }

  R? getAttribute<R>(AttributeKey<R> key) => attributes.getAttr<R>(key);
}

/// Computed property on series.
///
/// If the [index] argument is `null`, the accessor is asked to provide a
/// property of [series] as a whole. Accessors are not required to support
/// such usage.
///
/// Otherwise, [index] must be a valid subscript into a list of `series.length`.
typedef AccessorFn<R> = R Function(int? index);

typedef TypedAccessorFn<T, R> = R Function(T datum, int? index);

class AttributeKey<R> extends TypedKey<R> {
  const AttributeKey(super.uniqueKey);
}

class SeriesAttributes extends TypedRegistry {}
