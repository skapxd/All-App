import 'dart:async';

import 'package:allapp/src/data/services/stores/stores_service.dart';

import '../../../../data/shared/produc_store_pref/product_store_pref.dart';
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
      SendListProductsCategoryService()
          .send(productsCategories: listCategoryTemp);

      yield state.copyWith(listCategory: listCategoryTemp);
    } else if (event is MapToggleColor) {
      //

      final newToggleColor = Map<int, bool>.from(state.mapToggleColor);
      newToggleColor.addAll(event.mapToggleColor);

      print('CreateCategoryProductBloc toggle $newToggleColor');
      yield state.copyWith(mapToggleColor: newToggleColor);
    } else if (event is DeleteAllCategories) {
      //

      listCategory.deleteAll();

      yield state.copyWith(listCategory: listCategory.get());
    } else if (event is DeleteGroupCategories) {
      //

      final getList = listCategory.get();

      final List<String> deleteWord = [];

      event.groupCategories.forEach((element) {
        deleteWord.add(
          getList[element],
        );
      });

      listCategory.deleteGroup(values: deleteWord);

      deleteWord.clear();
      event.groupCategories.clear();

      final listCategoryTemp = listCategory.get();
      SendListProductsCategoryService()
          .send(productsCategories: listCategoryTemp);

      yield state.copyWith(listCategory: listCategoryTemp);
    }
  }
}
