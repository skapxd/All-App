import 'package:allapp/src/utils/Color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Business {
  final String name;
  final String url;

  Business(this.name, this.url);
}

class RowShop extends StatelessWidget {
  final List<Business> nameBusiness;

  RowShop({
    @required this.nameBusiness,
  });
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: nameBusiness.length,
      itemBuilder: (context, index) {
        final length = nameBusiness[index].name.length;
        String name;
        if (length > 10) {
          // final firstPartName = nameBusiness[index].substring(0, 10);
          // final secondPartName = nameBusiness[index].substring(10, length);
          // name = '$firstPartName\n$secondPartName';
          // name.indexOf(' ');

          name = nameBusiness[index].name.replaceFirst(' ', '\n');
          print(name);
        }

        http();

        return Container(
          margin: EdgeInsets.all(vw * 0.03),
          width: vw * 0.24,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: vw * 0.07),
                margin: EdgeInsets.symmetric(vertical: vw * 0.03),
                height: vw * 0.24,
                decoration: BoxDecoration(
                  color: hexaColor('#BEA07D'),
                  borderRadius: BorderRadius.circular(vw * 0.035),
                ),
                child: _ImageBusiness(
                  url: this.nameBusiness[index].url,
                ),
              ),
              Container(
                // height: vw * 0.1,
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: hexaColor('#8C8C8C'),
                    fontSize: vw * 0.03,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

http() async {
  try {
    var response =
        await Dio().get('https://ipinfo.io/json?token=2859130d42a1bb');
    print(response);
  } catch (e) {
    print(e);
  }
}

class _ImageBusiness extends StatelessWidget {
  final String url;
  const _ImageBusiness({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url != '') {
      return Image.network(
        this.url,
      );
    } else {
      return SvgPicture.asset(
        'assets/ruburos/supermercado.svg',
      );
    }
  }
}
