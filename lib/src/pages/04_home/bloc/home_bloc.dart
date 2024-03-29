import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(pageIndex: 0));

  PageController page = PageController();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is AddPageIndex) {
      yield state.copyWith(pageIndex: event.pageIndex);
    } else if (event is AddTapBarViewIndex) {
      page.jumpToPage(event.tapBarViewIndex);
      yield state.copyWith(tapBarViewIndex: event.tapBarViewIndex);
    }
  }
}
