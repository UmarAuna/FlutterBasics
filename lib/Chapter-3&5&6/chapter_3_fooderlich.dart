import 'package:flutter/material.dart';
import 'package:flutter_basics_2/Chapter-3&5&6/models/grocery_manager.dart';
import 'package:provider/provider.dart';
import '../fooderlich_theme.dart';
import 'home.dart';
import 'models/models.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich  extends StatelessWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final theme = FooderlichTheme.dark();

    return MaterialApp(
      theme: theme,
      title: 'Fooderlich',
        // home: const Home()
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TabManager(),),
          ChangeNotifierProvider(create: (context) => GroceryManager(),),
        ],
        child: const Home(),
      )

    );
  }
}


