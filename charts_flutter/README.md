# nimble_charts: charts_flutter Resurrected

This project is a resurrection of the discontinued [Google Charts Flutter library](https://github.com/google/charts). It aims to provide a maintained and updated version of the popular charting package for Flutter developers.

nimble_charts is a fork of the original [charts_flutter](https://pub.dev/packages/charts_flutter) library. It has been renamed, and [Nimblesite](https://www.nimblesite.co/) now maintains it. While the package name has changed, we continue to honor the original Apache 2.0 license and attribute the original work to the original Google team.

[![build_and_test](https://github.com/Nimblesite/nimble_charts/actions/workflows/build_and_test.yml/badge.svg)](https://github.com/Nimblesite/nimble_charts/actions/workflows/build_and_test.yml)

## 🚀 Live Demo

Check out the [live WASM web app demo](https://nimblesite.github.io/nimble_charts/) to see the charts in action!

This is the original example app, running in a browser with WASM.

## 📊 Features

- A wide variety of chart types
- Customizable appearance and behavior
- Flutter-native implementation
- Supports both mobile and web platforms
 
## 🛠️ Installation

Add the following to your `pubspec.yaml`:

nimble_charts: ^0.1.0-beta

## 📝 Usage

Here's a quick example of how to create a simple line chart:

```dart
import 'package:nimble_charts/flutter.dart' as charts;

// ... in your widget build method:
charts.LineChart(
 [
 charts.Series<LinearSales, int>(
 id: 'Sales',
 colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
 domainFn: (LinearSales sales, _) => sales.year,
 measureFn: (LinearSales sales, _) => sales.sales,
 data: [
        LinearSales(0, 5),
        LinearSales(1, 25),
        LinearSales(2, 100),
        LinearSales(3, 75),
 ],
 )
 ],
)
```

For more examples and detailed documentation, please refer to the package documentation.

## ⚖️ License
This project is a continuation of the original Google Charts library and maintains the same Apache 2.0 license. We are committed to honoring the original licenses and attributions. For full license details, please see the LICENSE file.

## What Has Changed?

The Fork occurred at 0.12.0 of the original charts_flutter

- Migrated all packages to Flutter V3
- Overhauled the code in an attempt to keep the same functionality. 
- Uses the [austerity](https://pub.dev/packages/austerity) package to apply hotfixes and bring type safety to the code.
- While the package may gain new features, we will attempt to keep the functionality in line with the original wherever possible.
- We had to disable many existing tests, but we are working on new widget and integration tests to fill the gap. We will also resurrect many of the old tests when time permits. Until there is sufficient test coverage, the package will remain in beta.

## 🤝 Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## 📣 Acknowledgements
This project would not be possible without the original work done by the Google Charts team. We express our gratitude for their efforts in creating such a valuable library for the Flutter community.

All chart packages are licensed under the Apache 2 license, see the
[LICENSE](LICENSE) and [AUTHORS](AUTHORS) files for details.