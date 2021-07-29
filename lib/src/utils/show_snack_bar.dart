part of 'utils.dart';

//
void customShowSnackBar({
  Text text,
  Color backGround,
  Color systemNavigationBarColor,
  Duration duration,
  @required BuildContext context,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: duration ?? Duration(seconds: 3),
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
