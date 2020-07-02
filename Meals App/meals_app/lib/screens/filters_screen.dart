import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.saveFilters,this.currentFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegan = false;
  var _vegetarian = false;

  @override
  initState() { 
    _glutenFree = widget.currentFilters['gluten'];
        _lactoseFree = widget.currentFilters['lacttose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];

    super.initState();
  }
  Widget _buildSwitchListTile(
      String title, String subTitle, bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Meals'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
                'lacttose': _lactoseFree,
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust Your Meal Selection!',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Lactose-FREE',
                  'Only include Lactose-FREE meals',
                  _lactoseFree,
                  (newValue) => setState(() => _lactoseFree = newValue),
                ),
                _buildSwitchListTile(
                  'GLUTEN-FREE',
                  'Only include GLUTEN-FREE meals',
                  _glutenFree,
                  (newValue) => setState(() => _glutenFree = newValue),
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include Vegetarian meals',
                  _vegetarian,
                  (newValue) => setState(() => _vegetarian = newValue),
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include Vegan meals',
                  _vegan,
                  (newValue) => setState(() => _vegan = newValue),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
