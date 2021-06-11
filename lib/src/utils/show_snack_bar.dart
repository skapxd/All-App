part of 'utils.dart';

//
void showSnackBar({
  Text text,
  Color backGround,
  BuildContext context,
  Color systemNavigationBarColor,
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
