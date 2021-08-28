import 'dart:io';

import '../../../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SelectedIconProduct extends StatefulWidget {
  final bool ifEnable;
  final String urlImage;
  final void Function(String localPath) onSelected;

  SelectedIconProduct({
    this.ifEnable = true,
    this.urlImage,
    this.onSelected,
  });

  @override
  _SelectedIconProductState createState() => _SelectedIconProductState();
}

class _SelectedIconProductState extends State<SelectedIconProduct> {
  //

  final picker = ImagePicker();

  File _image;

  Future getImage(
    BuildContext context,
  ) async {
    //

    print('SelecteIcon - _image: $_image');

    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 512,
    );

    if (pickedFile != null) {
      try {
        setState(() {
          //

          _image = File(pickedFile.path);

          widget.onSelected(_image.path);
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

    print('SelecteIcon - widget.url ${widget.urlImage}');
    print('SelecteIcon - image $_image');

    if (_image == null && widget.urlImage == null) {
      return Container(
        // constraints: BoxConstraints.,
        padding: EdgeInsets.all(vw * 0.15),
        height: vw * 0.65,
        width: vw,
        // width: vw * 0.5,
        decoration: BoxDecoration(
          color: hexaColor('#353535'),
          boxShadow: [
            BoxShadow(
              color: rgbColor(0, 0, 0, 0.3),
              blurRadius: 10,
              offset: Offset(4, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(vw * 0.01),
        ),
        child: SvgPicture.asset(
          'assets/icons/placeholder.svg',
          height: 100,
        ),
      );
    } else if (_image != null) {
      return Container(
        width: vw,
        height: vw * 0.65,
        decoration: BoxDecoration(
          color: hexaColor('#353535'),
          boxShadow: [
            BoxShadow(
              color: rgbColor(0, 0, 0, 0.3),
              blurRadius: 10,
              offset: Offset(4, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(vw * 0.01),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(vw * 0.01),
          child: Image.file(
            _image,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      // } else if( widget.urlImage != null) {
      return Container(
        height: vw * 0.65,
        width: vw,
        decoration: BoxDecoration(
          color: hexaColor('#353535'),
          boxShadow: [
            BoxShadow(
              color: rgbColor(0, 0, 0, 0.3),
              blurRadius: 10,
              offset: Offset(4, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(vw * 0.01),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(vw * 0.01),
          child: Image.network(
            widget.urlImage,
            fit: BoxFit.cover,
          ),
        ),
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
