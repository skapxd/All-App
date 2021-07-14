import 'dart:async';
import 'dart:io';

import '../../../../data/shared/pref.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'comercio_event.dart';
part 'comercio_state.dart';

class ComercioBloc extends Bloc<ComercioEvent, ComercioState> {
  ComercioBloc()
      : super(ComercioState(
          aceptoTerminos: Pref().ifVerInfoDeTienda,
        ));

  @override
  Stream<ComercioState> mapEventToState(
    ComercioEvent event,
  ) async* {
    if (event is AddComercioIcon) {
      //

      yield ComercioState(icon: event.image);
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
    }
  }
}
