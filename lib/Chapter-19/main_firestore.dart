import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/message_dao.dart';
import 'ui/message_list.dart';
import 'data/user_dao.dart';
import 'ui/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Add Firebase Initialization
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          //Add ChangeNotifierProvider<UserDao> here
          ChangeNotifierProvider<UserDao>(
            lazy: false,
            create: (_) => UserDao(),
          ),
          Provider<MessageDao>(
            lazy: false,
            create: (_) => MessageDao(),
          ),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RayChat',
        theme: ThemeData(primaryColor: const Color(0xFF3D814A)),
        //aAdd Consumer<UserDao> here
        home: Consumer<UserDao> (
          builder: (context, userDao, child) {
            if(userDao.isLoggedIn()) {
              return const MessageList();
            }else {
              return const Login();
            }
          },
        ),
      ),
    );

  }
}
