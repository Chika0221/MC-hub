// Package imports:
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';

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
