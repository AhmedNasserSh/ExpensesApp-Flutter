import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  String _categoryTitle;
  String _categoryId;

  void getRouterArgs(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    _categoryTitle = routeArgs['title'];
    _categoryId = routeArgs['id'];
  }

  List<Meal> getCategoryMeals() {
    return DUMMY_MEALS.where((meal) {
      return meal.categories.contains(_categoryId);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    getRouterArgs(context);
    final categoryMeals = getCategoryMeals();
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
          itemBuilder: (ctx, index) {
            Meal meal = categoryMeals[index];
            return MealItem(
              id: meal.id,
              title: meal.title,
              imageUrl: meal.imageUrl,
              complexity: meal.complexity,
              affordability: meal.affordability,
              duration: meal.duration,
            );
          },
          itemCount: categoryMeals.length),
    );
  }
}
