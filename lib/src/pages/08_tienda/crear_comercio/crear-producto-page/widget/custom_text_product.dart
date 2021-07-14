import '../../../../../utils/utils.dart';
import 'package:flutter/material.dart';

class CustomTextInputProducts extends StatefulWidget {
  final String text;
  final EdgeInsets margin;
  final TextInputType keyboardType;
  final ValueChanged<String> onChange;
  final TextEditingController textEditingController;

  CustomTextInputProducts({
    Key key,
    this.margin,
    this.keyboardType,
    @required this.text,
    @required this.onChange,
    this.textEditingController,
  }) : super(key: key);

  @override
  _CustomTextInputProductsState createState() =>
      _CustomTextInputProductsState();
}

class _CustomTextInputProductsState extends State<CustomTextInputProducts> {
  @override
  void dispose() {
    widget.textEditingController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;
    return Container(
      margin: this.widget.margin,
      child: TextFormField(
        controller: this.widget.textEditingController,
        keyboardType: this.widget.keyboardType,
        onChanged: this.widget.onChange,

        // selectionHandleColor: hexaColor('#FFFFFF'),
        // selectionColor: hexaColor('#FFFFFF'),

        cursorColor: hexaColor('#303030'),
        style: TextStyle(
          color: hexaColor('#303030'),
        ),
        textAlignVertical: TextAlignVertical.center,

        decoration: InputDecoration(
          counterStyle: TextStyle(
            color: hexaColor('#CCCCCC'),
          ),
          hintText: this.widget.text,
          hintStyle: TextStyle(
            height: 0,
            color: hexaColor('#303030', opacity: 0.4),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hexaColor('#111111'),
            ),
            borderRadius: BorderRadius.circular(vw * .1),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hexaColor('#111111'),
            ),
            borderRadius: BorderRadius.circular(vw * .1),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hexaColor('#111111'),
            ),
            borderRadius: BorderRadius.circular(vw * .1),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: hexaColor('#111111'),
            ),
            borderRadius: BorderRadius.circular(vw * .1),
          ),
        ),
      ),
    );
  }
}
