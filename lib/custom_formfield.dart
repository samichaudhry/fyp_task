import 'package:flutter/material.dart';
import 'package:fyp_task/utils.dart';

Widget customTextField(labelTitle, isPassword, sIcon, controllerName,
    validationFunc, onSavedFunc, wSize, hSize, border,
    {pIcon, filled = true, fillColor, hinttext}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: wSize * 6 / 100),
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: isPassword,
      decoration: InputDecoration(
          filled: filled,
          fillColor: Colors.grey[800],
          labelText: labelTitle,
          hintText: hinttext,
          suffixIcon: sIcon,
          prefixIcon: Icon(
            pIcon,
          ),
          border: border == InputBorder.none
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: wSize * 2.5 / 100, vertical: hSize * 2 / 100)),
      controller: controllerName,
      validator: validationFunc,
      onSaved: onSavedFunc,
    ),
  );
}

Widget customDropDownFormField(
    fieldTitle, dropDownValue, List<String> listOfItems, onChangedFunc, ctx) {
  return Padding(
    padding:
        EdgeInsets.symmetric(horizontal: responsiveHW(ctx, wd: 6)!.toDouble()),
    child: DropdownButtonFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: fieldTitle,
          focusColor: Colors.grey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          filled: true,
          fillColor: Colors.grey[800],
        ),
        validator: (value) => value == null ? 'Required*' : null,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.grey,
        ),
        // hint: Text(
        //   'Select $fieldTitle',
        // ),
        value: dropDownValue,
        items: listOfItems.map((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
        onChanged: onChangedFunc),
  );
}
