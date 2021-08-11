import 'dart:io';

import '../../../../utils/utils.dart';
import '../../../../widgets/BackgroundGradient.dart';
import '../../../../widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPageImage extends StatefulWidget {
  static final String pathName = '/AddPageImage';

  @override
  _AddPageImageState createState() => _AddPageImageState();
}

class _AddPageImageState extends State<AddPageImage> {
  //

  final picker = ImagePicker();

  File _image;

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

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: hexaColor('#D5D5D5'),
        splashColor: hexaColor('#FFFFFF'),
        child: Icon(
          Icons.cloud_upload,
          color: hexaColor('#232323'),
        ),
        onPressed: () {
          //

          try {
            Navigator.pop(context);

            customShowSnackBar(
              context: context,
              text: Text(
                "subiendo imagen",
                style: TextStyle(color: hexaColor('#303030')),
              ),
              backGround: hexaColor('#d5d5d5'),
              systemNavigationBarColor: hexaColor('#d5d5d5'),
            );

            // DBFirebaseStorage().uploadImageStore(
            //   phone: _pref.phone,
            //   filePath: _image.path,
            //   cityPath: _miUbicacion.address,
            //   onSuccess: (cloudUrl) {
            //     // DBFirestore().addPhotosStore(
            //     //   phoneIdStore: Pref().phone,
            //     //   cityPath: _miUbicacion.address,
            //     //   urlImage: cloudUrl,
            //     // );
            //   },
            // );
          } catch (e) {
            //

            customShowSnackBar(
              context: context,
              text: Text(
                "No se pudo guardar la imagen",
                style: TextStyle(color: hexaColor('#303030')),
              ),
              backGround: hexaColor('#d5d5d5'),
              systemNavigationBarColor: hexaColor('#d5d5d5'),
            );

            print('AddPageImage - DBFirebaseStorage().uploadLogo() failed');
          }
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
                    fit: BoxFit.fitWidth,
                    height: vh,
                    width: vw,
                  ),
          ),
        ),
      ),
    );
  }
}
