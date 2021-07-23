import 'package:allapp/src/models/store_model.dart';

import '../../../data/services/stores/stores.service.dart';

import '../../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../../data/shared/pref.dart';
import '../../../utils/utils.dart';
import '../../../widgets/OutLineButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'add-photos-page/Photos_Page.dart';
import 'bloc/comercio_bloc.dart';
import 'grupo_productos/grupo_productos.dart';
import 'mapa_page/mapa_page.dart';
import 'widgets/custom_buttom.dart';
import 'widgets/if_swich_formulario_comercio.dart';
import 'widgets/select_icon_comercio.dart';
import 'widgets/tipos_de_tiendas.dart';

class ComercioPage extends StatefulWidget {
  static final String pathName = '/ComercioPage';

  @override
  _ComercioPageState createState() => _ComercioPageState();
}

class _ComercioPageState extends State<ComercioPage> {
  final String importante =
      '''El logo se guarda automáticamente al seleccionarlo, si no cambia es porque no tiene acceso a internet

El resto de información se guardara en la nube cuando decida hacer publica su tienda

Si desea modificar algún elemento del formulario deberá desactivar la visibilidad de la tienda y volverla a activar

La Tienda será visible en su teléfono en un tiempo aproximado de 30min

Usted puede deshabilitar la edición para no cambiar de forma accidental los datos escritos

También puede cambiar la visibilidad de la tienda en cualquier momento

All App permite que múltiples tiendas tengan el mismo nombre, si su tienda está registrada en cámara y comercio All App puede certificar su tienda

Usted debe autorizar a los domiciliarios que le llevaran sus domicilios, de forma predeterminada no tiene ningún domiciliario autorizado, con ingresar los números de teléfono los autoriza

Si usted no cuenta con contactos de domiciliarios de confianza, usted puede utilizar los contactos que All App le ofrece

Si usted utiliza los contactos que All App ofrece, All App no se hace responsable del rendimiento, responsabilidad, efectividad o cuentas pendientes que tenga con el domiciliario

En el caso de que algún domiciliario le llegase a quedar mal por cualquier motivo usted podrá puntuarlo y All App se encargara de hacer visible su reseña a todas las demás tiendas, las reseñas negativas (o positivas) impacta inmediatamente en la reputación del domiciliario  

All App se reserva el derecho a cambiar estos términos en cualquier momento, por favor léalos periódicamente

Se asumirá que usted está de acuerdo si decide continuar
''';

  Pref _pref;

  StoresService storesService;

  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();

    storesService = StoresService();

    _pref = Pref();

    _formKey = GlobalKey<FormState>();

