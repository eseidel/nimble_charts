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
        body: TagItemSelector(
          selectedTags: selectedTags,
          builder: (context, item) {
            final tooltipContent = '''
${item.title}

${item.subtitle}

Tags: ${item.tags.map((t) => t.display).join(', ')}
''';

            return SizedBox(
              width: 350,
              height: 250,
              child: Tooltip(
                message: tooltipContent,
                child: InkWell(
                  onTap: () async => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => item.build(context, item),
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
            );
          },
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
