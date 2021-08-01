import '../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../data/services/stores/stores_service.dart';
import '../models/store_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/07_ver_comercios/ver_comercio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transparent_image/transparent_image.dart';

// import '../models/cache_store_model/cache_store_model.dart';
import '../utils/utils.dart';

class FilaDeSubCategoriaDeTiendas extends StatelessWidget {
  final String titleRow;
  final String category;
  FilaDeSubCategoriaDeTiendas({
    @required this.titleRow,
    @required this.category,
  });
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;

    return BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
      builder: (context, state) {
        // if (state.address == null) {
        //   return Container();
        // }

        return FutureBuilder(
          // future: DBFirestore().getListCategoriesStore(
          //   cityPath: state.address,
          //   categories: this.categories,
          // ),
          // future: StoresService().getCacheAllStores(
          //   cityPath: state.address,
          //   category: this.category,
          //   onFailed: ({data}) {
          //     print(data);
          //   },
          //   onProgress: () {},
          //   onSuccess: ({data}) {
          //     print(data);
          //   },
          // ),

          future: StoreGetAllService().getStore(
            cityPath: state.address,
            category: this.category,
          ),
          builder: (
            BuildContext context,
            AsyncSnapshot<CacheStoreModel> snapshot,
          ) {
            //

            final data = snapshot.data;
            print(state.initPosition);

            // print(data);
            if (data == null || state.initPosition == null) {
              // return Container();
              return Container(
                // margin: EdgeInsets.only(top: vw * 0.06),
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
                    PlaceHolderFilasDeTiendas(),
                  ],
                ),
              );
            }

            return Container(
              // margin: EdgeInsets.only(top: vw * 0.06),
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
                    // listStoreModel: listStoreModel,
                    listStoreModel: data.storeModel,
                    ruburo: this.category,
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    // return Container(
    //   // margin: EdgeInsets.only(top: vw * 0.06),
    //   margin: EdgeInsets.only(top: vw * 0.02),
    //   child: Column(
    //     children: [
    //       ListTile(
    //         title: Text(
    //           this.titleRow.toUpperCase(),
    //           style: TextStyle(
    //             color: hexaColor('#BEA07D'),
    //             letterSpacing: 3,
    //             fontSize: vw * 0.03,
    //           ),
    //         ),
    //         trailing: Container(
    //           child: SvgPicture.asset(
    //             'assets/icons/next.svg',
    //             width: vw * 0.07,
    //           ),
    //         ),
    //       ),
    //       FilaDeTiendas(
    //         // nameBusiness: this.nameBusiness,
    //         listStoreModel: listStoreModel,
    //         ruburo: this.categories,
    //       ),
    //     ],
    //   ),
    // );
  }
}

class FilaDeTiendas extends StatelessWidget {
  final List<StoreModel> listStoreModel;
  final String ruburo;
  // final int itemCount;

  FilaDeTiendas({
    @required this.listStoreModel,
    this.ruburo,
  });
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;

    return Container(
      height: vw * 0.39,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: this.listStoreModel.length,
        itemBuilder: (context, index) {
          //

          List<String> name;

          if (this.listStoreModel[index].nameStore != null) {
            //

            name = this.listStoreModel[index].nameStore.split('');

            if (name.length > 12) {
              name.insert(12, '\n');
            }
          }

          return _Item(
            storeModel: listStoreModel[index],
            ruburo: this.ruburo,
            name: name,
            index: index,
          );
        },
      ),
    );
  }
}

class PlaceHolderFilasDeTiendas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;

    return Container(
      height: vw * 0.39,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          //

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
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
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
                    child: Container(
                      height: vw * 0.25,
                      color: hexaColor('#8C8C8C'),
                      width: vw * 0.25,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: vw * 0.01),
                  child: Container(
                    height: 0.03 * vw,
                    decoration: BoxDecoration(
                      color: hexaColor('#8C8C8C'),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: vw * 0.01),
                  child: Container(
                    height: 0.03 * vw,
                    decoration: BoxDecoration(
                      color: hexaColor('#8C8C8C'),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    Key key,
    this.ruburo,
    @required this.name,
    @required this.index,
    @required this.storeModel,
  }) : super(key: key);

  final String ruburo;
  final int index;
  final List<String> name;
  final StoreModel storeModel;

  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;

    if (this.storeModel.visibility == false) {
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
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _ImageBusiness(
            storeModel: storeModel,
            ruburo: this.ruburo,
          ),
          Container(
            // color: Colors.white,
            // height: vw * 0.1,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: vw * 0.01),
            child: Text(
              name != null ? name.join('') : '',
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
  // final String url;
  final StoreModel storeModel;
  final String ruburo;
  const _ImageBusiness({
    Key key,
    // this.url,
    this.ruburo,
    this.storeModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    if (this.storeModel.urlImage != null && this.storeModel.urlImage != '') {
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
              image: this.storeModel.urlImage,
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
          width: vw * 0.24,
          decoration: BoxDecoration(
            color: hexaColor('#BEA07D'),
            borderRadius: BorderRadius.circular(vw * 0.05),
          ),
          child: SvgPicture.asset(
            // 'assets/ruburos/todo.svg',
            'assets/ruburos/${ruburo ?? "todo"}.svg',
          ),
        ),
      );
    }
  }
}
