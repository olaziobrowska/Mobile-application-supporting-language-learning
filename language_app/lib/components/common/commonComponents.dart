import 'package:flutter/material.dart';

import 'commonStyles.dart';

Image InsertImage(String imagePath) {
  return Image.asset(imagePath, fit: BoxFit.contain);
}

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: iconColor),
    hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 7.5, 20.0, 7.5),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}

TextField TextInputComponent(String hintText, bool isObscureText, IconData icon) {
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

TextField TextInputComponent2(String hintText, bool isObscureText, IconData icon,Function onChangedAction,
    TextEditingController textEditingController) {
  if (icon != null) {
    return TextField(
        controller: textEditingController,
        obscureText: isObscureText,
        onChanged: onChangedAction,
        style: textStyle,
        decoration: buildInputDecoration(hintText, icon));
  } else {
    return TextField(
      controller: textEditingController,
      obscureText: isObscureText,
      onChanged: onChangedAction,
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

DropdownButton DropdownButtonComponent(List<DropdownMenuItem<dynamic>> items,
    Function onChangedAction, String value) {
  return DropdownButton(
    underline: SizedBox(),
    hint: Text('Please choose language'),
    icon: Icon(
      Icons.language,
      color: Colors.blueAccent,
    ),
    items: items,
    onChanged: onChangedAction,
    value: value,
  );
}

MaterialButton MaterialButtonComponent() {
  return MaterialButton(
    onPressed: () {},
    color: Colors.blue,
    textColor: Colors.white,
    child: Icon(
      Icons.add,
      size: 24,
    ),
    padding: EdgeInsets.all(16),
    shape: CircleBorder(),
  );
}

TextField TextOutputComponent(
    String hintText, bool isObscureText, IconData icon,
    [TextEditingController textEditingController]) {
  if (icon != null) {
    return TextField(
        controller: textEditingController,
        obscureText: isObscureText,
        style: textStyle,
        decoration: buildInputDecoration(hintText, icon),
        readOnly: true);
  } else {
    return TextField(
      controller: textEditingController,
      obscureText: isObscureText,
      style: textStyle,
      readOnly: true,
      decoration: InputDecoration(
          contentPadding: inputPadding,
          hintText: hintText,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
    );
  }
}
