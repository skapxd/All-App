import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'comercio_event.dart';
part 'comercio_state.dart';

class ComercioBloc extends Bloc<ComercioEvent, ComercioState> {
  ComercioBloc() : super(ComercioInitial());

  @override
  Stream<ComercioState> mapEventToState(
    ComercioEvent event,
  ) async* {
    if (event is AddComercioIcon) {
      yield ComercioIcon(icon: event.image);
    } else if (event is AddComercioIfEnableEditar) {
      yield ComercioIfEditar(ifEnable: event.ifEnable);
    }
  }
}
