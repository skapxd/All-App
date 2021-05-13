import 'package:flutter/material.dart';

class CustomOutLineButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final EdgeInsets margin;
  final double width;
  final BoxDecoration decoration;
  final TextStyle textStyle;
  static final TextStyle defaultTextStyle = TextStyle(
    color: Color(0xffBEA07D),
    letterSpacing: 7,
    fontWeight: FontWeight.w300,
  );

  CustomOutLineButton({
    this.text,
    this.onTap,
    this.margin,
    this.width,
    this.decoration,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return Container(
      decoration: this.decoration,
      child: GestureDetector(
        onTap: this.onTap,
        child: Container(
          width: this.width ?? vw * 0.63,
          height: vw * 0.13,
          alignment: Alignment.center,
          margin: this.margin,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xffBEA07D),
              width: vw * 0.003,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(vw * 0.02),
            ),
          ),
          child: Text(
            this.text,
            style: this.textStyle ?? defaultTextStyle,
          ),
        ),
      ),
    );
  }
}
