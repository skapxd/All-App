import 'dart:async';

import 'package:allapp/src/data/services/product/product_service.dart';
import 'package:allapp/src/data/services/utils/utils_service.dart';
import 'package:allapp/src/data/shared/produc_store_pref/product_store_pref.dart';
import 'package:allapp/src/models/list_product.dart';
import 'package:allapp/src/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'crear_producto_page_event.dart';
part 'crear_producto_page_state.dart';

class CrearProductoBloc extends Bloc<CrearProductoEvent, CrearProductoState> {
  CrearProductoBloc()
      : super(CrearProductoState(
          listProduct: ListProductStorePref().get(),
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

      customShowSnackBar(
        context: event.context,
        text: Text(
          'Guardando datos, por favor, espere',
          style: TextStyle(
            color: hexaColor('#303030'),
          ),
        ),
      );

      print('CreateProduct');
      try {
        print('CreateProduct 1');
        String urlImage;
        if (event.pathImage != null) {
          urlImage = await UploadImageService().uploadLogo(
            path: event.pathImage,
          );
        }

        print('CreateProduct 2');
        print('CreateProduct ${event.pathImage}');
        print('CreateProduct $urlImage');

        final listProducts = await CreateProductService().push(
          id: event.id,
          availability: state.ifDisponibilidad,
          name: event.name,
          price: event.price,
          quantity: event.quantity,
          category: event.category,
          urlImageProductStore: urlImage,
        );
        print('CreateProduct 3');

        ListProductStorePref().set(value: listProducts);

        yield state.copyWith(listProduct: ListProductStorePref().get());
      } catch (e) {
        print(e);
        customShowSnackBar(
          context: event.context,
          text: Text(
            'Por favor intentelo de nuevo',
            style: TextStyle(
              color: hexaColor('#303030'),
            ),
          ),
        );
      }
    } else if (event is MapToggleColor) {
      //

      final newToggleColor = Map<int, bool>.from(state.mapToggleColor);
      newToggleColor.addAll(event.mapToggleColor);

      yield state.copyWith(mapToggleColor: newToggleColor);
    } else if (event is DeleteGroupCategories) {
      //

      print('object');
      // print(event.groupCategories);

      final getList = ListProductStorePref().get();

      final List<ListProductElement> deleteProducts = [];

      event.groupCategories.forEach((element) {
        deleteProducts.add(
          getList.listProduct[element],
        );
      });

      try {
        bool ifDelte = await DeleteGroupProducts().send(list: deleteProducts);

        if (ifDelte) {
          ListProductStorePref().delete(values: deleteProducts);
        }
        yield state.copyWith(listProduct: ListProductStorePref().get());
      } catch (e) {
        customShowSnackBar(
          context: event.context,
          text: Text(
            'Por favor intentelo de nuevo',
            style: TextStyle(
              color: hexaColor('#303030'),
            ),
          ),
        );
      }

      // deleteWord.clear();
      // event.groupCategories.clear();

      // listCategory.deleteGroup(values: deleteWord);

      // deleteWord.clear();
      // event.groupCategories.clear();

      // final listCategoryTemp = listCategory.get();
      // SendListProductsCategory().send(productsCategories: listCategoryTemp);

      // yield state.copyWith(listCategory: listCategoryTemp);
    }
  }
}
