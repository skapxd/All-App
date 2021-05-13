import 'dart:io';

import 'package:allapp/src/pages/06_comercio/bloc/comercio_bloc.dart';
import 'package:allapp/src/utils/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SelecteIcon extends StatefulWidget {
  final bool ifEnable;

  SelecteIcon({
    this.ifEnable = true,
  });

  @override
  _SelecteIconState createState() => _SelecteIconState();
}

class _SelecteIconState extends State<SelecteIcon> {
  final picker = ImagePicker();
  File _image;

  Future getImage(
    BuildContext context,
  ) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      // BlocProvider.of<ComercioBloc>(context)
      //     .add(AddComercioIcon(File(pickedFile.path)));
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
      // child: BlocBuilder<ComercioBloc, ComercioState>(
      //   builder: (context, ComercioState state) {
      //     ComercioIcon stateTemp = ComercioIcon(icon: null);
      //     if (state is ComercioIcon) {
      //       stateTemp = state;
      //     }
      //     if (stateTemp.icon != null) {
      //       return Container(
      //         height: vw * 0.25,
      //         width: vw * 0.25,
      //         decoration: BoxDecoration(
      //           color: hexaColor('#353535'),
      //           boxShadow: [
      //             BoxShadow(
      //               color: rgbColor(0, 0, 0, 0.3),
      //               blurRadius: 10,
      //               offset: Offset(4, 4),
      //             ),
      //           ],
      //           borderRadius: BorderRadius.circular(vw * 0.05),
      //         ),
      //         child: ClipRRect(
      //           borderRadius: BorderRadius.circular(vw * 0.05),
      //           child: Image.file(
      //             stateTemp.icon,
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       );
      //     } else {
      //       return Container(
      //         padding: EdgeInsets.all(vw * 0.05),
      //         height: vw * 0.25,
      //         width: vw * 0.25,
      //         decoration: BoxDecoration(
      //           color: hexaColor('#353535'),
      //           boxShadow: [
      //             BoxShadow(
      //               color: rgbColor(0, 0, 0, 0.3),
      //               blurRadius: 10,
      //               offset: Offset(4, 4),
      //             ),
      //           ],
      //           borderRadius: BorderRadius.circular(vw * 0.05),
      //         ),
      //         child: SvgPicture.asset('assets/icons/placeholder.svg'),
      //       );
      //     }
      //     // if (stateTemp is ComercioIcon) {
      //     // } else {
      //     //   return Container(
      //     //     padding: EdgeInsets.all(vw * 0.05),
      //     //     height: vw * 0.25,
      //     //     width: vw * 0.25,
      //     //     decoration: BoxDecoration(
      //     //       color: hexaColor('#353535'),
      //     //       boxShadow: [
      //     //         BoxShadow(
      //     //           color: rgbColor(0, 0, 0, 0.3),
      //     //           blurRadius: 10,
      //     //           offset: Offset(4, 4),
      //     //         ),
      //     //       ],
      //     //       borderRadius: BorderRadius.circular(vw * 0.05),
      //     //     ),
      //     //     child: SvgPicture.asset('assets/icons/placeholder.svg'),
      //     //   );
      //     // }
      //   },
      // ),
    );
  }
}