    Future.delayed(Duration.zero,
        () => _pref.ifVerInfoDeTienda ? showCustomDialog(context) : null);
  }

  showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      routeSettings: RouteSettings(),
      builder: (context) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: rgbColor(0, 0, 0, 0),
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarColor: hexaColor('#101010'),
          ),
          sized: false,
          child: AlertDialog(
            backgroundColor: hexaColor('#232323'),
            // backgroundColor: hexaColor('#303030'),
            title: Text(
              'Importante',
              style: TextStyle(
                color: hexaColor('#A3A3A3'),
              ),
            ),
            content: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Text(
                      this.importante,
                      style: TextStyle(
                        color: hexaColor('#A3A3A3'),
                      ),
                    ),
                  )
                ],
              ),
            ),
            actions: [
              IfSwichFormularioComercio(
                initialIfEnable: !_pref.ifVerInfoDeTienda,
                text: 'Aceptar términos',
                onChanged: (value) {
                  print('ComercioPage - Swich of termns $value');
                  _pref.ifVerInfoDeTienda = !value;
                  final bloc = BlocProvider.of<ComercioBloc>(context);
                  bloc.add(AddAceptoTerminos(!value));
                  print('ComercioPage - bloc:  ${bloc.state.aceptoTerminos}');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    final comercioBloc = BlocProvider.of<ComercioBloc>(context);
    final miUbicacion = BlocProvider.of<MiUbicacionBloc>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: rgbColor(0, 0, 0, 0),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: hexaColor('#303030'),
        // systemNavigationBarColor: hexaColor('#303030'),
      ),
      sized: true,
      child: Scaffold(
        // backgroundColor: hexaColor('#232323'),
        backgroundColor: hexaColor('#303030'),
        appBar: AppBar(
          elevation: 10,
          centerTitle: true,
          backgroundColor: hexaColor('#353535'),
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
                showCustomDialog(context);
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
        ),
        body: Container(
          width: vw,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: BlocBuilder<ComercioBloc, ComercioState>(
              builder: (context, state) {
                final _controllerTelefonoTienda =
                    TextEditingController(text: _pref.telefotoDeTienda);

                final _controllerWhatsAppTienda =
                    TextEditingController(text: _pref.whatsAppDeTienda);

                if (state.aceptoTerminos) {
                  return Container();
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: vw * 0.1,
                      ),
                      SelecteIconComercio(
                        category: 'todo',
                        ifEnable: _pref.ifHabilitarEdicion,
                        onSelected: (file) {
                          comercioBloc.add(AddComercioIcon(file));
                          print(file);
                        },
                      ),
                      SizedBox(
                        height: vw * 0.1,
                      ),
                      IfSwichFormularioComercio(
                        text: 'Habilitar edición',
                        initialIfEnable: _pref.ifHabilitarEdicion,
                        onChanged: (value) {
                          _pref.ifHabilitarEdicion = value;
                          comercioBloc.add(AddComercioIfEnableEditar(value));
                        },
                      ),
                      IfSwichFormularioComercio(
                        text: 'Visibilidad de la tienda',
                        initialIfEnable: _pref.ifVisibilidadDeTienda,
                        onChanged: (value) {
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            _pref.ifVisibilidadDeTienda = value;
                            // comercioBloc.add(AddToggleViewStore(value));

                            // final Map<String, Map<String, double>> mapLatLng =
                            //     {};
                            final List<Map<String, double>> mapLatLng = [];

                            miUbicacion.state.markers.forEach((key, value) {
                              mapLatLng.add({
                                'lat': value.position.latitude,
                                'lng': value.position.longitude,
                              });
                              // print('ComercioPage - mapLatLng: $mapLatLng');
                            });

                            // DBFirestore().addStore(
                            //   categories: _pref.nombreTipoDeTienda,
                            //   visibilidad: value,
                            //   latLng: mapLatLng,
                            //   phoneIdStore: _pref.phone,
                            //   nameStore: _pref.nombreDeTienda,
                            //   cityPath: miUbicacion.state.address,
                            //   telegram: _pref.telegramDeTienda,
                            //   phoneCall: _pref.telefotoDeTienda,
                            //   direccion: _pref.direccionDeTienda,
                            //   phoneWhatsApp: _pref.whatsAppDeTienda,
                            //   urlImage: _pref.iconCludPath,
                            // );
                          } else {
                            customShowSnackBar(
                              context: context,
                              text: Text(
                                'La tienda no sera visible hasta llenar todos los campos',
                                style: TextStyle(color: hexaColor('#303030')),
                              ),
                            );
                          }
                        },
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          width: vw * 0.7,
                          child: Column(
                            children: [
                              _CustomTextInput(
                                iconPath: 'assets/icons/settings-shop-2.svg',
                                initialValue: _pref.nombreDeTienda,
                                maskTextInputFormatter: null,
                                ifEnable: _pref.ifHabilitarEdicion,
                                text: 'Nombre de tienda',
                                margin: EdgeInsets.only(bottom: vw * 0.03),
                                onChange: (value) {
                                  _pref.nombreDeTienda = value;
                                  print('ComercioPage $value');
                                },
                              ),
                              CustomButton(
                                ifData: _pref.pathIconTipoDeTienda != null ||
                                        state.pathTipoDeTienda != null
                                    ? true
                                    : false,
                                iconPath: _pref.pathIconTipoDeTienda ??
                                    state.pathTipoDeTienda ??
                                    'assets/icons/settings-shop-2.svg',
                                text: _pref.categoriaDeTienda ??
                                    state.nombreTipoDeTienda ??
                                    'Tipo de tienda',
                                ifEnable: _pref.ifHabilitarEdicion,
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    backgroundColor: rgbColor(0, 0, 0, 0),
                                    builder: (BuildContext context) {
                                      return ModalButtomTipoDeTienda();
                                    },
                                  );
                                },
                              ),
                              _CustomTextInput(
                                textEditingController:
                                    _controllerTelefonoTienda,
                                // initialValue: _pref.telefotoDeTienda,
                                ifEnable: _pref.ifHabilitarEdicion,
                                keyboardType: TextInputType.phone,
                                text: 'Teléfono',
                                maxLength: 13,
                                margin: EdgeInsets.only(bottom: vw * 0.03),
                                iconPath: 'assets/icons/call.svg',
                                maskTextInputFormatter: [
                                  MaskTextInputFormatter(
                                    mask: '### ### ## ##',
                                    filter: {"#": RegExp(r'[0-9]')},
                                  )
                                ],
                                onChange: (value) {
                                  _pref.telefotoDeTienda = value;

                                  if (value.length == 13) {
                                    FocusScope.of(context).unfocus();
                                  }
                                },
                              ),
                              _CustomTextInput(
                                ifEnable: _pref.ifHabilitarEdicion,
                                keyboardType: TextInputType.phone,
                                maxLength: 13,
                                textEditingController:
                                    _controllerWhatsAppTienda,
                                text: 'WhatsApp',
                                iconPath: 'assets/icons/whatsapp.svg',
                                margin: EdgeInsets.only(bottom: vw * 0.03),
                                maskTextInputFormatter: [
                                  MaskTextInputFormatter(
                                    mask: '### ### ## ##',
                                    filter: {"#": RegExp(r'[0-9]')},
                                  )
                                ],
                                onChange: (value) {
                                  _pref.whatsAppDeTienda = value;

                                  if (value.length == 13) {
                                    FocusScope.of(context).unfocus();
                                  }
                                },
                              ),
                              _CustomTextInput(
                                ifEnable: _pref.ifHabilitarEdicion,
                                initialValue: _pref.telegramDeTienda,
                                maxLength: null,
                                iconPath: 'assets/icons/telegram.svg',
                                text: 'Telegram ej: @Nombre',
                                margin: EdgeInsets.only(bottom: vw * 0.08),
                                onChange: (value) {
                                  _pref.telegramDeTienda =
                                      value.replaceAll('@', '');
                                  print('ComercioPage $value');
                                },
                              ),
                              _CustomTextInput(
                                ifEnable: _pref.ifHabilitarEdicion,
                                initialValue: _pref.direccionDeTienda,
                                text: 'Dirección ej: Cll ## ##',
                                maxLength: null,
                                margin: EdgeInsets.only(bottom: vw * 0.08),
                                onChange: (value) {
                                  _pref.direccionDeTienda = value;
                                  print('ComercioPage $value');
                                },
                                iconPath: 'assets/icons/lat-lan.svg',
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomButton(
                        ifData: _pref.ifHabilitarEdicion != null ? true : false,
                        text: 'Ubicación',
                        iconPath: 'assets/icons/lat-lan.svg',
                        ifEnable: _pref.ifHabilitarEdicion,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ComercioMapaPage.pathName,
                            arguments: {'latLng': List<LatLng>()},
                          );
                          // DBFirestore().accesoGps(
                          // // DBFirestore().accesoGps(
                          //   onGranted: () {
                          // }
                          // );
                        },
                      ),
                      CustomOutLineButton(
                        text: 'GUARDAR',
                        margin: EdgeInsets.only(bottom: vw * 0.1),
                        width: vw * 0.7,
                        textStyle:
                            CustomOutLineButton.defaultTextStyle.copyWith(
                          letterSpacing: 5,
                        ),
                        onTap: () {
                          final phone = '${_pref.countryCode}-${_pref.phone}';

                          final file = comercioBloc.state.icon?.path;

                          if (file != null) {
                            storesService.uploadLogo(
                              file: file,
                            );
                          }

                          storesService.createStore(
                            nameStore: _pref.nombreDeTienda,
                            contactStore: ContactStore(
                              phonCallStore: _pref.telefotoDeTienda,
                              telegramStore: _pref.telegramDeTienda,
                              whatsAppStore: _pref.whatsAppDeTienda,
                            ),
                            addressStore: _pref.direccionDeTienda,
                            categoryStore: _pref.categoriaDeTienda,
                            geolocationStore: [
                              CustomGeoLocation(lat: 123.321, lng: 321.123),
                            ],
                            onProgress: () {
                              customShowSnackBar(
                                context: context,
                                text: Text(
                                  'Guardando datos',
                                  style: TextStyle(
                                    color: hexaColor('#666666'),
                                  ),
                                ),
                              );
                            },
                            onFailed: ({data}) {
                              customShowSnackBar(
                                context: context,
                                text: Text(
                                  'Error al guardar datos',
                                  style: TextStyle(
                                    color: hexaColor('#666666'),
                                  ),
                                ),
                              );
                            },
                            onSuccess: ({data}) {
                              customShowSnackBar(
                                context: context,
                                text: Text(
                                  'Datos guardados con exito',
                                  style: TextStyle(
                                    color: hexaColor('#666666'),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomTextInput extends StatelessWidget {
  final String text;
  final int maxLength;
  final bool ifEnable;
  final String iconPath;
  final EdgeInsets margin;
  final String initialValue;
  final TextInputType keyboardType;
  final ValueChanged<String> onChange;
  final List<MaskTextInputFormatter> maskTextInputFormatter;
  final TextEditingController textEditingController;

  _CustomTextInput({
    Key key,
    this.margin,
    this.ifEnable,
    this.initialValue,
    this.keyboardType,
    this.maxLength = 21,
    @required this.text,
    @required this.iconPath,
    @required this.onChange,
    this.textEditingController,
    this.maskTextInputFormatter,
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obligatorio';
          }
          return null;
        },
        controller: this.textEditingController,
        initialValue: this.initialValue,
        enabled: this.ifEnable,
        inputFormatters: this.maskTextInputFormatter,
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
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hexaColor('#303030'),
            ),
            borderRadius: BorderRadius.circular(vw * .1),
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
