import 'package:cofind/screens/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:cofind/models/user.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cofind/data/UsersCRUD.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    user usr = UserCRUD.get(context);

    String userName = "User";
    if (usr.name != null) {
      userName = usr.name;
    }

    final String email = usr.emailID;
    final String hasVerified = usr.hasVerifiedEmail;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Column(
        children: [
          // user name
          EditableCard(
            controller: nameController,
            title: userName,
            subtitle: 'Name',
            editText: 'Enter your name',
            icon: Icon(Icons.person),
          ),

          // email

          EditableCard(
            controller: nameController,
            title: email,
            subtitle: 'Email',
            editText: 'Enter your email',
            icon: Icon(Icons.email),
          ),

          // list of added entries with delete options
        ],
      ),
    );
  }
}

class EditableCard extends StatefulWidget {
  EditableCard({
    @required this.controller,
    @required this.title,
    @required this.subtitle,
    @required this.editText,
    @required this.icon,
  });

  final TextEditingController controller;
  String title;
  final String subtitle;
  final String editText;
  final Icon icon;

  @override
  _EditableCardState createState() => _EditableCardState();
}

class _EditableCardState extends State<EditableCard> {
  void showEditModalSheet(context, controller, editText, subtitle) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      editText,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: TextField(
                      style: TextStyle(fontSize: 20),
                      autofocus: true,
                      controller: controller,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('CANCEL')),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                widget.title = controller.text;
                                if (subtitle == "Name") {
                                  UserCRUD.update(context,
                                      new_display_name: controller.text);
                                } else if (subtitle == "Email") {
                                  UserCRUD.update(context,
                                      new_email: controller.text);
                                }
                                context.signOut();
                                Navigator.of(context)
                                    .pushReplacement(AuthScreen.route);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Hey CoFind'er! Please re-login to view your updated information.")));
                              });
                            },
                            child: Text('SAVE'))
                      ],
                    ),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.controller..text = widget.title;
        showEditModalSheet(
            context, widget.controller, widget.editText, widget.subtitle);
      },
      child: Container(
        margin: EdgeInsets.all(16),
        child: ListTile(
          leading: widget.icon,
          title: Text(widget.title),
          subtitle: Text(widget.subtitle),
          trailing: Icon(Icons.edit),
        ),
      ),
    );
  }
}
