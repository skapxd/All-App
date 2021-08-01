import '../../../widgets/BackgroundGradient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class VerPageImageComercio extends StatefulWidget {
  static final String pathName = '/VerPageImage';

  @override
  _VerPageImageComercioState createState() => _VerPageImageComercioState();
}

class _VerPageImageComercioState extends State<VerPageImageComercio> {
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
    args = ModalRoute.of(context).settings.arguments;

    data = args['data'];

    index = args['index'];

    return Scaffold(
      body: CustomBackgroundGradient(
        child: PageView.builder(
          itemCount: data.length,
          controller: _controller,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
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
