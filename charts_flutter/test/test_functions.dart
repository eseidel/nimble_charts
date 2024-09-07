import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> matchesGolden<T extends Widget>(
  String filename,
) async {
  if (T == Widget) throw ArgumentError('You must specify the root widget type');

  await expectLater(
    find.byType(T),
    matchesGoldenFile(
      'goldens/${filename}.png',
    ),
  );
}
