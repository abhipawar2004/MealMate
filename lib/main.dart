import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';

import 'package:meal_app/screen/meal_detail_screen.dart';
import './screen/tab_screens.dart';
import './screen/category_meals_screen.dart';
import './screen/filter_screen.dart';
import 'models/meal.dart';

void main() => runApp(const MealApp());

class MealApp extends StatefulWidget {
  const MealApp({super.key});

  @override
  State<MealApp> createState() => _MealAppState();
}

class _MealAppState extends State<MealApp> {
  Map<String, bool> _filter = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filter = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filter['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filter['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filter['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filter['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }
  bool _isMealFavorite(String id){
      return _favoriteMeals.any((meal) => meal.id==id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal-Mate',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(),
        primarySwatch: Colors.pink,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyMedium: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              titleMedium: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      initialRoute: '/',
      // home: CategoriesScreen(),
      routes: {
        '/': (context) => TabScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FilterScreen.routeNames: (ctx) => FilterScreen(_filter, _setFilters),
      },
    );
  }
}
