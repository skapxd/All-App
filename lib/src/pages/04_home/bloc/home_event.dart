part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class AddPageIndex extends HomeEvent {
  final int pageIndex;

  AddPageIndex(this.pageIndex);
}
