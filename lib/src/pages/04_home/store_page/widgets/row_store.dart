import '../../../../models/address_model.dart';

import '../../../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../../../data/services/stores/stores_service.dart';
import '../../../../models/store_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../07_ver_comercios/ver_comercio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../utils/utils.dart';

class TitleRowStore extends StatelessWidget {
  final String titleRow;
  final String category;
  TitleRowStore({
    @required this.titleRow,
    @required this.category,
  });
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;

    return BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
      builder: (context, state) {
        if (state.address == null) {
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
                PlaceholderRowStore(),
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
              RowStore(
                // listStoreModel: data.storeModel,
                category: this.category,
                addressModel: state.address,
              ),
            ],
          ),
        );
      },
    );
  }
}

class RowStore extends StatefulWidget {
  final String category;
  final AddressModel addressModel;

  RowStore({
    @required this.category,
    @required this.addressModel,
  });

  @override
  _RowStoreState createState() => _RowStoreState();
}

class _RowStoreState extends State<RowStore> {
  List<StoreModel> listStoreModel = [];
  int limit = 0;
  ScrollController _scrollController = ScrollController();
  bool _ifLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData(
      addressModel: widget.addressModel,
      category: widget.category,
    );

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _ifLoading = true;
        });
        fetchData(
          addressModel: widget.addressModel,
          category: widget.category,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          height: vw * 0.39,
          child: ListView.builder(
            controller: _scrollController,
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

              return _Store(
                name: name,
                index: index,
                ruburo: this.widget.category,
                length: this.listStoreModel.length,
                storeModel: this.listStoreModel[index],
              );
            },
          ),
        ),
        !_ifLoading
            ? Container()
            : Container(
                height: vw * 0.39,
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 20),
                child: CircularProgressIndicator(),
              )
      ],
    );
  }

  void fetchData({
    AddressModel addressModel,
    String category,
  }) async {
    //

    final cacheStoreModel = await GetAllStoreService().fetch(
      cityPath: addressModel,
      category: category,
      limit: limit,
    );

    setState(() {
      listStoreModel.addAll(cacheStoreModel.storeModel);
      limit += 10;
      _ifLoading = false;
    });
  }
}

class PlaceholderRowStore extends StatelessWidget {
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

          return PlaceholderStore(
            index: index,
          );
        },
      ),
    );
  }
}

class PlaceholderStore extends StatelessWidget {
  const PlaceholderStore({
    Key key,
    @required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
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
  }
}

class _Store extends StatelessWidget {
  const _Store({
    Key key,
    this.ruburo,
    @required this.name,
    @required this.index,
    @required this.storeModel,
    @required this.length,
  }) : super(key: key);

  final String ruburo;
  final int index;
  final int length;
  final List<String> name;
  final StoreModel storeModel;

  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;

    if (this.storeModel.visibilityStore == false) {
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
      margin: margin(
        index: index,
        vw: vw,
        length: length,
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

  EdgeInsetsGeometry margin({
    int index,
    double vw,
    int length,
  }) {
    if (index == 0) {
      return EdgeInsets.only(
        left: vw * 0.05,
        top: vw * 0.02,
        right: vw * 0.04,
      );
    } else if (index == (length - 1)) {
      return EdgeInsets.only(
        top: vw * 0.02,
        right: vw * 0.2,
      );
    } else {
      return EdgeInsets.only(
        top: vw * 0.02,
        right: vw * 0.04,
      );
    }
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
    if (this.storeModel.urlImageStore != null &&
        this.storeModel.urlImageStore != '') {
      return InkWell(
        onTap: () {
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
              image: this.storeModel.urlImageStore,
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
