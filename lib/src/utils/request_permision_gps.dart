part of 'utils.dart';

void accesoGps({
  VoidCallback onGranted,
}) async {
  final status = await Permission.location.request();

  switch (status) {
    case PermissionStatus.granted:
      if (onGranted != null) {
        onGranted();
      }
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
