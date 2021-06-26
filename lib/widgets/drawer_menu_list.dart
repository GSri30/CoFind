import 'package:cofind/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import '../screens/auth/auth.dart';

class DrawerMenuList extends StatefulWidget {
  // const DrawerMenuList({Key? key}) : super(key: key);

  @override
  _DrawerMenuListState createState() => _DrawerMenuListState();
}

class _DrawerMenuListState extends State<DrawerMenuList> {
  final isAdmin = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomListTile(
          text: "Edit Profile",
          onTap: () {
            Navigator.of(context).pushNamed(ProfileScreen.routeName);
          }, //add method for changing email or name or both
          icon: Icons.edit,
        ),
        isAdmin
            ? CustomListTile(
                text: "Verify",
                onTap:
                    () {}, // add method to verify the resources only for admin
                icon: Icons.rule,
              )
            : Container(),
        CustomListTile(
          text: "Log Out",
          onTap: () {
            context.signOut();
            Navigator.of(context).pushReplacement(AuthScreen.route);
          }, // add method to log out
          icon: Icons.logout,
          color: Colors.red,
          rightArrowNeeded: false,
        ),
      ],
    );
  }
}

class CustomListTile extends StatelessWidget {
  String text = 'default';
  IconData icon;
  Function onTap;
  Color color;
  bool rightArrowNeeded;

  CustomListTile(
      {this.icon,
      this.text,
      this.onTap,
      this.color = Colors.black,
      this.rightArrowNeeded = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        // decoration: BoxDecoration(
        //     border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    icon,
                    color: color,
                  ),
                  Padding(
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    padding: EdgeInsets.fromLTRB(10.0, 0, 8.0, 0),
                  )
                ],
              ),
              if (rightArrowNeeded) Icon(Icons.arrow_right),
            ],
          ),
        ),
      ),
    );
  }
}
