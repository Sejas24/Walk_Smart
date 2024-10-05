import 'package:flutter/material.dart';

class NotificationProvided {
  static GlobalKey<ScaffoldMessengerState> messengerkey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message,
          style: const TextStyle(color: Colors.white, fontSize: 20)),
    );

    messengerkey.currentState!.showSnackBar(snackBar);
  }
}
