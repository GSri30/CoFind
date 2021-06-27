import 'package:cofind/config/palette.dart';
import 'package:cofind/data/UsersCRUD.dart';
import 'package:cofind/models/user.dart';
import 'package:cofind/widgets/drawer_menu_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  // const CustomDrawer({Key? key}) : super(key: key);

  String email = ' ';
  String name = ' ';

  CustomDrawer({this.name = 'DefaultName', this.email = 'Example@gmail.com'});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String _email = 'ExampleName';
  String _name = 'Example@gmail.com';

  @override
  void initState() {
    _name = widget.name;
    _email = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user usr = UserCRUD.get(context);

    _name = "User";
    if (usr.name != null) {
      _name = usr.name;
    }
    _email = usr.emailID;

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(_name),
              accountEmail: Text(_email),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  // Colors.blue.shade900,
                  // Colors.lightBlueAccent,
                  Palette.darkBlue,
                  Palette.orange
                ]),
                // image: DecorationImage(
                //   image: AssetImage('assets/drawerImage.jpg'),
                // fit: BoxFit.cover,
                // )
              ),
            ),
            DrawerMenuList(
              usr: usr,
            ),
          ],
        ),
      ),
    );
  }
}
