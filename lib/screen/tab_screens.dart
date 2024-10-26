import 'package:flutter/material.dart';

import 'package:meal_app/screen/categories_screen.dart';
import '../models/meal.dart';
import '../widgets/drawer_main.dart';
import './favorite_screen.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favoriteMeal;
  TabScreen(this.favoriteMeal);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, dynamic>> _pages;

  int _selectedindex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': const CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(widget.favoriteMeal),
        'title': 'Your Favorites',
      }
    ]; 
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedindex]['title']),
      ),
      drawer: MyDrawer(),
      body: _pages[_selectedindex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
        onTap: _selectedPage,
        currentIndex: _selectedindex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }
}
