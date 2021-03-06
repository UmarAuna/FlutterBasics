import 'package:flutter/material.dart';
import 'package:flutter_basics_2/Chapter-3&5&6&7&8/navigation/app_route_parser.dart';
import 'package:provider/provider.dart';
import '../fooderlich_theme.dart';
import 'screens/home.dart';
import 'models/models.dart';
import '../../Chapter-3&5&6&7&8/navigation/app_router.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatefulWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
  _FooderlichState createState() => _FooderlichState();
}

class _FooderlichState extends State<Fooderlich> {

  final _groceryManager = GroceryManager();
  final _profileManager = ProfileManager();
  final _appStateManager = AppStateManager();
  late AppRouter _appRouter;
  // TODO: Initialize RouteInformationParser
  final routeParser = AppRouteParser();

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      groceryManager: _groceryManager,
      profileManager: _profileManager,
    );
    super.initState();
  }

  // final theme = FooderlichTheme.dark();

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _groceryManager,),

        ChangeNotifierProvider(create: (context) => _appStateManager),

        ChangeNotifierProvider(create: (context) => _profileManager,),
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = FooderlichTheme.dark();
          } else {
            theme = FooderlichTheme.light();
          }

          // TODO: Replace with Material.router
          return MaterialApp.router(
            theme: theme,
            title: 'Fooderlich',
            //home: const SplashScreen(),
            backButtonDispatcher: RootBackButtonDispatcher(),
            routeInformationParser: routeParser,
            routerDelegate: _appRouter,
            /*home: Router(
              routerDelegate: _appRouter,
              //handling back button
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),*/
          );
        },
      ),
    );
  }
}
