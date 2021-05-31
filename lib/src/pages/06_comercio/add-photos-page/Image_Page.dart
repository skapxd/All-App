import 'dart:io';

import 'package:allapp/src/data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:allapp/src/data/shared/pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/storage/storage.dart';
import '../../../utils/utils.dart';
import '../../../widgets/BackgroundGradient.dart';
import '../../../widgets/CustomText.dart';

class AddPageImage extends StatefulWidget {
  static final String pathName = '/AddPageImage';

  @override
  _AddPageImageState createState() => _AddPageImageState();
}

class _AddPageImageState extends State<AddPageImage> {
  //

  final picker = ImagePicker();

  File _image;

  final _pref = Pref();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    final _miUbicacion = BlocProvider.of<MiUbicacionBloc>(context).state;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: hexaColor('#D5D5D5'),
        splashColor: hexaColor('#FFFFFF'),
        child: Icon(
          Icons.cloud_upload,
          color: hexaColor('#232323'),
        ),
        onPressed: () {
          print(_image.path);
          print(_image.absolute);
          print(_image.uri);
          FirebaseStorage().uploadLogo(
            phone: _pref.phone,
            filePath: _image.path,
            categories: 'todo',
            cityPath: _miUbicacion.address,
            onSuccess: () => Navigator.pop(context),
          );
        },
      ),
      body: CustomBackgroundGradient(
        child: InkWell(
          onTap: getImage,
          child: Container(
            height: vh,
            width: vw,
            alignment: Alignment.center,
            // margin: EdgeInsets.all(10),
            child: _image == null
                ? CustomText('TOUCH ME')
                : Image.file(
                    _image,
                    fit: BoxFit.cover,
                    height: vh,
                    width: vw,
                  ),
          ),
        ),
      ),
    );
  }
}
