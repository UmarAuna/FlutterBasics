
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'screens/recipes_screen.dart';
import 'screens/explore_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    ExploreScreen(),
    RecipesScreen(),
    Container(color: Colors.blue),

    /* const Card1(),
    const Card2(),
    const Card3(),*/
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fooderlich',
          style: Theme.of(context).textTheme.headline6)),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore'
            ),
            const BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Recipes'
            ),
            const BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'To Buy'
            ),
          ],
      ),
    );
  }

  toast(String message){
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.white,
        fontSize: 14.0
    );
  }
}