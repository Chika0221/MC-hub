// Flutter imports:
import 'package:flutter/material.dart';

class NotificationApp extends StatelessWidget {
  const NotificationApp({
    super.key,
    required this.windowId,
    required this.arguments,
  });

  final int windowId;
  final Map<String, dynamic> arguments;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent, // 透過させる場合
        body: Container(
          
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "Macro Activated!",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
