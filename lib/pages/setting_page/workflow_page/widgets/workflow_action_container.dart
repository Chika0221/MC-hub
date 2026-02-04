// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/workflow_edit_provider.dart';
import 'package:mc_hub/models/macro.dart';
import 'package:mc_hub/models/workflow.dart';
import 'package:mc_hub/pages/editor_page/widgets/macro_setting/macro_setting_dialog.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/widgets/workflow_context.dart';

part 'actions_widgets/workflow_start_container.dart';
part 'actions_widgets/workflow_macro_container.dart';
part 'actions_widgets/workflow_delay_container.dart';
part 'actions_widgets/workflow_notification_container.dart';
part 'actions_widgets/workflow_end_container.dart';

class ActionContainer extends HookConsumerWidget {
  const ActionContainer({
    super.key,
    this.actionId = null,
    this.draggableAction = null,
  });

  final String? actionId;
  final WorkflowAction? draggableAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final action =
        (actionId != null)
            ? ref.watch(WorkflowEditProvider.notifier).getActionById(actionId!)
            : null;

    return (draggableAction == null && action != null)
        ? switch (action.actionType) {
            ActionType.Start => WorkflowStartContainer(actionId: actionId!),
            ActionType.End => WorkflowEndContainer(actionId: actionId!),
            ActionType.Macro => WorkflowMacroContainer(actionId: actionId!),
            ActionType.Delay => WorkflowDelayContainer(actionId: actionId!),
            ActionType.Notification => WorkflowNotificationContainer(
                actionId: actionId!,
              ),
          }
        : switch (draggableAction!.actionType) {
          ActionType.Start => WorkflowActionContainer(
            backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
            highlightColor: colorScheme.primary,
            headerTextColor: colorScheme.onPrimary,
            bodyTextColor: colorScheme.onSurface,
            child: const Center(child: Text("Start Action")),
            action: draggableAction!,
            icon: Icons.play_arrow,
            isShowStartAnker: false,
          ),
          ActionType.End => WorkflowActionContainer(
            backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
            highlightColor: colorScheme.primary,
            headerTextColor: colorScheme.onPrimary,
            bodyTextColor: colorScheme.onSurface,
            child: const Center(child: Text("End Action")),
            action: draggableAction!,
            icon: Icons.stop,
            isShowEndAnker: false,
          ),
          ActionType.Macro => WorkflowActionContainer(
            backgroundColor: colorScheme.secondary.withValues(alpha: 0.15),
            highlightColor: colorScheme.secondary,
            headerTextColor: colorScheme.onSecondary,
            bodyTextColor: colorScheme.onSurface,
            child: const Center(child: Text("Macro Action")),
            action: draggableAction!,
            icon: Icons.code,
          ),
          ActionType.Delay => WorkflowActionContainer(
            backgroundColor: colorScheme.tertiary.withValues(alpha: 0.15),
            highlightColor: colorScheme.tertiary,
            headerTextColor: colorScheme.onTertiary,
            bodyTextColor: colorScheme.onSurface,
            child: const Center(child: Text("Delay Action")),
            action: draggableAction!,
            icon: Icons.timer,
          ),
          ActionType.Notification => WorkflowActionContainer(
            backgroundColor: colorScheme.tertiary.withValues(alpha: 0.15),
            highlightColor: colorScheme.tertiary,
            headerTextColor: colorScheme.onTertiary,
            bodyTextColor: colorScheme.onSurface,
            child: const Center(child: Text("Notification Action")),
            action: draggableAction!,
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
    this.isShowStartAnker = true,
    this.isShowEndAnker = true,
    this.headerTextColor,
    this.bodyTextColor,
  });

  final Color backgroundColor;
  final Color highlightColor;
  final Widget child;
  final WorkflowAction action;
  final IconData icon;
  final bool isShowStartAnker;
  final bool isShowEndAnker;
  final Color? headerTextColor;
  final Color? bodyTextColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const borderWidth = 2.0;
    const outerRadius = 8.0;

    final body = Container(
      width: 180,
      height: 120,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(outerRadius),
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
                top: Radius.circular(outerRadius - borderWidth),
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
                        color: headerTextColor ?? Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(icon, color: headerTextColor ?? Colors.white),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
              child: DefaultTextStyle.merge(
                style: TextStyle(color: bodyTextColor),
                child: child,
              ),
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
        (isShowStartAnker) ? ActionTarget() : ActionTarget(isActive: false),

        WorkflowContextMenu(
          action: action,
          child: Draggable(
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
        ),
        (isShowEndAnker)
            ? WorkflowPathContextMenu(
              action: action,
              child: Draggable(
                data: action.actionId,
                child: ActionTarget(),
                feedback: Container(
                  height: 16,
                  width: 16,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            )
            : ActionTarget(isActive: false),
      ],
    );
  }
}

class ActionTarget extends StatelessWidget {
  const ActionTarget({super.key, this.isActive = true});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: 8,
      decoration: ShapeDecoration(
        shape: CircleBorder(),
        color:
            (isActive)
                ? Theme.of(context).colorScheme.onSurface
                : Colors.transparent,
      ),
    );
  }
}
