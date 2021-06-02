import 'package:allapp/src/models/cache_store_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transparent_image/transparent_image.dart';

import '../utils/utils.dart';

class FilaDeSubCategoriaDeTiendas extends StatelessWidget {
  // final ListModelImageUrls nameBusiness;
  final List<StoreModel> listStoreModel;
  final String titleRow;
  final String ruburo;
  // final String titleRow;
  FilaDeSubCategoriaDeTiendas({
    @required this.listStoreModel,
    @required this.titleRow,
    @required this.ruburo,
    // @required this.titleRow,
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
              this.titleRow.toUpperCase(),
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
          FilaDeTiendas(
            // nameBusiness: this.nameBusiness,
            listStoreModel: listStoreModel,
            ruburo: this.ruburo,
          ),
        ],
      ),
    );
  }
}

class FilaDeTiendas extends StatelessWidget {
  final List<StoreModel> listStoreModel;
  final String ruburo;
  // final int itemCount;

  FilaDeTiendas({
    @required this.listStoreModel,
    @required this.ruburo,
  });
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    return Container(
      height: vw * 0.39,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: this.listStoreModel.length,
        itemBuilder: (context, index) {
          // final nameTemp = nameBusiness[index].name;

          // final length = nameTemp.length;
          // final listOfText = nameTemp.split(' ');
          // final spaceChart = listOfText[0];
          // String name = nameTemp;

          // if (spaceChart.length > 7 && spaceChart.length < 11) {
          //   name = nameTemp.replaceFirst(' ', '\n');
          // } else if (spaceChart.length > 11) {
          //   final firstPartName = spaceChart.substring(0, 11);
          //   final secondPartName = spaceChart.substring(11, spaceChart.length);
          //   name = '$firstPartName\n$secondPartName';
          // }

          List<String> name = this.listStoreModel[index].nameStore.split('');

          if (name.length > 12) {
            name.insert(12, '\n');
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
                  url: this.listStoreModel[index].urlImage,
                  ruburo: this.ruburo,
                ),
                Container(
                  // color: Colors.white,
                  // height: vw * 0.1,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: vw * 0.01),
                  child: Text(
                    name.join(''),
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
                      'assets/icons/full-star.svg',
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
    print('FilaDeSubCategoriaDeTiendas - _ImageBusiness: $url');
    if (url != '') {
      return Container(
        // padding: EdgeInsets.all(vw * 0.013),
        decoration: BoxDecoration(
          color: hexaColor('#303030'),
          boxShadow: [
            BoxShadow(
              color: rgbColor(0, 0, 0, 0.2),
              blurRadius: 5,
              // spreadRadius: 10,
              offset: Offset(3, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(vw * 0.05),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(vw * 0.05),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: this.url,
            height: vw * 0.25,
            width: vw * 0.25,
            fit: BoxFit.cover,
          ),
          // child: Image.network(
          //   this.url,
          //   fit: BoxFit.cover,
          //   height: vw * 0.25,
          //   width: vw * 0.25,
          // ),
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
          'assets/ruburos/${ruburo}.svg',
        ),
      );
    }
  }
}
