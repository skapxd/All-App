part of 'create_category_product_bloc.dart';

@immutable
abstract class CreateCategoryProductEvent {}

class AddCategory extends CreateCategoryProductEvent {
  final String category;

  AddCategory(this.category);
}

class MapToggleColor extends CreateCategoryProductEvent {
  final Map<int, bool> mapToggleColor;
  MapToggleColor(this.mapToggleColor);
}

class ClearItemSelected extends CreateCategoryProductEvent {
  ClearItemSelected();
}

class DeleteAllCategories extends CreateCategoryProductEvent {
  DeleteAllCategories();
}

class DeleteGroupCategories extends CreateCategoryProductEvent {
  final List<int> groupCategories;

  DeleteGroupCategories(this.groupCategories);
}
