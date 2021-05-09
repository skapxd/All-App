import 'package:allapp/src/utils/Color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// enum TypeBusiness {

// }

class Business {
  final String name;
  final String url;

  Business(this.name, this.url);
}

class FilaDeSubCategoriaDeTiendas extends StatelessWidget {
  final List<Business> nameBusiness;
  final String subCategoria;
  FilaDeSubCategoriaDeTiendas({
    this.nameBusiness,
    this.subCategoria,
  });
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: vw * 0.02),
      child: Column(
        children: [
          ListTile(
            title: Text(
              this.subCategoria.toUpperCase(),
              style: TextStyle(
                color: hexaColor('#BEA07D'),
                letterSpacing: 3,
                fontSize: vw * 0.03,
              ),
            ),
            trailing: Container(
              child: SvgPicture.asset(
                'assets/icons/next.svg',
                width: vw * 0.07,
              ),
            ),
          ),
          FilaDeTiendas(nameBusiness: this.nameBusiness),
        ],
      ),
    );
  }
}

class FilaDeTiendas extends StatelessWidget {
  final List<Business> nameBusiness;

  FilaDeTiendas({
    @required this.nameBusiness,
  });
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    return Container(
      height: vw * 0.38,
      // color: Colors.amber,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: nameBusiness.length,
        itemBuilder: (context, index) {
          final nameTemp = nameBusiness[index].name;

          final length = nameTemp.length;
          final listOfText = nameTemp.split(' ');
          final spaceChart = listOfText[0];
          String name = nameTemp;

          if (spaceChart.length > 7 && spaceChart.length < 11) {
            // print(nameTemp.indexOf(' '));

            // print(true);

            name = nameTemp.replaceFirst(' ', '\n');
            // print(name);
          } else if (spaceChart.length > 11) {
            final firstPartName = spaceChart.substring(0, 11);
            final secondPartName = spaceChart.substring(11, spaceChart.length);
            name = '$firstPartName\n$secondPartName';
          }

          return Container(
            margin: index == 0
                ? EdgeInsets.only(
                    left: vw * 0.05,
                    top: vw * 0.02,
                    right: vw * 0.04,
                  )
                : EdgeInsets.only(
                    top: vw * 0.02,
                    right: vw * 0.04,
                  ),
            width: vw * 0.24,
            // color: Colors.red,
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _ImageBusiness(
                  url: this.nameBusiness[index].url,
                  ruburo: 'supermercado',
                ),
                Container(
                  // color: Colors.white,
                  // height: vw * 0.1,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: vw * 0.01),
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: hexaColor('#8C8C8C'),
                      fontSize: vw * 0.03,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '4.5',
                      style:
                          TextStyle(color: hexaColor('#DDDDDD'), fontSize: 10),
                    ),
                    SizedBox(width: 3),
                    SvgPicture.asset(
                      'assets/icons/full-star.svg.svg',
                      height: 7,
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
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
  final String ruburo;
  const _ImageBusiness({
    Key key,
    this.url,
    this.ruburo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;
    if (url != '') {
      return Container(
        // padding: EdgeInsets.all(vw * 0.013),
        decoration: BoxDecoration(
          color: hexaColor('#303030'),

          // color: hexaColor('#BEA07D'),
          boxShadow: [
            BoxShadow(
              color: rgbColor(0, 0, 0, 0.2),
              blurRadius: 5,
              // spreadRadius: 10,
              offset: Offset(2, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(vw * 0.05),
        ),
        child: Image.network(
          this.url,
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: vw * 0.07),
        height: vw * 0.24,
        decoration: BoxDecoration(
          color: hexaColor('#BEA07D'),
          borderRadius: BorderRadius.circular(vw * 0.05),
        ),
        child: SvgPicture.asset(
          'assets/ruburos/$ruburo.svg',
        ),
      );
    }
  }
}
