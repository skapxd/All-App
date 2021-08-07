part of 'create_category_product_bloc.dart';

@immutable
class CreateCategoryProductState {
  final Set<String> listCategory;
  final bool toggleColor;
  final int itemsSelected;

  CreateCategoryProductState({
    this.listCategory,
    this.itemsSelected = 0,
    this.toggleColor = false,
  });

  CreateCategoryProductState copyWith({
    Set<String> listCategory,
    bool toggleColor,
    int itemsSelected,
  }) {
    return CreateCategoryProductState(
      listCategory: listCategory ?? this.listCategory,
      toggleColor: toggleColor ?? this.toggleColor,
      itemsSelected: itemsSelected ?? this.itemsSelected,
    );
  }
}
