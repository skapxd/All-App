import 'package:allapp/src/pages/07_ver_comercios/ver_comercio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/cache_store_model/cache_store_model.dart';
import '../utils/utils.dart';

class FilaDeSubCategoriaDeTiendas extends StatelessWidget {
  // final ListModelImageUrls nameBusiness;
  final List<StoreModel> listStoreModel;
  final String titleRow;
  final String categories;
  // final String titleRow;
  FilaDeSubCategoriaDeTiendas({
    @required this.listStoreModel,
    @required this.titleRow,
    @required this.categories,
    // @required this.titleRow,
  });
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    print('FilaDeSubCategoriaDeTiendas - categories: $categories');

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
            ruburo: this.categories,
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
          //

          List<String> name = this.listStoreModel[index].nameStore.split('');

          if (name.length > 12) {
            name.insert(12, '\n');
          }

          return _Item(
            storeModel: listStoreModel[index],
            ruburo: ruburo,
            name: name,
            index: index,
          );
        },
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    Key key,
    @required this.name,
    @required this.index,
    @required this.ruburo,
    @required this.storeModel,
  }) : super(key: key);

  final String ruburo;
  final int index;
  final List<String> name;
  final StoreModel storeModel;

  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    if (this.storeModel.visibilidad == false) {
      return Container(
        margin: index == 0
            ? EdgeInsets.only(
                left: vw * 0.05,
                top: vw * 0.02,
              )
            : EdgeInsets.only(),
      );
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
            storeModel: storeModel,
            url: this.storeModel.urlImage,
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
                style: TextStyle(color: hexaColor('#DDDDDD'), fontSize: 10),
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
  }
}

class _ImageBusiness extends StatelessWidget {
  final String url;
  final StoreModel storeModel;
  final String ruburo;
  const _ImageBusiness({
    Key key,
    this.url,
    this.ruburo,
    this.storeModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;
    print('FilaDeSubCategoriaDeTiendas - _ImageBusiness: $url');
    if (url != '') {
      return InkWell(
        onTap: () {
          print(storeModel.nameStore);
          Navigator.pushNamed(
            context,
            VerComercios.pathName,
            arguments: {
              'storeModel': storeModel,
              'ruburo': ruburo,
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: hexaColor('#303030'),
            boxShadow: [
              BoxShadow(
                color: rgbColor(0, 0, 0, 0.2),
                blurRadius: 5,
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
              imageErrorBuilder: (context, error, stackTrace) {
                return Container(
                  height: vw * 0.25,
                  width: vw * 0.25,
                  color: Colors.pink,
                );
              },
            ),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          print(storeModel.nameStore);
          Navigator.pushNamed(
            context,
            VerComercios.pathName,
            arguments: {
              'storeModel': storeModel,
              'ruburo': ruburo,
            },
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: vw * 0.07),
          height: vw * 0.24,
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
