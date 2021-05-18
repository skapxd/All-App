import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../data/auth/auth_Phone.dart';
import '../../data/shared/pref.dart';
import '../../utils/utils.dart';
import '../../widgets/BackgroundGradient.dart';
import '../../widgets/CustomText.dart';
import '../../widgets/OutLineButton.dart';
import '../04_home/04_Home.dart';
import '03_Enter_Code.dart';
import 'bloc/phone_bloc.dart';

class EnterPhone extends StatelessWidget {
  static final String pathName = '/EnterPhone';

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    String country = '+57';

    String phone = '';

    return _Bg(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              'INGRESA TU NÚMERO',
              width: vw * 0.56,
              margin: EdgeInsets.only(top: vw * 0.31),
              style: TextStyle(
                color: hexaColor('#BEA07D'),
                fontWeight: FontWeight.w400,
                letterSpacing: 12,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.only(top: vw * 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CountryCodePicker(
                    backgroundColor: hexaColor('#000000', opacity: 0),
                    barrierColor: hexaColor('#000000', opacity: 0.4),
                    onChanged: (value) => country = value.dialCode,
                    // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                    initialSelection: 'CO',
                    favorite: ['+57', 'CO'],
                    // optional. Shows only country name and flag
                    showCountryOnly: false,
                    // optional. Shows only country name and flag when popup is closed.
                    showOnlyCountryWhenClosed: false,
                    // optional. aligns the flag and the Text left
                    alignLeft: false,
                    textStyle: TextStyle(
                      color: hexaColor('#E5E5E5'),
                    ),
                  ),
                  _TextField(
                    onChange: (value) {
                      phone = value.replaceAll(' ', '');

                      BlocProvider.of<PhoneBloc>(context)
                          .add(AddPhone(country + phone));

                      int length = phone.length;

                      if (length == 10) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<PhoneBloc, PhoneState>(
              builder: (context, state) {
                return CustomOutLineButton(
                  text: 'CONTINUAR',
                  margin: EdgeInsets.only(top: vw * 0.1),
                  onTap: () async {
                    if (state.modelPhone.phone.length == 13) {
                      Navigator.pushNamed(context, EnterCode.pathName);

                      AuthPhone().sendMsg(
                        phone: state.modelPhone.phone,
                        onGetToken: (value) {
                          BlocProvider.of<PhoneBloc>(context)
                              .add(AddToken(value));
                        },
                        onSuccess: (value) {
                          BlocProvider.of<PhoneBloc>(context)
                              .add(AddToken(value));

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Home.pathName,
                            (Route<dynamic> route) => false,
                          );

                          Pref().phone = state.modelPhone.phone;
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Número invalido'),
                        ),
                      );
                    }
                  },
                );
              },
            ),
            CustomText(
              'AllApp te enviará un SMS para verificar\n tu número de teléfono. El código\n puede tardar algunos minutos en aparecer.',
              margin: EdgeInsets.only(top: vw * 0.1),
              // width: vw * 0.83,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: hexaColor('#8C8C8C'),
                fontSize: vw * 0.035,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final ValueChanged<String> onChange;

  _TextField({
    this.onChange,
  });

  final maskFormatter = new MaskTextInputFormatter(
      mask: '### ### ## ##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return Container(
      width: vw * 0.47,
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
          hintText: '000 000 0000 ',
          hintStyle: TextStyle(
            color: hexaColor('#60605F'),
            fontSize: vw * 0.045,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(vw * 0.035),
            gapPadding: 0,
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
              color: hexaColor('#404040'),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(vw * 0.035),
            gapPadding: 0,
            borderSide: BorderSide(
              style: BorderStyle.none,
              width: 0,
              color: hexaColor('#404040'),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(vw * 0.035),
            gapPadding: 0,
            borderSide: BorderSide(
              style: BorderStyle.none,
              width: 0,
              color: hexaColor('#404040'),
            ),
          ),
          fillColor: hexaColor('#404040'),
          filled: true,
          contentPadding: EdgeInsets.only(left: vw * 0.066),
        ),
        style: TextStyle(
          color: hexaColor('#A3A3A3'),
          fontSize: vw * 0.045,
          height: 1,
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
