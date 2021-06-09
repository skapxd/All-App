import 'package:allapp/src/data/db/firestore.dart';
import 'package:allapp/src/pages/06_comercio/widgets/if_swich_formulario.dart';
import 'package:allapp/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../../data/shared/pref.dart';
import '../../../data/storage/storage.dart';
import '../../../utils/utils.dart';

class CrearProductoPage extends StatelessWidget {
  //

  static final pathName = 'CrearProductoPage';

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    final categorieName = ModalRoute.of(context).settings.arguments;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0x00000000),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: hexaColor('#303030'),
      ),
      sized: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            categorieName,
            // 'PRODUCTOS',
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
        body: Stack(
          children: [
            Positioned(
              bottom: 14.5,
              right: 14.5,
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: rgbColor(0, 0, 0, 0),
                    barrierColor: rgbColor(0, 0, 0, 0),
                    builder: (BuildContext context) {
                      return _ModalButtomTipoDeTienda();
                    },
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      height: vw * 0.15,
                      width: vw * 0.15,
                      decoration: BoxDecoration(
                        color: hexaColor('#FFFFFF'),
                        borderRadius: BorderRadius.circular(vw),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(vw * 0.03),
                        child: SvgPicture.asset(
                          'assets/icons/box.svg',
                        ),
                      ),
                    ),
                    Positioned(
                      left: vw * 0.105,
                      // left: 42,
                      child: Icon(
                        Icons.add,
                        color: hexaColor('#aaaaaa'),
                        // color: hexaColor('#FFDEBD'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModalButtomTipoDeTienda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ListItems();
  }
}

class _ListItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double vh = MediaQuery.of(context).size.height;
    final double vw = MediaQuery.of(context).size.width;
    // final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context).state;

    return FutureBuilder(
      future: DBFirestore().getCategory(categories: 'supermercado'),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        //

        final data = snapshot.data;

        if (data == null) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Color(0x00000000),
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: hexaColor('#D6D6D6'),
            ),
            sized: false,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: vw * 0.03),
              width: vw * 0.9,
              height: vh * 0.8,
              padding: EdgeInsets.only(
                top: vw * 0.07,
                left: vw * 0.07,
                right: vw * 0.07,
              ),
              decoration: BoxDecoration(
                color: hexaColor('#D6D6D6'),

                // color: hexaColor('#333333'),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(vw * 0.05),
                  topRight: Radius.circular(vw * 0.05),
                ),
              ),
            ),
          );
        }

        // print(data);

        // return Container();

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Color(0x00000000),
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: hexaColor('#D6D6D6'),
          ),
          sized: false,
          child: Container(
            height: vh * 0.8,
            margin: EdgeInsets.symmetric(horizontal: vw * 0.03),
            padding: EdgeInsets.only(
              top: vw * 0.07,
              left: vw * 0.07,
              right: vw * 0.07,
            ),
            decoration: BoxDecoration(
              // color: hexaColor('#000000'),
              color: hexaColor('#D6D6D6'),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(vw * 0.1),
                topRight: Radius.circular(vw * 0.1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SelecteIcon(
                    // category: '',
                    ),
                SizedBox(
                  height: vw * 0.03,
                ),
                Text(
                  'Agrega una foto del producto',
                  style: TextStyle(
                    color: hexaColor('#3D3D3D', opacity: 0.4),
                  ),
                ),
                SizedBox(
                  height: vw * 0.05,
                ),
                _IfSwichFormulario(
                  initialIfEnable: true,
                  onChanged: (value) {},
                  text: 'Disponibilidad',
                ),
                SizedBox(
                  height: vw * 0.05,
                ),
                _CustomTextInput(
                  onChange: (String value) {},
                  // margin: EdgeInsets.only(bottom: vw * 0.03),
                  text: 'Hola',
                ),
                SizedBox(
                  height: vw * 0.05,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _IfSwichFormulario extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final String text;
  final bool initialIfEnable;
  const _IfSwichFormulario({
    Key key,
    this.text,
    this.onChanged,
    this.initialIfEnable,
  }) : super(key: key);

  @override
  _IfSwichFormularioState createState() => _IfSwichFormularioState();
}

class _IfSwichFormularioState extends State<_IfSwichFormulario> {
  bool state;

  @override
  void initState() {
    super.initState();

    state = widget.initialIfEnable ?? true;
  }

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;
    return Container(
      width: vw * 0.7,
      margin: EdgeInsets.only(bottom: vw * 0.08),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text,
            style: TextStyle(
              color: hexaColor('#4F4F4F'),
            ),
          ),
          CupertinoSwitch(
            activeColor: hexaColor('#BEA07D'),
            onChanged: (bool value) {
              if (widget.onChanged != null) {
                widget.onChanged(value);
              }
              setState(() {
                this.state = value;
              });
            },
            value: this.state,
          ),
        ],
      ),
    );
  }
}

class SelecteIcon extends StatefulWidget {
  ///Recibe 2 argumentos, ( String localPath, String cloudPath )
  final void Function(String localPath, String cloudPath) onSelectedImage;
  final bool ifEnable;
  // final String category;

  SelecteIcon({
    // @required this.category,
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

          // FirebaseStorage()
          //     .uploadLogo(
          //   phone: _pref.phone,
          //   filePath: _image.path,
          //   categories: widget.category,
          //   cityPath: _miUbicacion.address,
          //   onSuccess: (url) => widget.onSelectedImage(
          //     pickedFile.path,
          //     url,
          //   ),
          // )
          //     .then((value) {
          //   setState(() {
          //     _image = File(pickedFile.path);
          //   });
          // });
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
              await getImage(context);
            },
      child: imageIcon(vw, vh),
    );
  }
}

class _CustomTextInput extends StatelessWidget {
  final String text;
  final EdgeInsets margin;
  final String initialValue;
  final TextInputType keyboardType;
  final ValueChanged<String> onChange;
  final TextEditingController textEditingController;

  _CustomTextInput({
    Key key,
    this.margin,
    this.initialValue,
    this.keyboardType,
    @required this.text,
    @required this.onChange,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;
    return Container(
      margin: this.margin,
      child: TextFormField(
        controller: this.textEditingController,
        initialValue: this.initialValue,
        keyboardType: this.keyboardType,
        onChanged: this.onChange,
        // scrollPadding: EdgeInsets.symmetric(horizontal: 100),

        style: TextStyle(
          color: hexaColor('#303030'),
        ),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          counterStyle: TextStyle(
            color: hexaColor('#CCCCCC'),
          ),
          hintText: this.text,
          hintStyle: TextStyle(
            height: 0,
            color: hexaColor('#D6D6D6', opacity: 0.4),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hexaColor('#111111'),
            ),
            borderRadius: BorderRadius.circular(vw * .1),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hexaColor('#111111'),
            ),
            borderRadius: BorderRadius.circular(vw * .1),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hexaColor('#111111'),
            ),
            borderRadius: BorderRadius.circular(vw * .1),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: hexaColor('#111111'),
            ),
            borderRadius: BorderRadius.circular(vw * .1),
          ),
        ),
      ),
    );
  }
}
