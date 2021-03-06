import 'package:accountmanager/common_widgets/empty_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  ListItemsBuilder({
    Key? key,
    required this.data,
    required this.itemBuilder,
  }) : super(key: key);
  final AsyncValue<List<T>> data;
  final ItemWidgetBuilder<T> itemBuilder;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return data.when(
      data: (items) =>
          items.isNotEmpty ? _buildList(items) : const EmptyContent(),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      ),
    );
  }

  Widget _buildList(List<T> items) {
    final List<T> reversed = items.reversed.toList();
    return Scrollbar(
      isAlwaysShown: true,
      controller: _scrollController,
      child: ListView.separated(
        // shrinkWrap: true,
        controller: _scrollController,
        itemCount: reversed.length + 2,
        separatorBuilder: (context, index) => const Divider(height: 0.5),
        itemBuilder: (context, index) {
          if (index == 0 || index == reversed.length + 1) {
            return Container(); // zero height: not visible
          }
          return itemBuilder(context, reversed[index - 1]);
        },
      ),
    );
  }
}
