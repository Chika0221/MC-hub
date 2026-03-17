// Flutter imports:
import 'package:flutter/material.dart';

class HasLastChildListView extends StatelessWidget {
  const HasLastChildListView({
    super.key,
    required this.itemBuilder,
    required this.separatorBuilder,
    required this.itemCount,
    required this.lastChild,
  });

  final Widget? Function(BuildContext, int) itemBuilder;
  final Widget Function(BuildContext, int) separatorBuilder;
  final int itemCount;

  final Widget lastChild;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        if (index == itemCount) {
          return lastChild;
        }
        return itemBuilder(context, index);
      },
      separatorBuilder: separatorBuilder,
      itemCount: itemCount + 1,
    );
  }
}
