import 'package:flutter/material.dart';

import 'commonStyles.dart';

Image InsertImage(String imagePath) {
  return Image.asset(imagePath, fit: BoxFit.contain);
}

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    isDense: true,
    prefixIcon: Icon(icon, color: iconColor),
    hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 7.5, 20.0, 7.5),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}

TextFormField TextInputComponent(
    String hintText, bool isObscureText, IconData icon, TextEditingController textController) {
  if (icon != null) {
    return TextFormField(
        maxLines: 1,
        controller: textController,
        obscureText: isObscureText,
        style: textStyle,
        decoration: buildInputDecoration(hintText, icon));
  } else {
    return TextFormField(
      maxLines: 1,
      controller: textController,
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
    style: textBannerStyle,
  );
}
