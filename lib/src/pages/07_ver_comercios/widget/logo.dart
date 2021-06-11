import 'package:allapp/src/models/cache_store_model/cache_store_model.dart';
import 'package:allapp/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transparent_image/transparent_image.dart';

class Logo extends StatelessWidget {
  final String url;
  final String ruburo;
  final Function() onTap;
  final StoreModel storeModel;
  const Logo({
    Key key,
    @required this.url,
    @required this.onTap,
    @required this.ruburo,
    @required this.storeModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;
    print('Logo - _ImageBusiness: $url');
    if (url != '') {
      return Container(
        decoration: BoxDecoration(
          color: hexaColor('#303030'),
          borderRadius: BorderRadius.circular(vw * 0.05),
          boxShadow: [
            BoxShadow(
              color: rgbColor(0, 0, 0, 0.2),
              blurRadius: 5,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(vw * 0.05),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: this.url,
            height: vw * 0.25,
            width: vw * 0.25,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return Container(
                height: vw * 0.25,
                width: vw * 0.25,
                color: Colors.pink,
              );
            },
          ),
        ),
      );
    } else {
      return InkWell(
        child: Container(
          height: vw * 0.25,
          width: vw * 0.25,
          padding: EdgeInsets.symmetric(horizontal: vw * 0.07),
          decoration: BoxDecoration(
            color: hexaColor('#BEA07D'),
            borderRadius: BorderRadius.circular(vw * 0.05),
          ),
          child: SvgPicture.asset(
            'assets/ruburos/$ruburo.svg',
          ),
        ),
      );
    }
  }
}
