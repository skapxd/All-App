import 'package:allapp/src/data/services/utils/utils_service.dart';

import '../../../data/shared/store_pref/store_pref.dart';
import 'store_description/store_description.dart';

import '../../../data/services/stores/stores_service.dart';

import '../../../utils/utils.dart';
import '../../../widgets/OutLineButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'bloc/comercio_bloc.dart';
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

  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();

    Future.delayed(
        Duration.zero,
        () => !StoreIfUserTermPref().getUserTerm()
            ? showCustomDialog(context)
            : null);
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
                initialIfEnable: StoreIfUserTermPref().getUserTerm(),
                text: 'Aceptar términos',
                onChanged: (value) {
                  print('ComercioPage - Swich of termns $value');
                  StoreIfUserTermPref().setUserTerm(value: value);
                  final bloc = BlocProvider.of<ComercioBloc>(context);
                  bloc.add(AddAceptoTerminos(value));
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

    final comercioBloc = BlocProvider.of<ComercioBloc>(context);
    // final miUbicacion = BlocProvider.of<MiUbicacionBloc>(context);

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
                    TextEditingController(text: StorePhonePref().getPhone());

                final _controllerWhatsAppTienda = TextEditingController(
                    text: StoreWhatsAppPref().getWhatsApp());

                if (!state.aceptoTerminos) {
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
                        ifEnable: StoreIfFormEditPref().getIfFormEdit(),
                        initialImage: StoreLogoPref().getUrlLogo(),
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
                        initialIfEnable: StoreIfFormEditPref().getIfFormEdit(),
                        onChanged: (value) {
                          StoreIfFormEditPref().setIfFormEdit(value: value);
                          comercioBloc.add(AddComercioIfEnableEditar(value));
                        },
                      ),
                      IfSwichFormularioComercio(
                        text: 'Visibilidad de la tienda',
                        initialIfEnable: StoreIfVisiblePref().getIfVisible(),
                        onChanged: (value) {
                          comercioBloc.add(AddIfVisibility(value));
                          StoreIfVisiblePref().setIfVisible(value: value);
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
                                initialValue: StoreNamePref().getName(),
                                maskTextInputFormatter: null,
                                ifEnable: StoreIfFormEditPref().getIfFormEdit(),
                                text: 'Nombre de tienda',
                                margin: EdgeInsets.only(bottom: vw * 0.03),
                                onChange: (value) {
                                  StoreNamePref().setName(value: value);
                                  print('ComercioPage $value');
                                },
                              ),
                              CustomButton(
                                // ifData: false,
                                // iconPath: 'assets/icons/settings-shop-2.svg',
                                ifData:
                                    StoreIconCategoryPref().getIconCategory() !=
                                                '' ||
                                            state.pathTipoDeTienda != null
                                        ? true
                                        : false,

                                iconPath: StoreIconCategoryPref()
                                                .getIconCategory() !=
                                            '' &&
                                        state.pathTipoDeTienda != null
                                    ? StoreIconCategoryPref().getIconCategory()
                                    : 'assets/icons/settings-shop-2.svg',

                                text:
                                    StoreCategoryPref().getCategory() != null &&
                                            state.nombreTipoDeTienda != null
                                        ? StoreCategoryPref().getCategory()
                                        : 'Tipo de tienda',
                                // text: 'Tipo de tienda',
                                ifEnable: StoreIfFormEditPref().getIfFormEdit(),
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
                                ifEnable: StoreIfFormEditPref().getIfFormEdit(),
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
                                  StorePhonePref().setPhone(value: value);

                                  if (value.length == 13) {
                                    FocusScope.of(context).unfocus();
                                  }
                                },
                              ),
                              _CustomTextInput(
                                ifEnable: StoreIfFormEditPref().getIfFormEdit(),
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
                                  StoreWhatsAppPref().setWhatsApp(value: value);

                                  if (value.length == 13) {
                                    FocusScope.of(context).unfocus();
                                  }
                                },
                              ),
                              _CustomTextInput(
                                ifEnable: StoreIfFormEditPref().getIfFormEdit(),
                                initialValue: StoreTelegramPref().getTelegram(),
                                maxLength: null,
                                iconPath: 'assets/icons/telegram.svg',
                                text: 'Telegram ej: @Nombre',
                                margin: EdgeInsets.only(bottom: vw * 0.08),
                                onChange: (value) {
                                  StoreTelegramPref().setTelegram(
                                      value: value.replaceAll('@', ''));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomButton(
                        ifData: StoreIfFormEditPref().getIfFormEdit() != null
                            ? true
                            : false,
                        text: 'Descripción',
                        iconPath: 'assets/icons/lat-lan.svg',
                        ifEnable: StoreIfFormEditPref().getIfFormEdit(),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            DescriptionPage.pathName,
                          );
                        },
                      ),
                      CustomButton(
                        ifData: StoreIfFormEditPref().getIfFormEdit() != null
                            ? true
                            : false,
                        text: 'Ubicación',
                        iconPath: 'assets/icons/lat-lan.svg',
                        ifEnable: StoreIfFormEditPref().getIfFormEdit(),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ComercioMapaPage.pathName,
                            arguments: {
                              'latLng': StorePositionPref().getLatLngList()
                              // 'latLng': StorePositionPref().getLatLngList()
                            },
                            // arguments: {'latLng': List<LatLng>()},
                          );
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
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            final comercioBloc =
                                BlocProvider.of<ComercioBloc>(context);

                            final file = comercioBloc.state.icon?.path;

                            if (file != null) {
                              await UploadImageService().uploadLogo(
                                file: file,
                                onFailed: (error) {
                                  print('storesService.uploadLogo $error');
                                },
                                onSuccess: (String urlLogo) {
                                  print('storesService.uploadLogo $urlLogo');

                                  StoreLogoPref().setUrlLogo(value: urlLogo);
                                },
                              );
                            }

                            CreateStoreService(
                              urlImage: StoreLogoPref().getUrlLogo(),
                              iconPathCategory:
                                  StoreIconCategoryPref().getIconCategory(),
                              description:
                                  StoreDescriptionPref().getDescription(),
                              name: StoreNamePref().getName(),
                              category: StoreCategoryPref().getCategory(),
                              visibility: StoreIfVisiblePref().getIfVisible(),
                              contactStore: ContactStore(
                                phonCall: StorePhonePref().getPhone(),
                                telegram: StoreTelegramPref().getTelegram(),
                                whatsApp: StoreWhatsAppPref().getWhatsApp(),
                              ),
                              onProgress: () {
                                customShowSnackBar(
                                  duration: Duration(seconds: 1),
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

                            // storesService.createStore(
                            //   nameStore: StoreNamePref().getName(),
                            //   categoryStore: StoreCategoryPref().getCategory(),
                            //   visibility: StoreIfVisiblePref().getIfVisible(),
                            //   contactStore: ContactStore(
                            //     phonCall: StorePhonePref().getPhone(),
                            //     telegram: StoreTelegramPref().getTelegram(),
                            //     whatsApp: StoreWhatsAppPref().getWhatsApp(),
                            //   ),
                            //   onProgress: () {
                            //     customShowSnackBar(
                            //       duration: Duration(seconds: 1),
                            //       context: context,
                            //       text: Text(
                            //         'Guardando datos',
                            //         style: TextStyle(
                            //           color: hexaColor('#666666'),
                            //         ),
                            //       ),
                            //     );
                            //   },
                            //   onFailed: ({data}) {
                            //     customShowSnackBar(
                            //       context: context,
                            //       text: Text(
                            //         'Error al guardar datos',
                            //         style: TextStyle(
                            //           color: hexaColor('#666666'),
                            //         ),
                            //       ),
                            //     );
                            //   },
                            //   onSuccess: ({data}) {
                            //     customShowSnackBar(
                            //       context: context,
                            //       text: Text(
                            //         'Datos guardados con exito',
                            //         style: TextStyle(
                            //           color: hexaColor('#666666'),
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // );
                          }
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
