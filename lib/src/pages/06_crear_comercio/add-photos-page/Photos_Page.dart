import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../../data/db/firestore.dart';
import '../../../data/shared/pref.dart';
import '../../../utils/utils.dart';
import '../../../widgets/BackgroundGradient.dart';
// import '../../../widgets/PageImage.dart';
import 'Image_Page.dart';

class PhotosPage extends StatefulWidget {
  static final String pathName = '/PhotosPage';

  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      print('ScrollListener ${_scrollController.offset}');
    });
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: rgbColor(0, 0, 0, 0),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: hexaColor('#303030'),
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: hexaColor('#D5D5D5'),
          splashColor: hexaColor('#FFFFFF'),
          child: Icon(
            // Icons.cloud_upload,
            Icons.add_photo_alternate_outlined,
            color: hexaColor('#232323'),
          ),
          onPressed: () {
            Navigator.pushNamed(context, AddPageImage.pathName);
          },
        ),
        appBar: AppBar(
          title: Text(
            'IMAGENES',
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.5,
              fontSize: 15,
              color: hexaColor('#E6D29F'),
              letterSpacing: 5,
            ),
          ),
          leading: InkWell(
            borderRadius: BorderRadius.circular(vw),
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: SvgPicture.asset(
                'assets/icons/back-arrow.svg',
              ),
            ),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: hexaColor('#303030'),
        ),
        backgroundColor: hexaColor('#303030'),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: StreamBuilder(
              stream: DBFirestore().getPhotosStore(
                phoneIdStore: Pref().phone,
                cityPath: miUbicacionBloc.state.address,
              ),
              builder: (
                context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
              ) {
                //

                if (snapshot.data == null) {
                  return Container();
                }

                final data = snapshot.data.docs;

                return StaggeredGridView.countBuilder(
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  itemCount: data.length,
                  crossAxisCount: 4,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  staggeredTileBuilder: (int index) {
                    // double size
                    return StaggeredTile.count(
                      2,
                      index.isOdd ? 3 : 3.3,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) =>
                      new Container(
                    decoration: BoxDecoration(
                      color: index.isEven
                          ? hexaColor('#D6D6D6', opacity: 0.5)
                          : hexaColor('#D6D6D6', opacity: 0.3),
                      borderRadius: BorderRadius.circular(vw * 0.07),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(vw * 0.07),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          PageImageComercio.pathName,
                          arguments: {'index': index, 'data': data},
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(vw * 0.07),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: data[index].data()['urlImage'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// import '../utils/utils.dart';
// import 'BackgroundGradient.dart';

class PageImageComercio extends StatefulWidget {
  static final String pathName = '/PageImage';

  @override
  _PageImageComercioState createState() => _PageImageComercioState();
}

class _PageImageComercioState extends State<PageImageComercio> {
  //

  int index;

  Map<String, dynamic> args;

  PageController _controller;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> data;

  @override
  void initState() {
    super.initState();

    _controller = PageController();
    Future.delayed(Duration.zero, () {
      setState(() {
        _controller.jumpToPage(index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    args = ModalRoute.of(context).settings.arguments;

    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);

    data = args['data'];

    index = args['index'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexaColor('#232323'),
        leading: InkWell(
          borderRadius: BorderRadius.circular(vw),
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset(
              'assets/icons/back-arrow.svg',
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Navigator.pop(context);

              print('delete');
              showSnackBar(
                context: context,
                text: Text(
                  'Borrando Imagen',
                  style: TextStyle(color: hexaColor('#303030')),
                ),
              );

              try {
                DBFirestore().deletePhotosStore(
                  idImage: data[index].id,
                  cityPath: miUbicacionBloc.state.address,
                  phoneIdStore: Pref().phone,
                );
              } catch (e) {
                showSnackBar(
                  context: context,
                  text: Text(
                    'No se pudo borrar la imagen, por favor intente de nuevo',
                    style: TextStyle(color: hexaColor('#303030')),
                  ),
                );
              }
            },
          )
        ],
      ),
      body: CustomBackgroundGradient(
        child: PageView.builder(
          itemCount: data.length,
          controller: _controller,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            // return Container(
            //   alignment: Alignment.center,
            //   margin: EdgeInsets.all(10),
            //   color: hexaColor('#BEA07D'),
            //   child: Text('$index'),
            // );

            return FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: data[index].data()['urlImage'],
              fit: BoxFit.fitWidth,
            );
          },
        ),
      ),
    );
  }
}
