import 'package:example/picker/model.dart';
import 'package:example/picker/tag_item_selector.dart';
import 'package:flutter/material.dart';

class FullScreenSample extends StatelessWidget {
  const FullScreenSample({
    required this.item,
    super.key,
  });
  final ChartSampleDefinition item;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(item.title),
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              Expanded(child: _buildContent(context)),
            ],
          ),
        ),
      );

  Widget _buildHeader(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.subtitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            const SizedBox(height: 12),
            _buildTags(context),
          ],
        ),
      );

  Widget _buildTags(BuildContext context) => Wrap(
        spacing: 8,
        runSpacing: 8,
        children: item.tags.map((tag) => _buildChip(context, tag)).toList(),
      );

  Widget _buildChip(BuildContext context, TagDefinition tag) => Chip(
        label: Text(tag.display),
        avatar: Icon(tag.icon, size: 18),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      );

  Widget _buildContent(BuildContext context) => Card(
        margin: const EdgeInsets.all(16),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: item.build(context, item),
          ),
        ),
      );
}
