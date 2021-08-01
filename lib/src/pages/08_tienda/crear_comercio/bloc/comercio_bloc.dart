import 'dart:async';
import 'dart:io';

import '../../../../data/services/stores/stores_service.dart';
import '../../../../data/shared/store_pref/store_pref.dart';
import '../../../../utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'comercio_event.dart';
part 'comercio_state.dart';

class ComercioBloc extends Bloc<ComercioEvent, ComercioState> {
  ComercioBloc()
      : super(
          ComercioState(
            aceptoTerminos: StoreIfUserTermPref().getUserTerm(),
            markers: Map(),
            ifVisible: false,
          ),
        );

  showMarkerDialog(BuildContext context, MarkerId markerId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Eliminar',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
          ),
          actions: [
            OutlinedButton(
              child: Text(
                'Mejor no',
                style: TextStyle(
                  color: hexaColor('#303030'),
                ),
              ),
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(
                    hexaColor('#303030', opacity: 0.2)),
                side: MaterialStateProperty.all(
                  BorderSide.lerp(
                    BorderSide(
                      style: BorderStyle.solid,
                      color: hexaColor('#303030'),
                      width: 1.0,
                    ),
                    BorderSide(
                      style: BorderStyle.solid,
                      color: hexaColor('#303030'),
                      width: 1.0,
                    ),
                    10.0,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              color: hexaColor('#303030'),
              child: Text(
                'Borrar',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                print('ComercioBloc - id: ${int.tryParse(markerId.value)}');
                add(RemoveOneMarkers(int.tryParse(markerId.value)));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Stream<ComercioState> mapEventToState(
    ComercioEvent event,
  ) async* {
    if (event is AddComercioIcon) {
      //

      yield state.copyWith(icon: event.image);
      //
    } else if (event is AddAceptoTerminos) {
      //

      yield state.copyWith(aceptoTerminos: event.aceptoTerminos);
      //
    } else if (event is AddComercioIfEnableEditar) {
      //

      yield state.copyWith(ifEnable: event.ifEnable);
      //
    } else if (event is AddToggleViewStore) {
      //

      yield state.copyWith(ifView: event.ifView);
      //
    } else if (event is AddPathTipoDeTienda) {
      //

      yield state.copyWith(pathTipoDeTienda: event.pathTipoDeTienda);
      //
    } else if (event is AddNombreTipoDeTienda) {
      //

      yield state.copyWith(nombreTipoDeTienda: event.nombreTipoDeTienda);
      //
    } else if (event is AddMarkers) {
      //

      final markerId = MarkerId(
        this.state.markers.length.toString(),
      );
      final marker = Marker(
        markerId: markerId,
        position: event.marker,
        onTap: () {
          print('ComercioBloc - marker: delete $markerId');
          showMarkerDialog(event.context, markerId);
        },
      );

      final markers = Map<MarkerId, Marker>.from(this.state.markers);

      markers[markerId] = marker;

      // print('ComercioBloc - listOfLatLng: $listOfLatLng');

      print('ComercioBloc - markers: $markers');

      yield state.copyWith(
        markers: markers,
        // listOfLatLng: listOfLatLng,
        context: event.context,
      );
    } else if (event is AddIfVisibility) {
      //

      yield state.copyWith(ifVisible: event.ifVisibility);
      //
    } else if (event is ClearMarkers) {
      //

      this.state.markers.clear();
      final markers = Map<MarkerId, Marker>.from(this.state.markers);

      // markers.clear();

      yield state.copyWith(markers: markers);
    } else if (event is SaveMarkers) {
      //

      final listOfLatLng = state.markers.entries.map((e) {
        return e.value.position;
      }).toList();

      StorePositionPref().setLatLngList(value: listOfLatLng);

      final customGeoLocation = listOfLatLng.map((e) {
        return CustomGeoLocation(lat: e.latitude, lng: e.longitude);
      }).toList();

      print('ComercioBloc - listOfLatLng: ${state.listOfLatLng}');
      StoresService().setLocationInDB(
        geolocationStore: customGeoLocation,
        onProgress: () {
          customShowSnackBar(
            duration: Duration(seconds: 1),
            context: state.context,
            text: Text(
              'Guardando locaciones',
              style: TextStyle(
                color: hexaColor('#303030'),
              ),
            ),
          );
        },
        onSuccess: ({data}) {
          customShowSnackBar(
            context: state.context,
            text: Text(
              'Guardado exitoso',
              style: TextStyle(
                color: hexaColor('#303030'),
              ),
            ),
          );
        },
        onFailed: ({data}) {
          customShowSnackBar(
            context: state.context,
            text: Text(
              'Error al guardar',
              style: TextStyle(
                color: hexaColor('#303030'),
              ),
            ),
          );
        },
      );

      //
    } else if (event is RemoveOneMarkers) {
      //

      print('ComercioBloc before ${state.markers.length}');
      state.markers
          .removeWhere((key, value) => int.tryParse(key.value) == event.index);
      print('ComercioBloc after ${state.markers.length}');
      final newMarker = Map<MarkerId, Marker>.from(state.markers);
      yield state.copyWith(markers: newMarker);
    } else if (event is AddMapOfMarkers) {
      final newMarkers = Map<MarkerId, Marker>.from(event.markers);

      yield state.copyWith(markers: newMarkers, context: event.context);
    }
  }
}
