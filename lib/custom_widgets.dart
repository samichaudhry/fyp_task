import 'dart:js';

import 'package:flutter/material.dart';
import 'package:fyp_task/utils.dart';

// Custom Button Widget
Widget customButton(buttonText, onPressedFunc, ctx) {
  return SizedBox(
    height: responsiveHW(ctx, ht: 9),
    width: responsiveHW(ctx, wd: 35),
    child: ElevatedButton(
      onPressed: onPressedFunc,
      child: Text(buttonText, style: const TextStyle(fontSize: 20)),
    ),
  );
}
