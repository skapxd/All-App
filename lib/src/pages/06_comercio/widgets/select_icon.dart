import 'dart:io';

import 'package:allapp/src/data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:allapp/src/data/shared/pref.dart';
import 'package:allapp/src/data/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/utils.dart';

class SelecteIcon extends StatefulWidget {
  final bool ifEnable;
  final String category;

  SelecteIcon({
    @required this.category,
    this.ifEnable = true,
  });

  @override
  _SelecteIconState createState() => _SelecteIconState();
}

class _SelecteIconState extends State<SelecteIcon> {
  final picker = ImagePicker();
  File _image;
  final _pref = Pref();

  Future getImage(
    BuildContext context,
  ) async {
    final _miUbicacion = BlocProvider.of<MiUbicacionBloc>(context).state;
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() async {
        //

        _image = File(pickedFile.path);

        _pref.iconPath = await FirebaseStorage().uploadLogo(
          phone: _pref.phone,
          filePath: _image.path,
          categories: widget.category,
          cityPath: _miUbicacion.address,
          onSuccess: () => Navigator.pop(context),
        );
      });
    } else {
      print('No image selected.');
    }
  }

  Widget imageIcon(double vw, double vh) {
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
