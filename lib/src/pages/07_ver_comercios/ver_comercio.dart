import 'package:allapp/src/models/cache_store_model/cache_store_model.dart';
import 'package:allapp/src/utils/utils.dart';
import 'package:allapp/src/widgets/BackgroundGradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transparent_image/transparent_image.dart';

class VerComercios extends StatelessWidget {
  static final String pathName = '/VerComercios';

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    final StoreModel data = args['storeModel'];

    final String ruburo = args['ruburo'];

    List<String> nameSplit = data.nameStore.split('');

    if (nameSplit.length > 17) {
      nameSplit.insert(16, '\n');
    }

    print(nameSplit.length);

    return Scaffold(
      body: CustomBackgroundGradient(
        child: Column(
          children: [
            SizedBox(
              height: 90,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: vw * 0.06),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _ImageBusiness(
                    storeModel: data,
                    ruburo: ruburo,
                    url: data.urlImage,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    nameSplit.join(''),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: hexaColor(
                        '#dddddd',
                      ),
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              padding:
                  EdgeInsets.symmetric(horizontal: vw * 0.06, vertical: 12),
              onPressed: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DESCRIPCIÓN',
                        style: TextStyle(
                          color: hexaColor('#bea07d'),
                          fontSize: 16,
                          letterSpacing: 5,
                        ),
                      ),
                      Text(
                        'Conoce más acerca de este comercio aquí.',
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
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: vw * 0.4,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: index == 0
                        ? EdgeInsets.only(right: vw * 0.04, left: vw * 0.06)
                        : EdgeInsets.only(right: vw * 0.04),
                    height: vw * 0.4,
                    width: vw * 0.25,
                    decoration: BoxDecoration(
                      color: hexaColor('#BEA07D'),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text('$index'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageBusiness extends StatelessWidget {
  final String url;
  final String ruburo;
  final StoreModel storeModel;
  const _ImageBusiness({
    Key key,
    @required this.url,
    @required this.ruburo,
    @required this.storeModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;
    print('FilaDeSubCategoriaDeTiendas - _ImageBusiness: $url');
    if (url != '') {
      return InkWell(
        // onTap: () {
        //   print(storeModel.nameStore);
        //   Navigator.pushNamed(
        //     context,
        //     VerComercios.pathName,
        //     arguments: {'storeModel': storeModel},
        //   );
        // },
        child: Container(
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
            // child: Image.network(
            //   this.url,
            //   fit: BoxFit.cover,
            //   height: vw * 0.25,
            //   width: vw * 0.25,
            // ),
          ),
        ),
      );
    } else {
      return InkWell(
        // onTap: () {
        //   print(storeModel.nameStore);
        //   Navigator.pushNamed(
        //     context,
        //     VerComercios.pathName,
        //     arguments: {'storeModel': storeModel},
        //   );
        // },
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
