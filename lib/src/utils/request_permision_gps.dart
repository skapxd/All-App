part of 'utils.dart';

void accesoGps({
  VoidCallback onGranted,
  PageController pageController,
}) async {
  final status = await Permission.location.request();

  switch (status) {
    case PermissionStatus.granted:
      onGranted();
      // Navigator.pushReplacementNamed(context, MapaPage.pathName);
      break;

    case PermissionStatus.denied:
    case PermissionStatus.restricted:
    case PermissionStatus.limited:
    case PermissionStatus.permanentlyDenied:
      openAppSettings();
      break;
  }
}
