import 'dart:ui';

Color hexaColor(String color, {double opacity = 1.0}) {
  int colorS = int.tryParse(
    '0xff$color'.replaceAll('#', ''),
  );

  return Color(colorS).withOpacity(opacity);
}

Color rgbColor(int r, int g, int b, double o) {
  return Color.fromRGBO(r, g, b, o);
}
