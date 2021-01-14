import 'package:stock_final/models/categori_models.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = new List<CategoryModel>();
  CategoryModel categoryModel = new CategoryModel();

  categoryModel.categoryName = "Stocks";
  categoryModel.imageUrl =
      "https://images.unsplash.com/photo-1462206092226-f46025ffe607?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1353&q=80";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Currency";
  categoryModel.imageUrl =
      "https://images.unsplash.com/photo-1462206092226-f46025ffe607?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1353&q=80";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "sjc";
  categoryModel.imageUrl =
      "https://images.unsplash.com/photo-1462206092226-f46025ffe607?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1353&q=80";
  category.add(categoryModel);

  return category;
}
