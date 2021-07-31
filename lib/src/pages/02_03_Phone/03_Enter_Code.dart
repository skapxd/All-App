import 'package:allapp/src/data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:allapp/src/data/shared/user_pref/user_pref.dart';
import 'package:allapp/src/widgets/Popup_Request_Activate_Geolocation.dart';

import '../../data/services/auth/auth_Phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../data/shared/pref.dart';
import '../../utils/utils.dart';
import '../../widgets/BackgroundGradient.dart';
import '../../widgets/CustomText.dart';
import '../../widgets/OutLineButton.dart';
import '../04_home/04_Home.dart';
import 'bloc/phone_bloc.dart';

class EnterCode extends StatelessWidget {
  static final String pathName = '/EnterCode';

  final _pref = Pref();

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    final phoneBloc = BlocProvider.of<PhoneBloc>(context);
    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);

    return _Bg(
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:
                RequesWhatsAppCode(vw: vw, phoneBloc: phoneBloc, pref: _pref),
          ),
          PopupRequestActivateGeolocation()
        ],
      ),
    );
  }
}

class RequesWhatsAppCode extends StatelessWidget {
  const RequesWhatsAppCode({
    Key key,
    @required this.vw,
    @required this.phoneBloc,
    @required Pref pref,
  })  : _pref = pref,
        super(key: key);

  final double vw;
  final PhoneBloc phoneBloc;
  final Pref _pref;

  @override
  Widget build(BuildContext context) {
    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          'INGRESA EL CÓDIGO',
          width: vw * 0.56,
          margin: EdgeInsets.only(top: vw * 0.31),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: hexaColor('#BEA07D'),
            fontWeight: FontWeight.w400,
            letterSpacing: 12,
            height: 1.5,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: vw * 0.85),
          child: _TextField(
            onChange: (value) {
              value = value.replaceAll(' ', '');

              phoneBloc.add(AddMsg(value));

              if (value.length == 6) {
                FocusScope.of(context).unfocus();
              }
            },
          ),
        ),
        CustomOutLineButton(
          text: 'CONTINUAR',
          margin: EdgeInsets.only(top: vw * 0.15),
          onTap: () async {
            //

            final msg = phoneBloc.state.modelPhone.msg;

            final phone =
                '${phoneBloc.state.modelPhone.code}-${phoneBloc.state.modelPhone.phone}';

            if (msg.length == 6) {
              miUbicacionBloc.initPosition(
                onSuccess: (latLng) {
                  AuthPhone().verifyPhoneCode(
                    phone: phone,
                    code: msg,
                    latLng: latLng,
                    onSuccess: (login) {
                      UserPhonePref()
                          .setPhone(phone: phoneBloc.state.modelPhone.phone);

                      UserCountryCodePref().setCountryCode(
                          countryCode: phoneBloc.state.modelPhone.code);
                      // _pref.countryCode = phoneBloc.state.modelPhone.code;
                      UserTokenPref().setToken(token: login.token);
                      print('success: $login');
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Home.pathName,
                        (Route<dynamic> route) => false,
                      );
                    },
                    onError: (error) {
                      print(error);
                    },
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: hexaColor('#303030'),
                  title: Text(
                    'Código invalido',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: hexaColor('#d5d5d5')),
                  ),
                ),
              );
            }
          },
        ),
        CustomText(
          'Ingresa el código que te enviamos por WhatsApp\npara ingresar a los servicios de All App.',
          margin: EdgeInsets.only(
            top: vw * 0.1,
            left: vw * 0.05,
            right: vw * 0.05,
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: hexaColor('#8C8C8C'),
            fontSize: vw * 0.035,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  final ValueChanged<String> onChange;

  _TextField({
    this.onChange,
  });

  final maskFormatter = new MaskTextInputFormatter(
    mask: '### ###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return Container(
      width: vw * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(vw * 0.1),
      ),
      child: TextField(
        onChanged: this.onChange,
        keyboardType: TextInputType.phone,
        inputFormatters: [maskFormatter],
        textAlign: TextAlign.start,
        scrollPadding: EdgeInsets.symmetric(horizontal: vw * 0.066),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: '--- ---',
          hintStyle: TextStyle(
            color: hexaColor('#E6D29F'),
            letterSpacing: 7,
            fontSize: vw * 0.05,
            fontWeight: FontWeight.w800,
          ),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(vw * 0.035),
            borderSide: BorderSide(
              color: hexaColor('#E6D29F'),
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(vw * 0.035),
            borderSide: BorderSide(
              color: hexaColor('#E6D29F'),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(vw * 0.035),
            borderSide: BorderSide(
              color: hexaColor('#E6D29F'),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: vw * 0.1),
          // contentPadding: EdgeInsets.only(left: vw * 0.066),
        ),
        style: TextStyle(
          color: hexaColor('#A3A3A3'),
          // fontSize: vw * 0.045,
          height: 1,
          letterSpacing: 6,
          fontSize: vw * 0.05,
        ),
      ),
    );
  }
}

class _Bg extends StatelessWidget {
  final Widget child;

  _Bg({this.child});

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomBackgroundGradient(
        child: Stack(
          children: [
            Positioned(
              top: vw * 0.2,
              child: SvgPicture.asset(
                'assets/brand/A-bg.svg',
                height: vw * 0.988,
                width: vw * 0.884,
              ),
            ),
            Container(
              width: vw,
              child: this.child,
            )
          ],
        ),
      ),
    );
  }
}
