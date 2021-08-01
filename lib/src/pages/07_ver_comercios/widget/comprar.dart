import '../../../utils/utils.dart';
import 'package:flutter/material.dart';

class Comprar extends StatelessWidget {
  //

  final Function() onTap;

  const Comprar({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: vw * 0.06),
      child: MaterialButton(
        child: Text(
          'COMPRAR',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 3,
          ),
        ),
        minWidth: double.infinity,
        color: hexaColor('#BEA07D'),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        onPressed: this.onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
