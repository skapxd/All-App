import 'package:allapp/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final EdgeInsets padding;
  final String subTitle;
  final Function() onTap;

  CustomListTile({
    @required this.onTap,
    @required this.title,
    @required this.padding,
    this.subTitle,
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
            width: 30,
            child: SvgPicture.asset('assets/icons/next.svg'),
          ),
        ],
      ),
    );
  }
}
