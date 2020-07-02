import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String _categoryTitle;
  String _categoryId;
  List<Meal> _displayedMeals;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      getRouterArgs(context);
      _displayedMeals = getCategoryMeals();
    }
    _loadedInitData = true;
    super.didChangeDependencies();
  }

  void getRouterArgs(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    _categoryTitle = routeArgs['title'];
    _categoryId = routeArgs['id'];
  }

  List<Meal> getCategoryMeals() {
    return widget.availableMeals.where((meal) {
      return meal.categories.contains(_categoryId);
    }).toList();
  }

  void _removeMeal(String mealId) {
    setState(() {
      _displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
          itemBuilder: (ctx, index) {
            Meal meal = _displayedMeals[index];
            return MealItem(
              id: meal.id,
              title: meal.title,
              imageUrl: meal.imageUrl,
              complexity: meal.complexity,
              affordability: meal.affordability,
              duration: meal.duration,
            );
          },
          itemCount: _displayedMeals.length),
    );
  }
}
