import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../data/auth/auth_Phone.dart';
import '../../data/db/firestore.dart';
import '../../data/shared/pref.dart';
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
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    String msg = '';

    return _Bg(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              'INGRESA EL CÓDIGO',
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
              child: _TextField(
                onChange: (value) {
                  msg = value.replaceAll(' ', '');

                  BlocProvider.of<PhoneBloc>(context).add(AddMsg(msg));

                  int length = msg.length;

                  if (length == 6) {
                    FocusScope.of(context).unfocus();
                  }
                },
              ),
            ),
            BlocBuilder<PhoneBloc, PhoneState>(
              builder: (context, state) {
                return CustomOutLineButton(
                  text: 'CONTINUAR',
                  margin: EdgeInsets.only(top: vw * 0.15),
                  onTap: () async {
                    //

                    if (state.modelPhone.msg.length == 6) {
                      await AuthPhone().enterMsg(
                        smsCode: state.modelPhone.msg,
                        token: state.modelPhone.token,
                        onSuccess: () {
                          //

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Home.pathName,
                            (Route<dynamic> route) => false,
                          );
                          Pref().phone = state.modelPhone.phone;
                          DBFirestore().addUser(
                            phone: state.modelPhone.phone,
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
                );
              },
            ),
            CustomText(
              'Ingresa el código que te enviamos por SMS\npara ingresar a los servicios de All App.',
              margin: EdgeInsets.only(top: vw * 0.15),
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
