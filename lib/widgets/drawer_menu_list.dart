import 'package:cofind/models/user.dart';
import 'package:cofind/screens/approve_volunteers_screen.dart';
import 'package:cofind/screens/profile_screen.dart';
import 'package:cofind/screens/verify_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/auth/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerMenuList extends StatefulWidget {
  user usr;
  DrawerMenuList({Key key, this.usr}) : super(key: key);

  @override
  _DrawerMenuListState createState() => _DrawerMenuListState();
}

class _DrawerMenuListState extends State<DrawerMenuList> {
  bool isAdmin = false;

  @override
  void initState() {
    final currentUser = context.getSignedInUser();
    currentUser.when(
      (user) {
        if (user.isEmailVerified) {
          isAdmin = true;
        } else {
          isAdmin = false;
        }
      },
      empty: () => print("NO USER"),
      initializing: () => print("Something Went Wrong"),
    );

    if (isAdmin) {}
    super.initState();
  }

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
        if (isAdmin)
          CustomListTile(
            text: "Verify Data",
            onTap: () {
              Navigator.of(context).pushNamed(VerifyDataScreen.routeName);
            }, // add method to verify the resources only for admin
            icon: Icons.rule,
          ),
        if (isAdmin)
          CustomListTile(
            text: "Approve Volunteers",
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ApproveVolunteersScreen.routeName);
            }, // add method to verify the resources only for admin
            icon: FontAwesomeIcons.userPlus,
          ),
        if (!isAdmin)
          CustomListTile(
            text: "Become a volunteer",
            onTap: () {
              popupVolunteer(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Request for volunteering has been sent!")));
            }, // add method to verify the resources only for admin
            icon: FontAwesomeIcons.handsHelping,
          ),
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
                    padding: EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
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

void popupVolunteer(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Become a volunteer'),
        content: Text("Click yes to send a request to become a volunteer"),
        actions: <Widget>[
          TextButton(
            child: Text("YES"),
            onPressed: () {
              // code for sending request and changing changing user detail
              // hasRequest --> true

              //Put your code here which you want to execute on Yes button click.
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("NO"),
            onPressed: () {
              //Put your code here which you want to execute on No button click.
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
