import 'package:flutter/material.dart';
import 'package:fyp_task/utils.dart';

// Custom Button Widget
Widget customButton(buttonText, onPressedFunc, ctx, bWd, {int bHt = 6}) {
  return Container(
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(95)),
        color: Color(0xff009688)),
    height: responsiveHW(ctx, ht: bHt),
    width: responsiveHW(ctx, wd: bWd),
    child: TextButton(
      onPressed: onPressedFunc,
      child: Text(buttonText,
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600)),
    ),
  );
}
