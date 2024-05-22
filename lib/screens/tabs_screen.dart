import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import './favorites_screen.dart';
import './categories_screen.dart';
import '../models/meals.dart';

class Tabscreen extends StatefulWidget {
  final List<Meal> favouriteMeals;
  Tabscreen(this.favouriteMeals);
  @override
  State<Tabscreen> createState() => _TabscreenState();
}

class _TabscreenState extends State<Tabscreen> {
  List<Map<String, Object>> pages;
  int selectedPageIndex = 0;
  @override
  void initState() {
    pages =
        [
          {
            'page': CategoriesScreen(),
            'title': 'Categories',
          },
          {
            'page': FavoriteScreen(widget.favouriteMeals),
            'title': 'Your Favorite',
          },
        ];

    super.initState();
  }

  void selectPage(int index) {
    setState(
      () {
        selectedPageIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(pages[selectedPageIndex]['title']),
      ),
      body: pages[selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        backgroundColor: Colors.lightGreen,
        selectedItemColor: Colors.purple,
        currentIndex: selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
      ),
    );
  }
}
