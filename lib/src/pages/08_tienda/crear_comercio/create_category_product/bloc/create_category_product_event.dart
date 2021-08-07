part of 'create_category_product_bloc.dart';

@immutable
abstract class CreateCategoryProductEvent {}

class AddCategory extends CreateCategoryProductEvent {
  final String category;

  AddCategory(this.category);
}

class ToggleColor extends CreateCategoryProductEvent {
  ToggleColor();
}

class AddItemSelected extends CreateCategoryProductEvent {
  AddItemSelected();
}

class ClearItemSelected extends CreateCategoryProductEvent {
  ClearItemSelected();
}

class DeleteAllCategories extends CreateCategoryProductEvent {
  DeleteAllCategories();
}
