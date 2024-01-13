import 'package:flutter/material.dart';

InputDecoration textFieldDecoration(Icon prefixIcon, hintText){
  return InputDecoration(
    prefixIcon: prefixIcon,
    hintText: hintText,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12)),
  );
}