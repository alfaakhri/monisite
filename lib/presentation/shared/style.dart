import 'package:flutter/material.dart';

InputDecoration inputDecorationPlusIconStyle(String text, Icon icon) {
  return InputDecoration(
    border: InputBorder.none,
    hintText: "$text",
    labelStyle: TextStyle(color: Colors.black),
    icon: Icon(
      icon.icon,
      size: 25.0,
    ),
    isDense: true,
  );
}

InputDecoration inputDecorationDropdownStyle(String text) {
  return InputDecoration(
      hintText: "$text",
      labelStyle: TextStyle(color: Colors.black),
      isDense: true,
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)));
}


  Container buildContainerBoxStyle(Color colors, Column column) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: colors,
      ),
      child: column,
    );
  }

  InputDecoration inputDecorationStyle(String text) {
    return InputDecoration(
        labelText: "${text}",
        labelStyle: TextStyle(color: Colors.black),
        isDense: true,
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        border:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black)));
  }