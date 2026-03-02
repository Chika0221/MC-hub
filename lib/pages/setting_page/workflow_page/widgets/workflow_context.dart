// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/workflow_edit_provider.dart';
import 'package:mc_hub/models/workflow.dart';

class WorkflowPathContextMenu extends HookConsumerWidget {
  const WorkflowPathContextMenu({
    super.key,
    required this.child,
    required this.action,
  });

  final Widget child;

  final WorkflowAction action;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ContextMenuEntry> pathsEntries =
        action.nextActionIds.map((nextActionId) {
          final nextAction = ref
              .read(workflowEditProvider.notifier)
              .getActionById(nextActionId);

          return CustomContextMenuEntry(
            label: Text('${nextAction.actionName}'),
            icon: const Icon(Icons.delete_rounded),
            onSelected: (value) {
              final newNextActionIds = List<String>.from(action.nextActionIds)
                ..remove(nextActionId);
              final updatedAction = action.copyWith(
                nextActionIds: newNextActionIds,
              );
              ref
                  .read(workflowEditProvider.notifier)
                  .updateAction(updatedAction);
            },
          );
        }).toList();

    return ContextMenuRegion(
      contextMenu: ContextMenu(
        boxDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface,
          borderRadius: BorderRadius.circular(8.0),
        ),
        entries: pathsEntries,
      ),
      child: child,
    );
  }
}

class WorkflowContextMenu extends HookConsumerWidget {
  const WorkflowContextMenu({
    super.key,
    required this.child,
    required this.action,
  });

  final Widget child;
  final WorkflowAction action;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = <ContextMenuEntry>[
      CustomContextMenuEntry(
        label: const Text('削除'),
        icon: const Icon(Icons.delete_rounded),
        onSelected: (value) {
          ref.read(workflowEditProvider.notifier).deleteAction(action.actionId);
        },
      ),
    ];

    return ContextMenuRegion(
      contextMenu: ContextMenu(
        boxDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface,
          borderRadius: BorderRadius.circular(8.0),
        ),
        entries: entries,
      ),
      child: child,
    );
  }
}

final class CustomContextMenuEntry<T> extends ContextMenuItem<T> {
  final Widget? icon;
  final Widget label;
  final SingleActivator? shortcut;
  final Widget? trailing;
  final BoxConstraints? constraints;
  final Color? textColor;

  const CustomContextMenuEntry({
    this.icon,
    required this.label,
    this.shortcut,
    this.trailing,
    super.value,
    super.onSelected,
    super.enabled,
    this.constraints,
    this.textColor,
  });

  @override
  String get debugLabel => "${super.debugLabel} - $label";

  @override
  Widget builder(
    BuildContext context,
    ContextMenuState menuState, [
    FocusNode? focusNode,
  ]) {
    bool isFocused = menuState.focusedEntry == this;

    final background = Theme.of(context).colorScheme.onSurface;
    final focusedBackground = Theme.of(context).colorScheme.onSurface;
    final adjustedTextColor = Color.alphaBlend(
      Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
      background,
    );
    final normalTextColor = Theme.of(context).colorScheme.surface;
    final focusedTextColor = textColor ?? Theme.of(context).colorScheme.surface;
    final disabledTextColor = Theme.of(
      context,
    ).colorScheme.onSurface.withValues(alpha: 0.2);
    final foregroundColor =
        !enabled
            ? disabledTextColor
            : isFocused
            ? focusedTextColor
            : normalTextColor;
    final textStyle = TextStyle(color: foregroundColor, height: 1.0);
    final leadingIconThemeData = IconThemeData(
      size: 16.0,
      color: normalTextColor,
    );
    final trailingIconThemeData = IconThemeData(
      size: 16.0,
      color: normalTextColor,
    );

    return ConstrainedBox(
      constraints:
          constraints ?? const BoxConstraints.expand(height: kMenuItemHeight),
      child: Material(
        color:
            !enabled
                ? Colors.transparent
                : isFocused
                ? focusedBackground
                : background,
        borderRadius: BorderRadius.circular(4.0),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: !enabled ? null : () => handleItemSelection(context),
          canRequestFocus: false,
          hoverColor: Colors.transparent,
          child: Row(
            children: [
              SizedBox.square(
                dimension: kMenuItemIconSize,
                child:
                    icon != null
                        ? IconTheme(data: leadingIconThemeData, child: icon!)
                        : null,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: DefaultTextStyle(
                  style: textStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  child: label,
                ),
              ),
              if (shortcut != null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 32.0),
                  child: DefaultTextStyle(
                    style: textStyle.apply(
                      color: adjustedTextColor.withValues(alpha: 0.6),
                    ),
                    child: Text(shortcut!.toKeyString()),
                  ),
                ),
              const SizedBox(width: 8.0),
              trailing ??
                  SizedBox.square(
                    dimension: kMenuItemIconSize,
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: IconTheme(
                        data: trailingIconThemeData,
                        child: Icon(isSubmenuItem ? Icons.arrow_right : null),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
