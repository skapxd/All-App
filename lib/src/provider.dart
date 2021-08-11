import 'pages/08_store/create_category_product/bloc/create_category_product_bloc.dart';
import 'pages/08_store/create_category_product/crear_producto_page/bloc/crear_producto_page_bloc.dart';
import 'pages/08_store/create_store/bloc/comercio_bloc.dart';

import 'pages/02_03_Phone/bloc/phone_bloc.dart';
import 'pages/04_home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/bloc/mapa/mapa_bloc.dart';
import 'data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'widgets/Menu/bloc/menu_bloc.dart';

class MainProvider extends StatelessWidget {
  const MainProvider({@required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => new PhoneBloc()),
        BlocProvider(create: (_) => new MenuBloc()),
        BlocProvider(create: (_) => new ComercioBloc()),
        BlocProvider(create: (_) => new MiUbicacionBloc()),
        BlocProvider(create: (_) => new MapaBloc()),
        BlocProvider(create: (_) => new HomeBloc()),
        BlocProvider(create: (_) => new CrearProductoBloc()),
        BlocProvider(create: (_) => new CreateCategoryProductBloc()),
      ],
      child: this.child,
    );
  }
}
