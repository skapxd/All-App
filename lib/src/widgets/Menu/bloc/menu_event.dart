part of 'menu_bloc.dart';

@immutable
abstract class MenuEvent {}

class AddMenuName extends MenuEvent {
  final String name;

  AddMenuName(this.name);
}
