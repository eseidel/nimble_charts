import 'package:example/picker/tag_item_selector.dart';
import 'package:example/picker/tagged_item.dart';
import 'package:flutter/material.dart';

class ChartSampleDefinition implements TaggedItem {
  ChartSampleDefinition({
    required this.build,
    required this.icon,
    required this.tags,
  });

  @override
  final List<TagDefinition> tags;
  final IconData icon;

  final Widget Function(BuildContext context, ChartSampleDefinition item) build;
}
