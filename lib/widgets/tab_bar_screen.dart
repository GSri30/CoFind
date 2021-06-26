import 'package:flutter/material.dart';
import '../screens/homepage.dart';
import '../screens/emergency_contacts_screen.dart';
import '../screens/add_data_screen.dart';

class TabBarScreen extends StatefulWidget {
  @override
  _TabBarScreenState createState() => _TabBarScreenState();

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => TabBarScreen(),
      );
}

class _TabBarScreenState extends State<TabBarScreen> {
  int _pageNum = 0;

  PageController _page = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: _pageNum == 0 ? Text('Home') : Text('Emergency Contacts'),
      ),

      // Bottom App Bar
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 75,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: IconButton(
                  iconSize: 30.0,
                  icon: _pageNum == 0
                      ? Icon(Icons.home)
                      : Icon(Icons.home_outlined),
                  onPressed: () {
                    setState(() {
                      _page.jumpToPage(0);
                    });
                  },
                ),
              ),
              Expanded(
                child: IconButton(
                  iconSize: 30.0,
                  icon: _pageNum == 1
                      ? Icon(Icons.add_call)
                      : Icon(Icons.add_ic_call_outlined),
                  onPressed: () {
                    setState(() {
                      _page.jumpToPage(1);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // Body PageView
      body: PageView(
        controller: _page,
        onPageChanged: (num) {
          setState(() {
            _pageNum = num;
          });
        },

        // Pages widget Home and emergency contact Number
        children: <Widget>[
          // first page : Home page
          HomePage(),

          // Second page : Emergency contact page
          EmergencyContactScreen()
        ],
        physics:
            NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
      ),

      // Floating Action Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: Container(
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              // Action Button will push the route name for Adding Resources
              Navigator.of(context).pushNamed(AddDataScreen.routeName);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            elevation: 5.0,
          ),
        ),
      ),
    );
  }
}
