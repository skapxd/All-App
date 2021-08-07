import 'dart:async';
import 'dart:ui';

import 'package:allapp/src/data/shared/produc_store_pref/product_store_pref.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_category_product_event.dart';
part 'create_category_product_state.dart';

class CreateCategoryProductBloc
    extends Bloc<CreateCategoryProductEvent, CreateCategoryProductState> {
  CreateCategoryProductBloc()
      : super(CreateCategoryProductState(
          listCategory: ListCategoryProductStorePref().get(),
        ));

  final listCategory = ListCategoryProductStorePref();

  @override
  Stream<CreateCategoryProductState> mapEventToState(
    CreateCategoryProductEvent event,
  ) async* {
    if (event is AddCategory) {
      //
      listCategory.add(value: event.category);

      final listCategoryTemp = listCategory.get();

      yield state.copyWith(listCategory: listCategoryTemp);
    } else if (event is ToggleColor) {
      //

      if (state.itemsSelected > 0) {
        yield state.copyWith(toggleColor: true);
      } else {
        yield state.copyWith(toggleColor: false);
      }
    } else if (event is AddItemSelected) {
      //

      final itemsSelected = state.itemsSelected + 1;
      add(ToggleColor());
      yield state.copyWith(itemsSelected: itemsSelected);
    } else if (event is ClearItemSelected) {
      //

      yield state.copyWith(itemsSelected: 0);
      print('CreateCategoryProductBloc ${state.itemsSelected}');
      add(ToggleColor());
    } else if (event is DeleteAllCategories) {
      //

      listCategory.delete();

      yield state.copyWith(listCategory: listCategory.get());
    }
  }
}
