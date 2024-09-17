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

import 'package:example/gallery_scaffold.dart';
import 'package:example/pie_chart/partial_pie.dart';
import 'package:example/pie_chart/simple.dart';
import 'package:flutter/material.dart';

List<GalleryScaffold> buildGallery() => [
      const GalleryScaffold(
        listTileIcon: Icon(Icons.pie_chart),
        title: 'Simple Pie Chart',
        subtitle: 'With a single series',
        childBuilder: SimplePieChart.withRandomData,
      ),
      //TODO:
      // new GalleryScaffold(
      //   listTileIcon: new Icon(Icons.pie_chart),
      //   title: 'Outside Label Pie Chart',
      //   subtitle: 'With a single series and labels outside the arcs',
      //   childBuilder: () => new PieOutsideLabelChart.withRandomData(),
      // ),
      const GalleryScaffold(
        listTileIcon: Icon(Icons.pie_chart),
        title: 'Partial Pie Chart',
        subtitle: "That doesn't cover a full revolution",
        childBuilder: PartialPieChart.withRandomData,
      ),
      //TODO:
      // new GalleryScaffold(
      //   listTileIcon: new Icon(Icons.pie_chart),
      //   title: 'Simple Donut Chart',
      //   subtitle: 'With a single series and a hole in the middle',
      //   childBuilder: () => new DonutPieChart.withRandomData(),
      // ),
      // new GalleryScaffold(
      //   listTileIcon: new Icon(Icons.pie_chart),
      //   title: 'Auto Label Donut Chart',
      //   subtitle:
      //       'With a single series, a hole in the middle, '
      //'and auto-positioned labels',
      //   childBuilder: () => new DonutAutoLabelChart.withRandomData(),
      // ),
      // new GalleryScaffold(
      //   listTileIcon: new Icon(Icons.pie_chart),
      //   title: 'Gauge Chart',
      //   subtitle: 'That doesn\'t cover a full revolution',
      //   childBuilder: () => new GaugeChart.withRandomData(),
      // ),
    ];
