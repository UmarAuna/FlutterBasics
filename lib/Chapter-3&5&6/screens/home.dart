
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'recipes_screen.dart';
import 'explore_screen.dart';
import 'grocery_screen.dart';
import '../models/models.dart';


class Home extends StatefulWidget {

  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: FooderlichPages.home,
      key: ValueKey(FooderlichPages.home),
      child: Home(
        currentTab: currentTab,
      )
    );
  }

  const Home({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  final int currentTab;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

 // int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    ExploreScreen(),
    RecipesScreen(),
    const GroceryScreen()
    /* const Card1(),
    const Card2(),
    const Card3(),*/
  ];

 /* void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(builder: (context, appStateManager, child){
      return  Scaffold(
        appBar: AppBar(
          title: Text(
            'Fooderlich',
            style: Theme.of(context).textTheme.headline6,
          ),
          actions: [
            profileButton()
          ],
        ),
        //body: pages [tabManager.selectedTab],
        body: IndexedStack(index: widget.currentTab, children: pages),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
          currentIndex: widget.currentTab,
          onTap: (index){
            Provider.of<AppStateManager>(context, listen: false)
                .gotoTab(index);
          },
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
    },);

    /*return Scaffold(
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
    );*/
  }

  Widget profileButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            'assets/profile_pics/person_stef.jpeg',
          ),
        ),
        onTap: () {
         Provider.of<ProfileManager>(context, listen: false).tapOnProfile(true);
        },
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