import 'package:flutter/material.dart';
import './categories_screen.dart';
import './favourites_screen.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';

class TapsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;
  TapsScreen(this.favouriteMeals);

  @override
  _TapsScreenState createState() => _TapsScreenState();
}

class _TapsScreenState extends State<TapsScreen> {
  List<Map<String, Object>> _screens;

  int _selectedTapIndex = 0;

  @override
  void initState() {
    _screens = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavouritesScreen(widget.favouriteMeals), 'title': 'Favourites'},
    ];
    super.initState();
  }

  void _selectTap(int index) {
    setState(() => _selectedTapIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedTapIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _screens[_selectedTapIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTap,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedTapIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favourites'),
          ),
        ],
      ),
    );
  }
}
