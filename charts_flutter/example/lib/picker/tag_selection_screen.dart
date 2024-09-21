import 'package:example/main.dart';
import 'package:example/picker/data.dart';
import 'package:example/picker/full_screen_sample.dart';
import 'package:example/picker/tag_item_selector.dart';
import 'package:flutter/material.dart';

/// A screen that allows users to select tags and view corresponding charts.
class TagSelectionScreen extends StatefulWidget {
  /// Creates a [TagSelectionScreen].
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
          title: const Text('nimble_charts Gallery'),
          actions: [
            IconButton(
              icon: ValueListenableBuilder<ThemeMode>(
                valueListenable: themeNotifier,
                builder: (_, themeMode, __) => Icon(
                  themeMode == ThemeMode.light
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
              ),
              onPressed: () => themeNotifier.value =
                  themeNotifier.value == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light,
            ),
          ],
        ),
        body: TagItemSelector(
          selectedTags: selectedTags,
          builder: (context, item) => SizedBox(
            width: 350,
            height: 250,
            child: InkWell(
              onTap: () async => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenSample(item: item),
                ),
              ),
              child: Card(
                key: ValueKey(item.hashCode),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 300,
                              maxHeight: 150,
                            ),
                            child: item.build(context, item),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.subtitle,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
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
