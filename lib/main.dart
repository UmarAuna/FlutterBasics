import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'Chapter-9&10&11&12&13&14&15/main_screen.dart';
import 'Chapter-9&10&11&12&13&14&15/mock_service/mock_service.dart';
import 'Chapter-9&10&11&12&13&14&15/data/repository.dart';
import 'Chapter-9&10&11&12&13&14&15/network/recipe_service.dart';
import 'Chapter-9&10&11&12&13&14&15/network/service_interface.dart';
import 'Chapter-9&10&11&12&13&14&15/data/moor/moor_repository.dart';


Future<void> main() async {
  _setupLogging();

  WidgetsFlutterBinding.ensureInitialized();
  final repository = MoorRepository();
  await repository.init();

  runApp(MyApp(repository: repository));
}


void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  final Repository repository;
  const MyApp({Key? key, required this.repository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
          Provider<Repository>(
            lazy: false,
            create: (_) => repository,
            dispose: (_, Repository repository) => repository.close(),
          ),
          Provider<ServiceInterface>(
            // you can change to MockService()..create() or RecipeService.create()
            create: (_) => RecipeService.create(),
            lazy: false,
          ),
        ],
      child: MaterialApp(
        title: 'Recipes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
