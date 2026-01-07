// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/widgets/custom_full_page_dialog.dart';

class MacroSettingDialog extends HookConsumerWidget {
  const MacroSettingDialog({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomFullPageDialog(
      title: title,
      child: SingleChildScrollView(child: Column(children: [
        
      ])),
    );
  }
}
