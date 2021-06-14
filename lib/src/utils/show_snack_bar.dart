part of 'utils.dart';

//
void customShowSnackBar({
  Text text,
  Color backGround,
  Color systemNavigationBarColor,
  @required BuildContext context,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backGround ?? hexaColor('#d5d5d5'),
      content: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Color(0x00000000),
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor:
              systemNavigationBarColor ?? hexaColor('#d5d5d5'),
        ),
        sized: false,
        child: text,
      ),
    ),
  );
}
