import 'package:flutter/material.dart';
import 'authInputStyle.dart';

TextField TextInputComponent(String hintText, bool isObscureText) {
  return TextField(
    obscureText: isObscureText,
    style: textStyle,
    decoration: InputDecoration(
        contentPadding: inputPadding,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );
}

Material OnPressButton(String hintText, Function onPressAction, BuildContext context) {
  return Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(30.0),
    color: Color(0xff01A0C7),
    child: MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: inputPadding,
      onPressed: onPressAction(),
      child: Text(hintText,
          textAlign: TextAlign.center,
          style: textStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );
}