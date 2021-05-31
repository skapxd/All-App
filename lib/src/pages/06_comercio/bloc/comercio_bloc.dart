import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/shared/pref.dart';

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
      yield ComercioState(icon: event.image);
    } else if (event is AddAceptoTerminos) {
      yield state.copyWith(aceptoTerminos: event.aceptoTerminos);
    } else if (event is AddComercioIfEnableEditar) {
      print('terminos =====> ${event.ifEnable}');

      yield state.copyWith(ifEnable: event.ifEnable);
    } else if (event is AddToggleViewStore) {
      yield state.copyWith(ifView: event.ifView);
    }
  }
}
