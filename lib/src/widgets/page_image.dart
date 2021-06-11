import 'package:allapp/src/data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:allapp/src/data/db/firestore.dart';
import 'package:allapp/src/data/shared/pref.dart';
import 'package:allapp/src/utils/utils.dart';
import 'package:allapp/src/widgets/BackgroundGradient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transparent_image/transparent_image.dart';

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
