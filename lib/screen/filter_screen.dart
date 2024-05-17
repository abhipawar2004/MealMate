import 'package:flutter/material.dart';

import '../widgets/drawer_main.dart';

class FilterScreen extends StatefulWidget {
  static const routeNames = '/filter';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FilterScreen(this.currentFilters, this.saveFilters);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _GlutenFree = false;
  bool _LactoseFree = false;
  bool _Vegan = false;
  bool _Vegetarian = false;

  @override
  void initState() {
    _GlutenFree = widget.currentFilters['gluten']!;
    _LactoseFree = widget.currentFilters['lactose']!;
    _Vegan = widget.currentFilters['vegan']!;
    _Vegetarian = widget.currentFilters['vegetarian']!;
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue as void Function(bool)?,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Your Filter'),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _GlutenFree,
                  'lactose': _LactoseFree,
                  'vegan': _Vegan,
                  'vegetarian': _Vegetarian,
                };
                widget.saveFilters(selectedFilters);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  'Gluten-Free',
                  'Only include gluten free meals',
                  _GlutenFree,
                  (newValue) {
                    setState(
                      () {
                        _GlutenFree = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-Free',
                  'Only include Lactose free meals',
                  _LactoseFree,
                  (newValue) {
                    setState(
                      () {
                        _LactoseFree = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegan-Free',
                  'Only include Vegan free meals',
                  _Vegan,
                  (newValue) {
                    setState(
                      () {
                        _Vegan = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian-Free',
                  'Only include vegetarian free meals',
                  _Vegetarian,
                  (newValue) {
                    setState(
                      () {
                        _Vegetarian = newValue;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
