part of 'create_category_product_bloc.dart';

@immutable
class CreateCategoryProductState {
  final List<String> listCategory;
  final Map<int, bool> mapToggleColor;
  final bool toggleColor;

  CreateCategoryProductState({
    this.listCategory,
    this.mapToggleColor = const {},
    this.toggleColor = false,
  });

  CreateCategoryProductState copyWith({
    List<String> listCategory,
    Map<int, bool> mapToggleColor,
    int itemsSelected,
    bool toggleColor,
  }) {
    return CreateCategoryProductState(
      listCategory: listCategory ?? this.listCategory,
      mapToggleColor: mapToggleColor ?? this.mapToggleColor,
      toggleColor: toggleColor ?? this.toggleColor,
    );
  }
}
