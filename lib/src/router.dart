import 'package:allapp/src/proximamente/analiticas.dart';
import 'package:allapp/src/proximamente/historial_de_clientes.dart';
import 'package:allapp/src/proximamente/historial_de_ventas.dart';

import 'pages/01_wellcome/01_permisos.dart';
import 'pages/01_wellcome/01_wellcome.dart';
import 'pages/02_03_Phone/03_Enter_Code.dart';
import 'pages/04_home/04_Home.dart';
import 'pages/05_favoritos/05_favoritos.dart';
import 'pages/07_ver_comercios/ver_mapa_page/ver_mapa_page.dart';
import 'pages/07_ver_comercios/ver_page_image_comercio/ver_page_image_comercio.dart';
import 'pages/08_tienda/crear_comercio/06_crear_comercio.dart';
import 'pages/08_tienda/crear_comercio/add-photos-page/Image_Page.dart';
import 'pages/08_tienda/crear_comercio/crear-producto-page/crear_producto_page.dart';
import 'pages/08_tienda/tienda.dart';
import 'widgets/PageImage.dart';
import 'widgets/SliverPage.dart';
import 'widgets/page_image.dart';
import 'package:flutter/material.dart';

import 'pages/02_03_Phone/02_Enter_Phone.dart';
import 'pages/07_ver_comercios/ver_comercio.dart';
import 'pages/07_ver_comercios/ver_galeria_fotos/ver_galeria_fotos.dart';
import 'pages/08_tienda/crear_comercio/add-photos-page/Photos_Page.dart';
import 'pages/08_tienda/crear_comercio/grupo_productos/grupo_productos.dart';
import 'pages/08_tienda/crear_comercio/mapa_page/mapa_page.dart';

Map<String, Widget Function(BuildContext)> router = {
  WelcomePage.pathName: (_) => WelcomePage(),
  PermisosPage.pathName: (_) => PermisosPage(),
  EnterPhone.pathName: (_) => EnterPhone(),
  EnterCode.pathName: (_) => EnterCode(),
  Home.pathName: (_) => Home(),
  SliverPage.pathName: (_) => SliverPage(),
  PageImage.pathName: (_) => PageImage(),
  PageImageComercio.pathName: (_) => PageImageComercio(),
  FavoritosPage.pathName: (_) => FavoritosPage(),
  ComercioPage.pathName: (_) => ComercioPage(),
  GrupoProductosPage.pathName: (_) => GrupoProductosPage(),
  PhotosPage.pathName: (_) => PhotosPage(),
  AddPageImage.pathName: (_) => AddPageImage(),
  ComercioMapaPage.pathName: (_) => ComercioMapaPage(),
  CrearProductoPage.pathName: (_) => CrearProductoPage(),
  VerComercios.pathName: (_) => VerComercios(),
  VerPageImageComercio.pathName: (_) => VerPageImageComercio(),
  VerGaleriaFotos.pathName: (_) => VerGaleriaFotos(),
  VerMapaPage.pathName: (_) => VerMapaPage(),
  TiendaPage.pathName: (_) => TiendaPage(),

  // Proximamente
  HistorialDeVentasPage.pathName: (_) => HistorialDeVentasPage(),
  HistorialDeClientesPage.pathName: (_) => HistorialDeClientesPage(),
  AnaliticasPage.pathName: (_) => AnaliticasPage(),
};
