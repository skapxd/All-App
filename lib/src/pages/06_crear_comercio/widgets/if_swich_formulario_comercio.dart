import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class IfSwichFormularioComercio extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final String text;
  final bool initialIfEnable;
  const IfSwichFormularioComercio({
    Key key,
    this.text,
    this.onChanged,
    this.initialIfEnable,
  }) : super(key: key);

  @override
  _IfSwichFormularioComercioState createState() =>
      _IfSwichFormularioComercioState();
}

class _IfSwichFormularioComercioState extends State<IfSwichFormularioComercio> {
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
              color: hexaColor('#D6D6D6', opacity: 0.4),
            ),
          ),
          CupertinoSwitch(
            activeColor: hexaColor('#BEA07D'),
            onChanged: widget.onChanged == null
                ? null
                : (bool value) {
                    widget.onChanged(value);
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
