import 'package:allapp/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final double iconWith;
  final String iconPath;
  final Function() onTap;
  final EdgeInsets padding;

  CustomListTile({
    this.iconPath,
    this.subTitle,
    this.iconWith,
    @required this.onTap,
    @required this.title,
    @required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return MaterialButton(
      onPressed: this.onTap,
      padding: this.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.title,
                style: TextStyle(
                  color: hexaColor('#bea07d'),
                  fontSize: 16,
                  letterSpacing: 5,
                ),
              ),
              this.subTitle == null
                  ? Container()
                  : Text(
                      this.subTitle,
                      style: TextStyle(
                        color: hexaColor('#d6d6d6'),
                        fontSize: 12,
                      ),
                    ),
            ],
          ),
          Expanded(child: Container()),
          Container(
            width: this.iconWith ?? 30,
            child: SvgPicture.asset(this.iconPath ?? 'assets/icons/next.svg'),
          ),
        ],
      ),
    );
  }
}
