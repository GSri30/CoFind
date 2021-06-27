import 'package:cofind/data/ResourcesCRUD.dart';
import 'package:cofind/data/constants.dart';
import 'package:cofind/screens/auth/auth.dart';
import 'package:cofind/widgets/data_card.dart';
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
    print(UserCRUD.get(context).uid);
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

          // password reset clickable

          InkWell(
            onTap: () {
              // function for resetting password

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Hey CoFind'er! Email has been sent for password reset")));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: Icon(Icons.shield),
                title: Text('Reset password'),
                trailing: Icon(Icons.edit),
              ),
            ),
          ),

          // list of added entries with delete options

          Container(
            margin: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your Submissions',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Expanded(
            child: Container(
                child: FutureBuilder(
              future: Resources.once(),
              builder: (context, snapshot) {
                return _listView(usr.uid, snapshot);
              },
            )),
          ),
        ],
      ),
    );
  }
}

Widget _listView(uid, AsyncSnapshot snapshot) {
  if (!snapshot.hasData) {
    return Center(child: CircularProgressIndicator());
  } else {
    final filtered_data = ResourceCRUD.get_user_specific(uid, snapshot.data);

    if (filtered_data.length == 0) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          "No resource is submitted so far. Use plus button on homepage to share information about resources",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Center(
      child: ListView.builder(
        itemCount: filtered_data.length,
        itemBuilder: (BuildContext context, int index) {
          return DataCard(
            institutionName: filtered_data[index].InstitutionName,
            phoneNumber: filtered_data[index].PhoneNumber,
            alternateNumber: filtered_data[index].AlternateNumber,
            location: filtered_data[index].Location,
            serviceNote: filtered_data[index].ServiceNote,
            city: filtered_data[index].City,
            resourceType: filtered_data[index].ResourceType,
            resourceID: filtered_data[index].ResourceID,
            isDeletable: true,
          );
        },
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
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
