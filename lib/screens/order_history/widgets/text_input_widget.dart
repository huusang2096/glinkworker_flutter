import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map_booking/common/config.dart';

class InputTextField extends StatefulWidget {
  final String placeholder;
  final Color color;
  final double radius;
  final double height;
  final double width;
  final bool obscureText;
  final TextEditingController controller;
  final int maxLines;
  final String error;
  TextInputType inputType;
  final bool enable;
  final TextCapitalization textCapitalization;
  final FormFieldValidator<String> validator;
  final Widget prefixIcon;

  InputTextField(
      {this.placeholder,
      this.color,
      this.radius,
      this.height,
      this.width,
      this.obscureText = false,
      this.controller,
      this.maxLines = 1,
      this.inputType = TextInputType.text,
      this.error,
      this.enable = true,
      this.textCapitalization = TextCapitalization.none,
      this.validator,
      this.prefixIcon});

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      textCapitalization: this.widget.textCapitalization,
      enabled: this.widget.enable,
      maxLines: this.widget.maxLines,
      controller: this.widget.controller,
      obscureText: _obscureText,
      style: textStyle,
      keyboardType: this.widget.inputType,
      decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          fillColor: widget.color,
          filled: true,
          contentPadding: EdgeInsets.only(left: 20, right: 10, top: 20),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 1, color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(width: 1, color: Colors.grey.withOpacity(0.5))),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 0.5, color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 0.5, color: Colors.red)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(width: 1, color: Colors.grey.withOpacity(0.5))),
          hintText: widget.placeholder,
          errorText: this.widget.error),
    );
  }
}
