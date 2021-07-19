import 'crear_comercio/grupo_productos/grupo_productos.dart';
import '../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'crear_comercio/06_crear_comercio.dart';
import 'crear_comercio/add-photos-page/Photos_Page.dart';

class TiendaPage extends StatelessWidget {
  static final String pathName = '/TiendaPage';

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: hexaColor('#303030'),
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        backgroundColor: hexaColor('#353535'),
        title: Text(
          'TIENDA',
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.5,
            fontSize: 15,
            color: hexaColor('#E6D29F'),
            letterSpacing: 5,
          ),
        ),
        leading: InkWell(
          borderRadius: BorderRadius.circular(vw),
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset(
              'assets/icons/back-arrow.svg',
            ),
          ),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ListTile(
            title: Text(
              'Perfil',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => Navigator.pushNamed(context, ComercioPage.pathName),
          ),
          ListTile(
            title: Text(
              'Productos',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => Navigator.pushNamed(
              context,
              GrupoProductosPage.pathName,
            ),
          ),
          ListTile(
            title: Text(
              'Fotos',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => Navigator.pushNamed(context, PhotosPage.pathName),
          ),
          ListTile(
            title: Text(
              'Domiciliarios',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            title: Text(
              'Historial de pedidos',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            title: Text(
              'Historial de clientes',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            title: Text(
              'Certificado de camara y comercio',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
