import 'package:flutter/material.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold)),
      ),
     // home: CategoriesScreen(),
      routes: {
        '/':(ctx) => TapsScreen(),
        CategoryMealsScreen.routeName:(ctx) => CategoryMealsScreen(),
        MealDetailsScreen.routeName: (ctx) => MealDetailsScreen()
      },
      // onGenerateRoute: (settings){
      //   return MaterialPageRoute(builder: (ctx) => CategoryMealsScreen()); // for undefined routes
      // },
      // onUnknownRoute:(settings){
      //   return MaterialPageRoute(builder: (ctx) => CategoryMealsScreen()); // if  onGenerateRoute not defined  or dosen't return valid navigation 
      // },
    );
  }
}
