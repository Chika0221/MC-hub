// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:win32/win32.dart';

// Project imports:
import 'package:mc_hub/models/workflow.dart';

class ActionContainer extends HookConsumerWidget {
  const ActionContainer({super.key, required this.action});

  final WorkflowAction action;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (action.actionType) {
      ActionType.Start || ActionType.End => WorkflowActionContainer(
        backgroundColor: Colors.purple.shade100,
        highlightColor: Colors.purple,
        child: const Center(child: Text("Start Action")),
        action: action,
        icon: Icons.play_arrow,
      ),
      ActionType.Macro => WorkflowActionContainer(
        backgroundColor: Colors.blue.shade100,
        highlightColor: Colors.blue,
        child: const Center(child: Text("Macro Action")),
        action: action,
        icon: Icons.code,
      ),
      ActionType.Delay => WorkflowActionContainer(
        backgroundColor: Colors.orange.shade100,
        highlightColor: Colors.orange,
        child: const Center(child: Text("Delay Action")),
        action: action,
        icon: Icons.timer,
      ),
      ActionType.Notification => WorkflowActionContainer(
        backgroundColor: Colors.green.shade100,
        highlightColor: Colors.green,
        child: const Center(child: Text("Notification Action")),
        action: action,
        icon: Icons.notifications,
      ),
    };
  }
}

class WorkflowActionContainer extends HookConsumerWidget {
  const WorkflowActionContainer({
    super.key,
    required this.backgroundColor,
    required this.highlightColor,
    required this.child,
    required this.action,
    required this.icon,
  });

  final Color backgroundColor;
  final Color highlightColor;
  final Widget child;
  final WorkflowAction action;
  final IconData icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final body = Container(
      width: 180,
      height: 120,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: highlightColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 32,
            width: double.infinity,
            decoration: BoxDecoration(
              color: highlightColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      action.actionName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(icon, color: backgroundColor),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
              child: child,
            ),
          ),
        ],
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 4,
      children: [
        ActionTarget(),
        Draggable(
          data: action,
          child: body,
          feedback: Material(color: Colors.transparent, child: body),
          childWhenDragging: Container(
            width: 180,
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(color: highlightColor, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        ActionTarget(),
      ],
    );
  }
}

class ActionTarget extends StatelessWidget {
  const ActionTarget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: 8,
      decoration: ShapeDecoration(
        shape: CircleBorder(),
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
