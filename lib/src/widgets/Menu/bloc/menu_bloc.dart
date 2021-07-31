import 'package:allapp/src/data/shared/user_pref/user_pref.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuState(nombre: UserNamePref().getName()));

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
