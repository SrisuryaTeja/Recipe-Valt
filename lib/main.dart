import 'package:flutter/material.dart';
import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/categories_meals_screen.dart';
import './screens/tabs_screen.dart';
import './models/meals.dart';
import './dummy.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  void _setfilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
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
  bool _isMealFavorite(String id)
  {
    return _favoriteMeals.any((meal) => meal.id==id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals app',
      theme: ThemeData(
          // canvasColor: Color.fromRGBO(255, 254, 229, 1),
          // fontFamily: 'Raleway',
          // textTheme: ThemeData.light().textTheme.copyWith(
          //       bodyText1: TextStyle(
          //         color: Color.fromRGBO(20, 51, 51, 1),
          //       ),
          //       bodyText2: TextStyle(
          //         color: Color.fromRGBO(20, 51, 51, 1),
          //       ),
          //       subtitle1: TextStyle(
          //         fontSize: 24,
          //         fontFamily: 'RobotoCondensed',
          //       ),
          //     ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(secondary: Colors.amber)
          primarySwatch: Colors.blue),
      routes: {
        '/': (ctx) => Tabscreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FilterScreen.routename: (ctx) => FilterScreen(_filters, _setfilters)
      },
    );
  }
}
