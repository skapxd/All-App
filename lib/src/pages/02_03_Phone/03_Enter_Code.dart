import '../../data/shared/store_pref/store_pref.dart';
import '../../models/user_login_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../data/shared/user_pref/user_pref.dart';
import '../../widgets/Popup_Request_Activate_Geolocation.dart';

import '../../data/services/auth/auth_phone_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../utils/utils.dart';
import '../../widgets/BackgroundGradient.dart';
import '../../widgets/CustomText.dart';
import '../../widgets/OutLineButton.dart';
import '../04_home/04_Home.dart';
import 'bloc/phone_bloc.dart';

class EnterCode extends StatelessWidget {
  static final String pathName = '/EnterCode';

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;

    final phoneBloc = BlocProvider.of<PhoneBloc>(context);

    return _Bg(
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: RequesWhatsAppCode(vw: vw, phoneBloc: phoneBloc),
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
  });

  final double vw;
  final PhoneBloc phoneBloc;

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
                  AuthPhoneService().verifyPhoneCode(
                    phone: phone,
                    code: msg,
                    latLng: latLng,
                    onSuccess: (login) {
                      this.setPreferences(context, login);
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

  void setPreferences(BuildContext context, LoginModel login) {
    //

    try {
      UserPhonePref().setPhone(phone: phoneBloc.state.modelPhone.phone);
      UserCountryCodePref()
          .setCountryCode(countryCode: phoneBloc.state.modelPhone.code);
      UserTokenPref().setToken(token: login.token);
      UserNamePref().setName(name: login.userLogin?.name);

      //

      StoreIfVisiblePref()
          .setIfVisible(value: login.storeLogin?.visibilityStore);
      StoreLogoPref().setUrlLogo(value: login.storeLogin?.urlImageStore);
      StoreNamePref().setName(value: login.storeLogin?.nameStore);
      StoreCategoryPref()
          .setCategory(category: login.storeLogin?.categoryStore);
      StoreIconCategoryPref()
          .setIconCategory(value: login.storeLogin?.iconPathCategoryStore);

      StorePhonePref()
          .setPhone(value: login.storeLogin?.contactStore?.phoneCall);
      StoreWhatsAppPref()
          .setWhatsApp(value: login.storeLogin?.contactStore?.whatsApp);
      StoreTelegramPref()
          .setTelegram(value: login.storeLogin?.contactStore?.telegram);

      StoreDescriptionPref()
          .setDescription(value: login.storeLogin?.descriptionStore);

      List latLngList;
      if (login.storeLogin?.addressStore != null) {
        latLngList = login.storeLogin.addressStore.map((e) {
          final temp = LatLng(e.latLngStore.lat, e.latLngStore.lng);
          return temp;
        }).toList();
      }

      StorePositionPref().setLatLngList(value: latLngList);
    } catch (e) {
      print('EnterCode Error $e');
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      Home.pathName,
      (Route<dynamic> route) => false,
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
