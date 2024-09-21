import 'package:example/picker/data.dart';
import 'package:example/picker/tag_item_selector.dart';
import 'package:flutter/material.dart';

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
                  Text(item.tags.map((t) => t.display).join(', ')),
                ],
              ),
            ),
          ),
          items: (tags) => chartSampleDefinitions
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
