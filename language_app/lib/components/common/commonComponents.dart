import 'package:flutter/material.dart';

import 'commonStyles.dart';

Image InsertImage(String imagePath) {
  return Image.asset(imagePath, fit: BoxFit.contain);
}

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}

TextField TextInputComponent(
    String hintText, bool isObscureText, IconData icon) {
  if (icon != null) {
    return TextField(
        obscureText: isObscureText,
        style: textStyle,
        decoration: buildInputDecoration(hintText, icon));
  } else {
    return TextField(
      obscureText: isObscureText,
      style: textStyle,
      decoration: InputDecoration(
          contentPadding: inputPadding,
          hintText: hintText,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
    );
  }
}

Material OnPressButton(
    String hintText, Function onPressAction, BuildContext context) {
  return Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(20.0),
    color: Color(0xff01A0C7),
    child: MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: inputPadding,
      onPressed: onPressAction,
      child: Text(hintText,
          textAlign: TextAlign.center,
          style: textStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );
}

FlatButton LinkFlatButton(String hintText, Function onPressAction) {
  return FlatButton(
    onPressed: onPressAction,
    child: Text(
      hintText,
      style: hiperLinkTextStyle,
    ),
  );
}

Text textBanner(hintText) {
  return Text(
    hintText,
    style: TextStyle(
      fontSize: 50.0,
      color: Colors.black,
      fontWeight: FontWeight.bold,
      letterSpacing: -1.0,
      wordSpacing: 5.0,
      shadows: [
        Shadow(
          blurRadius: 15.0,
          color: Colors.blue,
          offset: Offset(5.0, 5.0),
        ),
      ],
    ),
    // style: Theme.of(context).textTheme.title,
  );
}
