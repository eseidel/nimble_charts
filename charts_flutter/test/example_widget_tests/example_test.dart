// ignore_for_file: avoid_relative_lib_imports

import 'package:flutter_test/flutter_test.dart';
import 'package:nimble_charts/flutter.dart' as charts;

import '../../example/lib/home.dart' as h;
import '../../example/lib/main.dart' as m;
import '../test_functions.dart';

void main() {
  group('ExampleApp Widget Tests', () {
    testWidgets('Navigates to BarChart and verifies rendering', (tester) async {
      await tester.pumpWidget(m.GalleryApp());
      expect(find.byType(h.Home), findsOneWidget);
      await tester.tap(find.text('Simple Bar Chart'));
      await tester.pumpAndSettle();
      expect(find.byType(charts.BarChart), findsOneWidget);
      await tester.tap(find.byType(charts.BarChart));
      await tester.pumpAndSettle();
      await matchesGolden<charts.BarChart>('example_simple_bar_chart');
    });
  });
}
