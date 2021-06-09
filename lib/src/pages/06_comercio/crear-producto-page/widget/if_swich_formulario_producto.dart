import 'package:flutter/cupertino.dart';

import '../../../../utils/utils.dart';

class IfSwichFormularioProducto extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final String text;
  final bool initialIfEnable;
  const IfSwichFormularioProducto({
    Key key,
    this.text,
    this.onChanged,
    this.initialIfEnable,
  }) : super(key: key);

  @override
  _IfSwichFormularioProductoState createState() =>
      _IfSwichFormularioProductoState();
}

class _IfSwichFormularioProductoState extends State<IfSwichFormularioProducto> {
  bool state;

  @override
  void initState() {
    super.initState();

    state = widget.initialIfEnable ?? true;
  }

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;
    return Container(
      width: vw * 0.7,
      margin: EdgeInsets.only(bottom: vw * 0.08),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text,
            style: TextStyle(
              color: hexaColor('#4F4F4F'),
            ),
          ),
          CupertinoSwitch(
            activeColor: hexaColor('#BEA07D'),
            onChanged: (bool value) {
              if (widget.onChanged != null) {
                widget.onChanged(value);
              }
              setState(() {
                this.state = value;
              });
            },
            value: this.state,
          ),
        ],
      ),
    );
  }
}
