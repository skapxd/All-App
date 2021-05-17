import 'package:flutter/material.dart';
import 'package:allapp/src/data/bloc/mapa/mapa_bloc.dart';
import 'package:allapp/src/data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustonFloatingActionButton extends StatelessWidget {
  final VoidCallback onTap;
  CustonFloatingActionButton({this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            Icons.my_location,
            color: Colors.black87,
          ),
          onPressed: () {
            onTap();
          },
        ),
      ),
    );
  }
}
