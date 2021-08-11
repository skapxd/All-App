import 'dart:async';

import 'package:allapp/src/data/services/product/product_service.dart';
import 'package:allapp/src/data/shared/produc_store_pref/product_store_pref.dart';
import 'package:allapp/src/models/list_product.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'crear_producto_page_event.dart';
part 'crear_producto_page_state.dart';

class CrearProductoBloc extends Bloc<CrearProductoEvent, CrearProductoState> {
  CrearProductoBloc()
      : super(CrearProductoState(
          listProduct: ListProductStorePrefPref().get(),
        ));

  @override
  Stream<CrearProductoState> mapEventToState(
    CrearProductoEvent event,
  ) async* {
    if (event is AddPathImageProduct) {
      //

      yield state.copyWith(pathImageProduct: event.pathImageProduct);
    }

    if (event is AddIfDisponibilidad) {
      //

      yield state.copyWith(ifDisponibilidad: event.ifDisponibilidad);
    }

    if (event is AddNonbre) {
      //

      yield state.copyWith(nonbre: event.nonbre);
    }

    if (event is AddPrecio) {
      //

      yield state.copyWith(precio: event.precio);
    }

    if (event is AddCantidad) {
      //

      yield state.copyWith(cantidad: event.cantidad);

      //
    } else if (event is CreateProduct) {
      //

      final listProducts = await CreateProductService().push(
        availability: state.ifDisponibilidad,
        name: event.name,
        price: event.price,
        quantity: event.quantity,
        category: event.category,
        urlImageProductStore: event.urlImageProductStore,
      );

      print(
          'listProducts.listProduct.length ${listProducts.listProduct.length}');

      yield state.copyWith(listProduct: listProducts);
    } else if (event is MapToggleColor) {
      //

      final newToggleColor = Map<int, bool>.from(state.mapToggleColor);
      newToggleColor.addAll(event.mapToggleColor);

      yield state.copyWith(mapToggleColor: newToggleColor);
    } else if (event is DeleteGroupCategories) {
      //

      print('object');

      final getList = ListProductStorePrefPref().get();

      // final List<String> deleteWord = [];

      event.groupCategories.forEach((element) {
        deleteWord.add(
          getList[element],
        );
      });

      // listCategory.deleteGroup(values: deleteWord);

      // deleteWord.clear();
      // event.groupCategories.clear();

      // final listCategoryTemp = listCategory.get();
      // SendListProductsCategory().send(productsCategories: listCategoryTemp);

      // yield state.copyWith(listCategory: listCategoryTemp);
    }
  }
}
