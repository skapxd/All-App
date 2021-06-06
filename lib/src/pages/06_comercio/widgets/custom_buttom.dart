import '../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomButton extends StatelessWidget {
  final bool ifEnable;
  final String iconPath;
  final String text;
  final VoidCallback onTap;
  CustomButton({
    @required this.text,
    @required this.iconPath,
    this.onTap,
    this.ifEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: vw * 0.08),
      child: InkWell(
        borderRadius: BorderRadius.circular(vw),
        child: Container(
          width: vw * 0.7,
          height: vw * 0.12,
          decoration: BoxDecoration(
            // color: Colors.red,
            border: Border.all(
              width: 1,
              color: ifEnable ? hexaColor('#D6D6D6') : hexaColor('#303030'),
            ),
            borderRadius: BorderRadius.circular(vw),
          ),
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 3),
          // margin: EdgeInsets.only(bottom: vw * 0.03),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // color: Colors.pink,
                width: 45,
                margin: EdgeInsets.symmetric(vertical: 3),
                child: SvgPicture.asset(
                  this.iconPath,
                  // height: 40,
                ),
              ),
              Container(
                // width: vw * 0.55,
                child: Text(
                  this.text,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: hexaColor('#D6D6D6', opacity: 0.4),
                  ),
                ),
              )
            ],
          ),
        ),
        onTap: !this.ifEnable ? null : this.onTap,
      ),
    );
  }
}
