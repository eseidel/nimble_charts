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

import 'dart:math' show min;
import 'package:flutter/widgets.dart';

/// Strategy for building legend from legend entry widgets.
abstract class LegendLayout {
  Widget build(BuildContext context, List<Widget> legendEntryWidgets);
}

/// Layout legend entries in tabular format.
class TabularLegendLayout implements LegendLayout {
  TabularLegendLayout._internal({
    required this.isHorizontalFirst,
    required this.desiredMaxRows,
    required this.desiredMaxColumns,
    this.cellPadding,
  });

  /// Layout horizontally until columns exceed [desiredMaxColumns].
  ///
  /// [desiredMaxColumns] the max columns to use before laying out items in a
  /// new row. By default there is no limit. The max columns created is the
  /// smaller of desiredMaxColumns and number of legend entries.
  ///
  /// [cellPadding] the [EdgeInsets] for each widget.
  factory TabularLegendLayout.horizontalFirst({
    int? desiredMaxColumns,
    EdgeInsets? cellPadding,
  }) =>
      TabularLegendLayout._internal(
        isHorizontalFirst: true,
        desiredMaxRows: _noLimit,
        desiredMaxColumns: desiredMaxColumns ?? _noLimit,
        cellPadding: cellPadding,
      );

  /// Layout vertically, until rows exceed [desiredMaxRows].
  ///
  /// [desiredMaxRows] the max rows to use before layout out items in a new
  /// column. By default there is no limit. The max columns created is the
  /// smaller of desiredMaxRows and number of legend entries.
  ///
  /// [cellPadding] the [EdgeInsets] for each widget.
  factory TabularLegendLayout.verticalFirst({
    int? desiredMaxRows,
    EdgeInsets? cellPadding,
  }) =>
      TabularLegendLayout._internal(
        isHorizontalFirst: false,
        desiredMaxRows: desiredMaxRows ?? _noLimit,
        desiredMaxColumns: _noLimit,
        cellPadding: cellPadding,
      );

  /// No limit for max rows or max columns.
  static const _noLimit = -1;

  /// Default EdgeInsets for padding rows to the max column count
  static const defaultCellPadding = EdgeInsets.all(8);

  final bool isHorizontalFirst;
  final int desiredMaxRows;
  final int desiredMaxColumns;
  final EdgeInsets? cellPadding;

  @override
  Widget build(BuildContext context, List<Widget> legendEntries) {
    final paddedLegendEntries = ((cellPadding == null)
        ? legendEntries
        : legendEntries
            .map((entry) => Padding(padding: cellPadding!, child: entry))
            .toList());

    return isHorizontalFirst
        ? _buildHorizontalFirst(paddedLegendEntries)
        : _buildVerticalFirst(paddedLegendEntries);
  }

  @override
  bool operator ==(Object other) =>
      other is TabularLegendLayout &&
      desiredMaxRows == other.desiredMaxRows &&
      desiredMaxColumns == other.desiredMaxColumns &&
      isHorizontalFirst == other.isHorizontalFirst &&
      cellPadding == other.cellPadding;

  @override
  int get hashCode => hashValues(
        desiredMaxRows,
        desiredMaxColumns,
        isHorizontalFirst,
        cellPadding,
      );

  Widget _buildHorizontalFirst(List<Widget> legendEntries) {
    final maxColumns = (desiredMaxColumns == _noLimit)
        ? legendEntries.length
        : min(legendEntries.length, desiredMaxColumns);

    final rows = <TableRow>[];
    for (var i = 0; i < legendEntries.length; i += maxColumns) {
      rows.add(
        TableRow(
          children: legendEntries
              .sublist(i, min(i + maxColumns, legendEntries.length))
              .toList(),
        ),
      );
    }

    return _buildTableFromRows(rows);
  }

  Widget _buildVerticalFirst(List<Widget> legendEntries) {
    //TODO: Fix
    throw UnimplementedError(
      'This code is trying to append an unmodifiable list in TableRow',
    );

    // final maxRows = (desiredMaxRows == _noLimit)
    //     ? legendEntries.length
    //     : min(legendEntries.length, desiredMaxRows);

    // final rows = List.generate(maxRows, (_) => const TableRow());

    // for (var i = 0; i < legendEntries.length; i++) {
    //   children here is unmodifiable. How did this work in the first place?
    //   rows[i % maxRows].children.add(legendEntries[i]);
    // }

    // return _buildTableFromRows(rows);
  }

  Table _buildTableFromRows(List<TableRow> rows) {
    final padWidget = Padding(padding: cellPadding ?? defaultCellPadding);

    // Pad rows to the max column count, because each TableRow in a table is
    // required to have the same number of children.
    final columnCount = rows
        .map((r) => r.children.length)
        .fold<int>(0, (max, current) => (current > max) ? current : max);

    for (var i = 0; i < rows.length; i++) {
      final rowChildren = rows[i].children;
      final padCount = columnCount - rowChildren.length;
      if (padCount > 0) {
        rowChildren
            .addAll(Iterable<Padding>.generate(padCount, (_) => padWidget));
      }
    }

    // TODO: Investigate other means of creating the tabular legend
    // Sizing the column width using [IntrinsicColumnWidth] is expensive per
    // Flutter's documentation, but has to be used if the table is desired to
    // have a width that is tight on each column.
    return Table(
      children: rows,
      defaultColumnWidth: const IntrinsicColumnWidth(),
    );
  }
}
