// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';

// Project imports:
import 'package:mc_hub/infrastructure/notification/notification_content.dart';

void sendNotification(String title, String content) {
  final _winNotifyPlugin = WindowsNotification(applicationId: "MC HUB");

  final NotificationMessage message = NotificationMessage.fromPluginTemplate(
    "remocon_push",
    title,
    content,
    // image:
    //     "C:\Users\chika\dev\keyboard\2025-10\mc_hub\assets\icons\app_icon.png",
  );

  _winNotifyPlugin.showNotificationPluginTemplate(message);
}

void sendAppNotification() async {
  final controller = await WindowController.create(
    WindowConfiguration(hiddenAtLaunch: true, arguments: 'notification'),
  );

  await controller.show();

  Future.delayed(const Duration(seconds: 3), () {
    controller.hide();
  });

  // Show the window (if hidden at launch)
}
