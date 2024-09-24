# nimble_charts: charts_flutter Resurrected

![Charts Sample](https://github.com/Nimblesite/nimble_charts/blob/main/charts.gif)

This project is a resurrection of the discontinued [charts_flutter](https://pub.dev/packages/charts_flutter). It aims to provide a robust and flexible charting package for Flutter developers.
[Nimblesite](https://www.nimblesite.co/) now maintains this library. While the package name has changed, we continue to honor the original Apache 2.0 license and attribute the original work to the original Google team.

[![build_and_test](https://github.com/Nimblesite/nimble_charts/actions/workflows/build_and_test.yml/badge.svg)](https://github.com/Nimblesite/nimble_charts/actions/workflows/build_and_test.yml)

## 🚀 Live Demo

Check out the [live WASM web app demo](https://nimblesite.github.io/nimble_charts/) to see the charts in action!

This is the original example app, running in a browser with WASM.

## 📊 Features

- A wide variety of chart types
- Customizable appearance and behavior
- Flutter-native implementation
- Supports both mobile and web platforms
- Improved documentation and extensive samples

## 🛠️ Installation

Add the following to your `pubspec.yaml`:

nimble_charts: ^0.3.0-beta

## 📝 Usage

This is a full app with a basic line chart.

```dart
import 'package:flutter/material.dart';
import 'package:nimble_charts/flutter.dart';

typedef LinearSales = ({int year, int sales});

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: LineChart(
                  [
                    Series<LinearSales, int>(
                      id: 'Sales',
                      colorFn: (_, __) => MaterialPalette.purple.shadeDefault,
                      domainFn: (sales, _) => sales.year,
                      measureFn: (sales, _) => sales.sales,
                      data: [
                        (year: 0, sales: 5),
                        (year: 1, sales: 25),
                        (year: 2, sales: 100),
                        (year: 3, sales: 75),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
```

For more examples and detailed documentation, please refer to the example app and documentation.

## ⚖️ License
This project is a continuation of the original Google Charts library and maintains the same Apache 2.0 license. We are committed to honoring the original licenses and attributions. For full license details, please see the LICENSE file.

This project would not be possible without the original work done by the Google Charts team. We express our gratitude for their efforts in creating such a valuable library for the Flutter community.

All chart packages are licensed under the Apache 2 license, see the
[LICENSE](LICENSE) and [AUTHORS](AUTHORS) files for details.

## Running the Tests

There are many widget tests for the example app. Each of the widget tests create golden files. These golden files are generated with GitHub actions on Linux so they will always be slightly different to your local machine. If you want to run the tests locally, you need to run the following command:

```bash
flutter test --update-goldens
```

Please don't commit goldens in PRs. We will merge your branch to a temporary branch and then run the `generate_goldens.yaml` action to generate the goldens. If there are changes in the goldens, they will show up in the PR.

## What Has Changed?

The Fork occurred at 0.12.0 of the original charts_flutter

- Migrated all packages to Flutter V3
- Overhauled the code in an attempt to keep the same functionality. 
- Uses the [austerity](https://pub.dev/packages/austerity) package to apply hotfixes and bring type safety to the code.
- While the package may gain new features, we will attempt to keep the functionality in line with the original wherever possible.
- We had to disable many existing tests, but we are working on new widget and integration tests to fill the gap. We will also resurrect many of the old tests when time permits. Until there is sufficient test coverage, the package will remain in beta.

## 🤝 Contributing
Contributions are welcome! Please feel free to submit a Pull Request.
