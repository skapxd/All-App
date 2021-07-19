import '../../pages/08_tienda/crear_comercio/06_crear_comercio.dart';
import '../../pages/08_tienda/tienda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../data/shared/pref.dart';
import '../../pages/05_favoritos/05_favoritos.dart';
import '../../utils/utils.dart';
import 'bloc/menu_bloc.dart';

class MenuButton extends StatelessWidget {
  final String nombre = Pref().nombe;

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        showMaterialModalBottomSheet(
          context: context,
          backgroundColor: rgbColor(0, 0, 0, 0),
          builder: (context) => _MenuList(),
        );
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: hexaColor('#E6E6E6'),
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        child: Text(
          Pref().nombe[0],
          style: TextStyle(
            color: hexaColor('#383838'),
          ),
        ),
      ),
    );
  }
}

class _MenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String phone = Pref().phone;

    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: vw * 0.07),
          width: vw * 0.9,
          height: vh * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(vw * .05),
            color: hexaColor('#303030'),
          ),
          child: Column(
            children: [
              SizedBox(
                height: vw * 0.2,
              ),
              _MenuListProfile(),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                color: hexaColor('#A3A3A3'),
              ),
              _MenuListItem(
                width: 30,
                height: 20,
                pathIcon: 'assets/icons/heart.svg',
                text: 'Favoritos',
                onTap: () =>
                    Navigator.pushNamed(context, FavoritosPage.pathName),
              ),
              _MenuListItem(
                width: 40,
                height: 30,
                pathIcon: 'assets/icons/order.svg',
                text: 'Pedidos',
                onTap: () => print('pedidos'),
              ),
              _MenuListItem(
                pathIcon: 'assets/icons/settings.svg',
                height: 25,
                text: 'Ajustes',
                onTap: () => print('Configuracion'),
              ),
              _MenuListItem(
                height: 30,
                pathIcon: 'assets/icons/settings-shop-2.svg',
                text: 'Mi tienda',
                onTap: () => Navigator.pushNamed(context, TiendaPage.pathName),
                // Navigator.pushNamed(context, ComercioPage.pathName),
              ),
              _MenuListItem(
                height: 25,
                pathIcon: 'assets/icons/calendar.svg',
                text: 'Eventos',
                onTap: () => print('problema'),
              ),
              // TODO: Crear pagina de administar otras tiendas
              _MenuListItem(
                height: 30,
                pathIcon: 'assets/icons/settings-shop-2.svg',
                text: 'Administrar otras tiendas',
                onTap: () => Navigator.pushNamed(context, TiendaPage.pathName),
                // Navigator.pushNamed(context, ComercioPage.pathName),
              ),
              _MenuListItem(
                height: 25,
                pathIcon: 'assets/icons/report-issue.svg',
                text: 'Reportar un problema',
                onTap: () => print('problema'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MenuListItem extends StatelessWidget {
  final String pathIcon;
  final String text;
  final VoidCallback onTap;
  final double height;
  final double width;

  _MenuListItem({
    @required this.pathIcon,
    @required this.text,
    @required this.onTap,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: this.onTap,
      child: Container(
        // color: Colors.red,
        height: vw * 0.1,
        margin: EdgeInsets.only(bottom: vw * 0.03),
        child: Row(
          children: [
            Container(
              width: 35,
              // color: Colors.green,
              margin: EdgeInsets.only(right: vw * 0.05),
              child: SvgPicture.asset(
                this.pathIcon,
                fit: BoxFit.contain,
                height: this.height ?? vw * 0.05,
                width: this.width ?? vw * 0.05,
                color: hexaColor('#DDDDDD'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                this.text,
                style: TextStyle(color: hexaColor('#DDDDDD')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuListProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String phone = Pref().phone;

    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return Row(
      children: [
        Container(
          height: vw * 0.17,
          width: vw * 0.17,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(vw),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: vw * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<MenuBloc, MenuState>(
                builder: (context, state) {
                  return Container(
                    child: Text(
                      state.nombre,
                      // this.nombre,
                      style: TextStyle(
                        color: hexaColor('#A3A3A3'),
                      ),
                    ),
                  );
                },
              ),
              Container(
                child: Text(
                  phone,
                  style: TextStyle(
                    color: hexaColor('#A3A3A3'),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: Container()),
        IconButton(
          icon: Icon(
            Icons.edit,
            color: hexaColor('#E6D29F'),
          ),
          onPressed: () {
            // showMaterialModalBottomSheet(
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              backgroundColor: rgbColor(0, 0, 0, 0),
              builder: (BuildContext context) {
                return Container(
                  height: vh * 0.2,
                  padding: EdgeInsets.only(
                    top: vw * 0.07,
                    left: vw * 0.07,
                    right: vw * 0.07,
                  ),
                  decoration: BoxDecoration(
                    color: hexaColor('#333333'),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(vw * 0.05),
                      topRight: Radius.circular(vw * 0.05),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'Escribe tu nombre',
                          style: TextStyle(
                            color: hexaColor('#FFFFFF'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: vw * 0.01,
                      ),
                      TextField(
                        controller: TextEditingController(
                          text: Pref().nombe,
                        ),
                        onChanged: (value) {
                          BlocProvider.of<MenuBloc>(context)
                              .add(AddMenuName(value));
                          Pref().nombe = value;
                        },
                        style: TextStyle(color: Colors.white),
                        maxLength: 18,
                        autofocus: true,
                        decoration: InputDecoration(
                          counterStyle: TextStyle(
                            color: hexaColor('#CCCCCC'),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: hexaColor('#E6D29F'),
                            ),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: hexaColor('#E6D29F'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        )
      ],
    );
  }
}
