import 'package:allapp/src/pages/06_comercio/crear-productos-page/crear_producto.dart';
import 'package:allapp/src/pages/06_comercio/widgets/select_icon.dart';
import 'package:allapp/src/widgets/OutLineButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:allapp/src/utils/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'bloc/comercio_bloc.dart';

class ComercioPage extends StatelessWidget {
  static final String pathName = '/ComercioPage';

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: rgbColor(0, 0, 0, 0),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: hexaColor('#303030'),
      ),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              highlightColor: rgbColor(0, 0, 0, 0),
              splashColor: rgbColor(0, 0, 0, 0),
              child: Container(
                height: vw * 0.07,
                width: vw * 0.07,
                child: SvgPicture.asset(
                  'assets/icons/report-issue.svg',
                  height: vw * 0.07,
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Importante'),
                    );
                  },
                );
              },
            ),
            SizedBox(
              width: vw * 0.05,
            )
          ],
          title: Text(
            'TIENDA',
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
        // backgroundColor: hexaColor('#000000'),
        backgroundColor: hexaColor('#303030'),
        body: Container(
          width: vw,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: BlocBuilder<ComercioBloc, ComercioState>(
              builder: (context, state) {
                ComercioIfEditar stateTemp = ComercioIfEditar(ifEnable: true);

                if (state is ComercioIfEditar) {
                  stateTemp = state;
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: vw * 0.1,
                    ),
                    SelecteIcon(
                      ifEnable: stateTemp.ifEnable,
                    ),
                    SizedBox(
                      height: vw * 0.1,
                    ),
                    _IfSwichFormulario(
                      text: 'Habilitar edición',
                      onChanged: (value) {
                        BlocProvider.of<ComercioBloc>(context)
                            .add(AddComercioIfEnableEditar(value));
                      },
                    ),
                    _IfSwichFormulario(
                      text: 'Visibilidad de la tienda',
                      onChanged: (value) {},
                      initialIfEnable: false,
                    ),
                    Form(
                      child: Container(
                        width: vw * 0.7,
                        child: Column(
                          children: [
                            _CustomTextInput(
                              ifEnable: stateTemp.ifEnable,
                              text: 'Nombre de tienda',
                              margin: EdgeInsets.only(bottom: vw * 0.03),
                              onChange: (value) {
                                print(value);
                              },
                              iconPath: 'assets/icons/settings-shop-2.svg',
                            ),
                            _CustomTextInput(
                              ifEnable: stateTemp.ifEnable,
                              keyboardType: TextInputType.phone,
                              text: 'Teléfono',
                              maxLength: 13,
                              maskTextInputFormatter: MaskTextInputFormatter(
                                mask: '### ### ## ##',
                                filter: {"#": RegExp(r'[0-9]')},
                              ),
                              margin: EdgeInsets.only(bottom: vw * 0.03),
                              onChange: (value) {
                                print(value);
                              },
                              iconPath: 'assets/icons/call.svg',
                            ),
                            _CustomTextInput(
                              ifEnable: stateTemp.ifEnable,
                              keyboardType: TextInputType.phone,
                              maxLength: 13,
                              text: 'WhatsApp',
                              maskTextInputFormatter: MaskTextInputFormatter(
                                mask: '### ### ## ##',
                                filter: {"#": RegExp(r'[0-9]')},
                              ),
                              margin: EdgeInsets.only(bottom: vw * 0.03),
                              onChange: (value) {
                                print(value);
                              },
                              iconPath: 'assets/icons/whatsapp.svg',
                            ),
                            _CustomTextInput(
                              ifEnable: stateTemp.ifEnable,
                              maxLength: null,
                              text: 'Telegram ej: @Nombre',
                              margin: EdgeInsets.only(bottom: vw * 0.08),
                              onChange: (value) {
                                print(value);
                              },
                              iconPath: 'assets/icons/telegram.svg',
                            ),
                            _CustomTextInput(
                              ifEnable: stateTemp.ifEnable,
                              // maskTextInputFormatter: MaskTextInputFormatter(
                              //   mask: '### ### - #############',
                              //   filter: {"#": RegExp(r'[0-9]')},
                              // ),
                              text: 'Dirección ej: Cll ## ## ',
                              maxLength: null,
                              margin: EdgeInsets.only(bottom: vw * 0.08),
                              onChange: (value) {
                                print(value);
                              },
                              iconPath: 'assets/icons/lat-lan.svg',
                            ),
                          ],
                        ),
                      ),
                    ),
                    _CustomButton(
                      ifEnable: stateTemp.ifEnable,
                    ),
                    CustomOutLineButton(
                      margin: EdgeInsets.only(bottom: vw * 0.1),
                      textStyle: CustomOutLineButton.defaultTextStyle.copyWith(
                        letterSpacing: 5,
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, CrearProductosPage.pathName);
                      },
                      text: 'CREAR PRODUCTOS',
                      width: vw * 0.7,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: vw * 0.08),
                      width: vw * 0.7,
                      child: InkWell(
                        highlightColor: rgbColor(0, 0, 0, 0),
                        splashColor: rgbColor(0, 0, 0, 0),
                        onTap: () => print('object'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: vw * 0.15,
                                  width: vw * 0.15,
                                  decoration: BoxDecoration(
                                    color: hexaColor('#BEA07D'),
                                    borderRadius: BorderRadius.circular(vw),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(vw * 0.03),
                                    child: SvgPicture.asset(
                                      'assets/icons/camara.svg',
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: vw * 0.105,
                                  // left: 42,
                                  child: Icon(
                                    Icons.add,
                                    color: hexaColor('#FFDEBD'),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              'AGREGAR FOTOS \nDEL COMERCIO',
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.8,
                                letterSpacing: 5,
                                color: hexaColor('#BEA07D'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _IfSwichFormulario extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final String text;
  final bool initialIfEnable;
  const _IfSwichFormulario({
    Key key,
    this.onChanged,
    this.text,
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
    // state = widget.initialIfEnable ?? true;
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
              color: hexaColor('#D6D6D6', opacity: 0.4),
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

class _CustomButton extends StatelessWidget {
  final bool ifEnable;
  _CustomButton({
    this.ifEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: vw * 0.08),
      child: InkWell(
        borderRadius: BorderRadius.circular(vw),
        child: Container(
          width: vw * 0.7,
          height: vw * 0.12,
          decoration: BoxDecoration(
            // color: Colors.red,
            border: Border.all(
              width: 1,
              color: ifEnable ? hexaColor('#D6D6D6') : hexaColor('#303030'),
            ),
            borderRadius: BorderRadius.circular(vw),
          ),
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
          // margin: EdgeInsets.only(bottom: vw * 0.03),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: SvgPicture.asset(
                  'assets/icons/lat-lan.svg',
                  // height: 5,
                ),
              ),
              Container(
                width: vw * 0.55,
                child: Text(
                  'Ubicación',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: hexaColor('#D6D6D6', opacity: 0.4),
                  ),
                ),
              )
            ],
          ),
        ),
        onTap: !this.ifEnable
            ? null
            : () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AnnotatedRegion<SystemUiOverlayStyle>(
                      value: SystemUiOverlayStyle(
                        statusBarColor: rgbColor(0, 0, 0, 0),
                        statusBarIconBrightness: Brightness.light,
                        systemNavigationBarIconBrightness: Brightness.light,
                        systemNavigationBarColor: hexaColor('#101010'),
                      ),
                      child: AlertDialog(
                        backgroundColor: hexaColor('#303030'),
                        title: Text(
                          'Importante',
                          style: TextStyle(
                            color: hexaColor('#A3A3A3'),
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Text(
                                'Para obtener la ubicación en Latitud y Longitud, debe estar en el lugar del comercio que quiere publicar',
                                style: TextStyle(
                                  color: hexaColor('#A3A3A3'),
                                ),
                              ),
                            )
                          ],
                        ),
                        actions: [
                          OutlinedButton(
                            onPressed: () {
                              print('Obtener lat-lan');
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                  hexaColor('#FFFFFF', opacity: 0.2)),
                              side: MaterialStateProperty.all(
                                BorderSide(
                                  style: BorderStyle.solid,
                                  color: hexaColor('#BEA07D'),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Text(
                              'Mejor no',
                              style: TextStyle(
                                color: hexaColor('#A3A3A3'),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  hexaColor('#BEA07D')),
                              side: MaterialStateProperty.all(
                                BorderSide(
                                  style: BorderStyle.solid,
                                  color: hexaColor('#BEA07D'),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Obtener',
                              style: TextStyle(
                                color: hexaColor('#303030'),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
      ),
    );
  }
}

class _CustomTextInput extends StatelessWidget {
  final String text;
  final int maxLength;
  final String iconPath;
  final EdgeInsets margin;
  final TextInputType keyboardType;
  final ValueChanged<String> onChange;
  final String formatters;
  final bool ifEnable;
  final RegExp filterValues;
  final MaskTextInputFormatter maskTextInputFormatter;

  // final maskFormatter = new MaskTextInputFormatter(
  //     mask: '### ### ## ##', filter: {"#": RegExp(r'[0-9]')});

  _CustomTextInput({
    Key key,
    @required this.text,
    @required this.iconPath,
    @required this.onChange,
    this.margin,
    this.keyboardType,
    this.formatters,
    this.ifEnable,
    this.filterValues,
    this.maskTextInputFormatter,
    this.maxLength = 21,
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
        enabled: this.ifEnable,
        inputFormatters: [this.maskTextInputFormatter],
        // inputFormatters: this.keyboardType == TextInputType.phone
        //     ? [
        //         MaskTextInputFormatter(
        //           mask: this.formatters,
        //           filter: {this.formatters[0]: this.filterValues},
        //         )
        //       ]
        //     : [],
        keyboardType: this.keyboardType,
        maxLength: this.maxLength,
        onChanged: this.onChange,
        style: TextStyle(
          color: hexaColor('#D6D6D6'),
          // height: 0,
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
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Container(
            // height: 5,
            margin: EdgeInsets.only(
              left: 15,
              top: 5,
              bottom: 5,
              right: 10,
            ),
            child: SvgPicture.asset(
              this.iconPath,
              height: 5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hexaColor('#D6D6D6'),
            ),
            borderRadius: BorderRadius.circular(vw * .1),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hexaColor('#D6D6D6'),
            ),
            borderRadius: BorderRadius.circular(vw * .1),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: hexaColor('#D6D6D6'),
            ),
            borderRadius: BorderRadius.circular(vw * .1),
          ),
        ),
      ),
    );
  }
}
