import 'package:flutter/material.dart';

Widget customTextField(hintTitle, pIcon, isPassword, sIcon, controllerName,
    validationFunc, onSavedFunc, wSize, hSize) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: wSize * 6 / 100),
    child: Stack(children: [
      Material(
        elevation: 2.0,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: wSize,
          height: hSize * 7 / 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: isPassword,
        decoration: InputDecoration(
            hintText: hintTitle,
            suffixIcon: sIcon,
            prefixIcon: Icon(
              pIcon,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
                horizontal: wSize * 2.5 / 100, vertical: hSize * 2 / 100)),
        controller: controllerName,
        validator: validationFunc,
        onSaved: onSavedFunc,
      ),
    ]),
  );
}
