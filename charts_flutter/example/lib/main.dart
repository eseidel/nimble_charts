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

import 'package:example/app_config.dart';
import 'package:example/home.dart';
import 'package:flutter/material.dart';

bool useRandomData = true;

/// The main gallery app widget.
class GalleryApp extends StatefulWidget {
  const GalleryApp({super.key});

  @override
  GalleryAppState createState() => GalleryAppState();
}

/// The main gallery app state.
///
/// Controls performance overlay, and instantiates a [Home] widget.
class GalleryAppState extends State<GalleryApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: defaultConfig.appName,
        theme: defaultConfig.theme,
        home: Home(),
      );
}

void main() {
  runApp(const GalleryApp());
}
