import 'dart:io';

import '../../../../data/shared/pref.dart';
import '../../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SelecteIconComercio extends StatefulWidget {
  final bool ifEnable;
  final String category;
  final String initialImage;
  final Function(File file) onSelected;

  SelecteIconComercio({
    @required this.category,
    this.ifEnable = true,
    this.initialImage,
    this.onSelected,
  });

  @override
  _SelecteIconComercioState createState() => _SelecteIconComercioState();
}

class _SelecteIconComercioState extends State<SelecteIconComercio> {
  //

  final _pref = Pref();

  final picker = ImagePicker();

  File _image;

  Future getImage() async {
    //

    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 512,
    );

    try {
      setState(() {
        //

        _image = File(pickedFile.path);

        if (widget.onSelected != null) {
          widget.onSelected(_image);
        }
      });
    } catch (e) {
      //
      print('SelecteIcon - error: $e');
    }
  }

  Widget imageIcon(double vw, double vh) {
    //

    // _image = _pref.iconLocalPath != null ? File(_pref.iconLocalPath) : null;

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
              await getImage();
            },
      child: imageIcon(vw, vh),
    );
  }
}
