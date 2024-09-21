import 'package:example/bar_chart/grouped_stacked.dart';
import 'package:example/bar_chart/grouped_target_line.dart';
import 'package:example/picker/tag_item_selector.dart';
import 'package:example/picker/tagged_item.dart';
import 'package:flutter/material.dart';

const tagDefinitions = ['Bar', 'Line', 'Sales', 'Performance'];

class ChartExample implements TaggedItem {
  ChartExample({required this.build, required this.icon, required this.tags});

  @override
  final List<String> tags;
  final IconData icon;

  final Widget Function(BuildContext context, ChartExample item) build;
}

List<ChartExample> dummyItems = [
  ChartExample(
    tags: const ['Bar'],
    icon: Icons.cake,
    build: (context, item) => GroupedStackedBarChart.withRandomData(),
  ),
  ChartExample(
    tags: const ['Bar'],
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
  final ValueNotifier<List<String>> selectedTags =
      ValueNotifier<List<String>>([tagDefinitions.first]);

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
                  Text(item.tags.join(', ')),
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
          allTags: tagDefinitions,
        ),
      );
}
