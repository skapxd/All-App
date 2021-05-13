import 'package:allapp/src/data/shared/pref.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuState(nombre: Pref().nombe));

  @override
  Stream<MenuState> mapEventToState(
    MenuEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is AddMenuName) {
      yield MenuState(nombre: event.name);
    }
  }
}
