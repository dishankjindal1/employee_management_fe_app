import 'package:flutter/material.dart';

class PinnedPersistentHeader extends SliverPersistentHeaderDelegate {
  final String title;

  const PinnedPersistentHeader({
    required this.title,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: Colors.grey.shade200,
      child: ListTile(
        dense: false,
        visualDensity: VisualDensity.compact,
        title: Text(
          title,
          style: DefaultTextStyle.of(context).style.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
