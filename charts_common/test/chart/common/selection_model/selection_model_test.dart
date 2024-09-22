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

import 'package:nimble_charts_common/src/chart/common/processed_series.dart';
import 'package:nimble_charts_common/src/chart/common/selection_model/selection_model.dart';
import 'package:nimble_charts_common/src/chart/common/series_datum.dart';
import 'package:nimble_charts_common/src/data/series.dart';
import 'package:test/test.dart';

void main() {
  late MutableSelectionModel<String> selectionModel;

  late ImmutableSeries<String> closestSeries;
  late MyDatum closestDatumClosestSeries;
  late SeriesDatum<String> closestDatumClosestSeriesPair;
  late MyDatum otherDatumClosestSeries;
  late SeriesDatum<String> otherDatumClosestSeriesPair;

  late ImmutableSeries<String> otherSeries;
  late MyDatum closestDatumOtherSeries;
  late SeriesDatum<String> closestDatumOtherSeriesPair;
  late MyDatum otherDatumOtherSeries;
  late SeriesDatum<String> otherDatumOtherSeriesPair;

  setUp(() {
    selectionModel = MutableSelectionModel<String>();

    closestDatumClosestSeries = MyDatum('cDcS');
    otherDatumClosestSeries = MyDatum('oDcS');
    closestSeries = MutableSeries<String>(
      Series<MyDatum, String>(
        id: 'closest',
        data: [closestDatumClosestSeries, otherDatumClosestSeries],
        domainFn: (d, _) => d.id,
        measureFn: (_, __) => 0,
      ),
    );
    closestDatumClosestSeriesPair =
        SeriesDatum<String>(closestSeries, closestDatumClosestSeries);
    otherDatumClosestSeriesPair =
        SeriesDatum<String>(closestSeries, otherDatumClosestSeries);

    closestDatumOtherSeries = MyDatum('cDoS');
    otherDatumOtherSeries = MyDatum('oDoS');
    otherSeries = MutableSeries<String>(
      Series<MyDatum, String>(
        id: 'other',
        data: [closestDatumOtherSeries, otherDatumOtherSeries],
        domainFn: (d, _) => d.id,
        measureFn: (_, __) => 0,
      ),
    );
    closestDatumOtherSeriesPair =
        SeriesDatum<String>(otherSeries, closestDatumOtherSeries);
    otherDatumOtherSeriesPair =
        SeriesDatum<String>(otherSeries, otherDatumOtherSeries);
  });

  group('SelectionModel persists values', () {
    test('selection model is empty by default', () {
      expect(selectionModel.hasDatumSelection, isFalse);
      expect(selectionModel.hasSeriesSelection, isFalse);
    });

    test('all datum are selected but only the first Series is', () {
      // Select the 'closest' datum for each Series.
      selectionModel.updateSelection([
        SeriesDatum(closestSeries, closestDatumClosestSeries),
        SeriesDatum(otherSeries, closestDatumOtherSeries),
      ], [
        closestSeries,
      ]);

      expect(selectionModel.hasDatumSelection, isTrue);
      expect(selectionModel.selectedDatum, hasLength(2));
      expect(
        selectionModel.selectedDatum,
        contains(closestDatumClosestSeriesPair),
      );
      expect(
        selectionModel.selectedDatum,
        contains(closestDatumOtherSeriesPair),
      );
      expect(
        selectionModel.selectedDatum.contains(otherDatumClosestSeriesPair),
        isFalse,
      );
      expect(
        selectionModel.selectedDatum.contains(otherDatumOtherSeriesPair),
        isFalse,
      );

      expect(selectionModel.hasSeriesSelection, isTrue);
      expect(selectionModel.selectedSeries, hasLength(1));
      expect(selectionModel.selectedSeries, contains(closestSeries));
      expect(selectionModel.selectedSeries.contains(otherSeries), isFalse);
    });

    test('selection can change', () {
      // Select the 'closest' datum for each Series.
      selectionModel
        ..updateSelection([
          SeriesDatum(closestSeries, closestDatumClosestSeries),
          SeriesDatum(otherSeries, closestDatumOtherSeries),
        ], [
          closestSeries,
        ])

        // Change selection to just the other datum on the other series.
        ..updateSelection([
          SeriesDatum(otherSeries, otherDatumOtherSeries),
        ], [
          otherSeries,
        ]);

      expect(selectionModel.selectedDatum, hasLength(1));
      expect(
        selectionModel.selectedDatum,
        contains(otherDatumOtherSeriesPair),
      );

      expect(selectionModel.selectedSeries, hasLength(1));
      expect(selectionModel.selectedSeries, contains(otherSeries));
    });

    test('selection can be series only', () {
      // Select the 'closest' Series without datum to simulate legend hovering.
      selectionModel.updateSelection([], [closestSeries]);

      expect(selectionModel.hasDatumSelection, isFalse);
      expect(selectionModel.selectedDatum, hasLength(0));

      expect(selectionModel.hasSeriesSelection, isTrue);
      expect(selectionModel.selectedSeries, hasLength(1));
      expect(selectionModel.selectedSeries, contains(closestSeries));
    });

    test('selection lock prevents change', () {
      // Prevent selection changes.
      selectionModel
        ..locked = true

        // Try to the 'closest' datum for each Series.
        ..updateSelection([
          SeriesDatum(closestSeries, closestDatumClosestSeries),
          SeriesDatum(otherSeries, closestDatumOtherSeries),
        ], [
          closestSeries,
        ]);

      expect(selectionModel.hasDatumSelection, isFalse);
      expect(selectionModel.hasSeriesSelection, isFalse);

      // Allow selection changes.
      selectionModel
        ..locked = false

        // Try to the 'closest' datum for each Series.
        ..updateSelection([
          SeriesDatum(closestSeries, closestDatumClosestSeries),
          SeriesDatum(otherSeries, closestDatumOtherSeries),
        ], [
          closestSeries,
        ]);

      expect(selectionModel.hasDatumSelection, isTrue);
      expect(selectionModel.hasSeriesSelection, isTrue);

      // Prevent selection changes.
      selectionModel
        ..locked = true

        // Attempt to change selection
        ..updateSelection([
          SeriesDatum(otherSeries, otherDatumOtherSeries),
        ], [
          otherSeries,
        ]);

      // Previous selection should still be set.
      expect(selectionModel.selectedDatum, hasLength(2));
      expect(
        selectionModel.selectedDatum,
        contains(closestDatumClosestSeriesPair),
      );
      expect(
        selectionModel.selectedDatum,
        contains(closestDatumOtherSeriesPair),
      );

      expect(selectionModel.selectedSeries, hasLength(1));
      expect(selectionModel.selectedSeries, contains(closestSeries));
    });
  });

  group('SelectionModel changed listeners', () {
    test('listener triggered for change', () {
      late SelectionModel<String> triggeredModel;
      // Listen
      selectionModel
        ..addSelectionChangedListener((model) {
          triggeredModel = model;
        })

        // Set the selection to closest datum.
        ..updateSelection([
          SeriesDatum(closestSeries, closestDatumClosestSeries),
        ], [
          closestSeries,
        ]);

      // Callback should have been triggered.
      expect(triggeredModel, equals(selectionModel));
    });

    test('listener not triggered for no change', () {
      SelectionModel<String>? triggeredModel;
      // Set the selection to closest datum.
      selectionModel
        ..updateSelection([
          SeriesDatum(closestSeries, closestDatumClosestSeries),
        ], [
          closestSeries,
        ])

        // Listen
        ..addSelectionChangedListener((model) {
          triggeredModel = model;
        })

        // Try to update the model with the same value.
        ..updateSelection([
          SeriesDatum(closestSeries, closestDatumClosestSeries),
        ], [
          closestSeries,
        ]);

      // Callback should not have been triggered.
      expect(triggeredModel, isNull);
    });

    test('removed listener not triggered for change', () {
      SelectionModel<String>? triggeredModel;

      void cb(SelectionModel<String> model) {
        triggeredModel = model;
      }

      // Listen
      selectionModel
        ..addSelectionChangedListener(cb)

        // Unlisten
        ..removeSelectionChangedListener(cb)

        // Set the selection to closest datum.
        ..updateSelection([
          SeriesDatum(closestSeries, closestDatumClosestSeries),
        ], [
          closestSeries,
        ]);

      // Callback should not have been triggered.
      expect(triggeredModel, isNull);
    });
  });

  group('SelectionModel updated listeners', () {
    test('listener triggered for change', () {
      late SelectionModel<String> triggeredModel;
      // Listen
      selectionModel
        ..addSelectionUpdatedListener((model) {
          triggeredModel = model;
        })

        // Set the selection to closest datum.
        ..updateSelection([
          SeriesDatum(closestSeries, closestDatumClosestSeries),
        ], [
          closestSeries,
        ]);

      // Callback should have been triggered.
      expect(triggeredModel, equals(selectionModel));
    });

    test('listener triggered for no change', () {
      late SelectionModel<String> triggeredModel;
      // Set the selection to closest datum.
      selectionModel
        ..updateSelection([
          SeriesDatum(closestSeries, closestDatumClosestSeries),
        ], [
          closestSeries,
        ])

        // Listen
        ..addSelectionUpdatedListener((model) {
          triggeredModel = model;
        })

        // Try to update the model with the same value.
        ..updateSelection([
          SeriesDatum(closestSeries, closestDatumClosestSeries),
        ], [
          closestSeries,
        ]);

      // Callback should have been triggered.
      expect(triggeredModel, equals(selectionModel));
    });

    test('removed listener not triggered for change', () {
      SelectionModel<String>? triggeredModel;

      void cb(SelectionModel<String> model) {
        triggeredModel = model;
      }

      // Listen
      selectionModel
        ..addSelectionUpdatedListener(cb)

        // Unlisten
        ..removeSelectionUpdatedListener(cb)

        // Set the selection to closest datum.
        ..updateSelection([
          SeriesDatum(closestSeries, closestDatumClosestSeries),
        ], [
          closestSeries,
        ]);

      // Callback should not have been triggered.
      expect(triggeredModel, isNull);
    });
  });

  group('SelectionModel locked listeners', () {
    test('listener triggered when model is locked', () {
      late SelectionModel<String> triggeredModel;
      // Listen
      selectionModel
        ..addSelectionLockChangedListener((model) {
          triggeredModel = model;
        })

        // Lock selection.
        ..locked = true;

      // Callback should have been triggered.
      expect(triggeredModel, equals(selectionModel));
    });

    test('removed listener not triggered for locking', () {
      SelectionModel<String>? triggeredModel;

      void cb(SelectionModel<String> model) {
        triggeredModel = model;
      }

      // Listen
      selectionModel
        ..addSelectionLockChangedListener(cb)

        // Unlisten
        ..removeSelectionLockChangedListener(cb)

        // Lock selection.
        ..locked = true;

      // Callback should not have been triggered.
      expect(triggeredModel, isNull);
    });
  });
}

class MyDatum {
  MyDatum(this.id);
  final String id;
}
