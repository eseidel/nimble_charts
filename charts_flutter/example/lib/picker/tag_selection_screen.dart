import 'package:example/bar_chart/grouped_stacked.dart';
import 'package:example/bar_chart/grouped_target_line.dart';
import 'package:example/picker/tag_item_selector.dart';
import 'package:example/picker/tagged_item.dart';
import 'package:flutter/material.dart';

const tagDefinitions = <String, TagDefinition>{
  'Bar': (
    name: 'Bar',
    icon: Icons.bar_chart,
    blurb: 'Displays categorical data using rectangular bars.',
  ),
  'Line': (
    name: 'Line',
    icon: Icons.show_chart,
    blurb: 'Shows trends over time with continuous data points.',
  ),
  'Sales': (
    name: 'Sales',
    icon: Icons.attach_money,
    blurb: 'Represents sales performance and metrics.',
  ),
  'Performance': (
    name: 'Performance',
    icon: Icons.speed,
    blurb: 'Tracks key performance indicators and benchmarks.',
  ),
};

class ChartExample implements TaggedItem {
  ChartExample({required this.build, required this.icon, required this.tags});

  @override
  final List<TagDefinition> tags;
  final IconData icon;

  final Widget Function(BuildContext context, ChartExample item) build;
}

List<ChartExample> dummyItems = [
  ChartExample(
    tags: [tagDefinitions['Bar']!],
    icon: Icons.cake,
    build: (context, item) => GroupedStackedBarChart.withRandomData(),
  ),
  ChartExample(
    tags: [tagDefinitions['Bar']!],
    icon: Icons.beach_access,
    build: (context, item) => GroupedBarTargetLineChart.withRandomData(),
  ),
];

class TagSelectionScreen extends StatefulWidget {
  const TagSelectionScreen({super.key});

  @override
  State<TagSelectionScreen> createState() => _TagSelectionScreenState();
}

class _TagSelectionScreenState extends State<TagSelectionScreen> {
  final ValueNotifier<List<TagDefinition>> selectedTags =
      ValueNotifier<List<TagDefinition>>([tagDefinitions.values.first]);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Tag Selection'),
        ),
        body: TagItemSelector(
          selectedTags: selectedTags,
          builder: (context, item) => SizedBox(
            width: 350,
            height: 250,
            child: Card(
              key: ValueKey(item.hashCode),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 300, maxHeight: 200),
                    child: item.build(context, item),
                  ),
                  const SizedBox(height: 8),
                  Text(item.tags.map((t)=>t.name).join(', ')),
                ],
              ),
            ),
          ),
          items: (tags) => dummyItems
              .where(
                (item) => item.tags.any(
                  (tag) => tags.contains(tag),
                ),
              )
              .toList(),
          allTags: tagDefinitions.values.toList(),
        ),
      );
}
