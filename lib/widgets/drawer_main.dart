import 'package:flutter/material.dart';
import 'package:meal_app/screen/filter_screen.dart';

class MyDrawer extends StatelessWidget {
  Widget buildListtile(IconData icon, String text, Function() tapHandler) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(
        text,
        style: const TextStyle(
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            
            alignment: Alignment.centerLeft,
            child: const Text(
              'Cooking Up!',
              style: TextStyle(
                
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buildListtile(
            Icons.restaurant,
            'Meal',
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          buildListtile(
            Icons.settings,
            'Filter',
            () {
              Navigator.of(context).pushReplacementNamed(FilterScreen.routeNames);
            },
          ),
        ],
      ),
    );
  }
}
