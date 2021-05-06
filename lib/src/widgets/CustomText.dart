import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final TextStyle style;
  final Alignment alignment;
  final double width;
  final TextAlign textAlign;

  CustomText(
    this.text, {
    this.margin,
    this.padding,
    this.style,
    this.alignment,
    this.width,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: alignment,
      margin: this.margin,
      padding: this.padding,
      child: Text(
        this.text,
        style: this.style,
        textAlign: this.textAlign,
      ),
    );
  }
}