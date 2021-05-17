part of 'home_bloc.dart';

@immutable
class HomeState {
  final int pageIndex;

  HomeState({
    this.pageIndex,
  });

  HomeState copyWith({
    int pageIndex,
  }) =>
      HomeState(
        pageIndex: pageIndex ?? this.pageIndex,
      );
}
