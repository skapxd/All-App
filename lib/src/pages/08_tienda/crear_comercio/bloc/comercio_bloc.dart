import 'dart:async';
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../data/shared/pref.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'comercio_event.dart';
part 'comercio_state.dart';

class ComercioBloc extends Bloc<ComercioEvent, ComercioState> {
  ComercioBloc()
      : super(
          ComercioState(
            aceptoTerminos: Pref().ifVerInfoDeTienda,
            markers: Map(),
          ),
        );

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

      final marker = Marker(markerId: markerId, position: event.marker);

      final markers = Map<MarkerId, Marker>.from(this.state.markers);

      markers[markerId] = marker;

      print('MiUbicacionBloc - markers: ${markers}');

      yield state.copyWith(markers: markers);
    }
  }
}
