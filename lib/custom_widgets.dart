import 'package:flutter/material.dart';

// Custom Button Widget
Widget customButton(buttonText, onPressedFunc) {
  return SizedBox(
    height: 40,
    width: 200,
    child: ElevatedButton(
      onPressed: onPressedFunc,
      child: Text(buttonText, style: const TextStyle(fontSize: 20)),
    ),
  );
}
