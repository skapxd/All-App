part of 'home_bloc.dart';

@immutable
class HomeState {
  final int pageIndex;
  final int tapBarViewIndex;

  HomeState({this.pageIndex, this.tapBarViewIndex});

  HomeState copyWith({
    int pageIndex,
    int tapBarViewIndex,
  }) =>
      HomeState(
        pageIndex: pageIndex ?? this.pageIndex,
        tapBarViewIndex: tapBarViewIndex ?? this.tapBarViewIndex,
      );
}
