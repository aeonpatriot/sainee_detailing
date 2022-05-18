import 'package:flutter/Material.dart';

class CustomSnackBar {
  static show({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
    ));
  }
}
