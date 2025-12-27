// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bitsdojo_window/bitsdojo_window.dart';

void show_notification(String title, String message) {
  runApp(NotificationApp());

  final notificationWindow = appWindow;

  doWhenWindowReady(() {
    const initialSize = Size(200, 100);
    // appWindow.minSize = initialSize;
    notificationWindow.size = initialSize;
    notificationWindow.alignment = Alignment.bottomRight;
    notificationWindow.show();
  });

  // Implementation for showing a desktop notification
  print('Notification: $title - $message');
}

class NotificationApp extends StatelessWidget {
  const NotificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Center(child: Text('Notification App'))),
    );
  }
}
