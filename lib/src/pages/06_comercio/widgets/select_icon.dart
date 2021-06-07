import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../../data/shared/pref.dart';
import '../../../data/storage/storage.dart';
import '../../../utils/utils.dart';

class SelecteIcon extends StatefulWidget {
  ///Recibe 2 argumentos, ( String localPath, String cloudPath )
  final void Function(String localPath, String cloudPath) onSelectedImage;
  final bool ifEnable;
  final String category;

  SelecteIcon({
    @required this.category,
    this.ifEnable = true,
    this.onSelectedImage,
  });

  @override
  _SelecteIconState createState() => _SelecteIconState();
}

class _SelecteIconState extends State<SelecteIcon> {
  //

  final _pref = Pref();

  final picker = ImagePicker();

  File _image;

  Future getImage(
    BuildContext context,
  ) async {
    //

    print('SelecteIcon - _image: $_image');

    final _miUbicacion = BlocProvider.of<MiUbicacionBloc>(context).state;
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 512,
    );

    if (pickedFile != null) {
      try {
        setState(() {
          //

          _image = File(pickedFile.path);

          FirebaseStorage()
              .uploadLogo(
            phone: _pref.phone,
            filePath: _image.path,
            categories: widget.category,
            cityPath: _miUbicacion.address,
            onSuccess: (url) => widget.onSelectedImage(
              pickedFile.path,
              url,
            ),
          )
              .then((value) {
            setState(() {
              _image = File(pickedFile.path);
            });
          });
        });
      } catch (e) {
        //
        print('SelecteIcon - error: $e');
      }
    } else {
      print('SelecteIcon - pickedFile is == null');

      print('SelecteIcon - No image selected.');
    }
  }

  Widget imageIcon(double vw, double vh) {
    //

    _image = _pref.iconLocalPath != null ? File(_pref.iconLocalPath) : null;

    if (_image != null) {
      return Container(
        height: vw * 0.25,
        width: vw * 0.25,
        decoration: BoxDecoration(
          color: hexaColor('#353535'),
          boxShadow: [
            BoxShadow(
              color: rgbColor(0, 0, 0, 0.3),
              blurRadius: 10,
              offset: Offset(4, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(vw * 0.05),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(vw * 0.05),
          child: Image.file(
            _image,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(vw * 0.05),
        height: vw * 0.25,
        width: vw * 0.25,
        decoration: BoxDecoration(
          color: hexaColor('#353535'),
          boxShadow: [
            BoxShadow(
              color: rgbColor(0, 0, 0, 0.3),
              blurRadius: 10,
              offset: Offset(4, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(vw * 0.05),
        ),
        child: SvgPicture.asset('assets/icons/placeholder.svg'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;

    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return InkWell(
      borderRadius: BorderRadius.circular(vw * 0.05),
      onTap: !this.widget.ifEnable
          ? null
          : () async {
              await getImage(context);
            },
      child: imageIcon(vw, vh),
    );
  }
}
