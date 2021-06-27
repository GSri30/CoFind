import 'package:cofind/config/palette.dart';
import 'package:cofind/data/ResourcesCRUD.dart';
import 'package:cofind/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter/gestures.dart';

TextStyle labelStyle = const TextStyle(color: Colors.grey, fontSize: 16.0);
TextStyle infoStyle = const TextStyle(color: Colors.black, fontSize: 16.0);
TextStyle heading = const TextStyle(
    color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500);
TextStyle linkStyle = const TextStyle(color: Colors.blue, fontSize: 16.0);

class DataCard extends StatelessWidget {
  final String institutionName;
  final String phoneNumber;
  final String alternateNumber;
  final String location;
  final String serviceNote;
  final String city;
  final bool isAdmin;
  final String resourceType;
  final String resourceID;
  final bool isDeletable;
  final String isVerified;

  final serviceNoteController = TextEditingController();

  void openServiceNoteEditor(context) {
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
                      'Please add a Service Note',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: TextField(
                      maxLines: 3,
                      style: TextStyle(fontSize: 18),
                      autofocus: true,
                      controller: serviceNoteController,
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
                              ResourceCRUD.add_servicenote(
                                  this.resourceID, serviceNoteController.text);
                              ResourceCRUD.verify(this.resourceID);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Hey volunteer! Successfully added the service note and marked the resource as verified!")));
                              //Hard refresh!!!!

                              // value to be given to service note is
                              // in serviceNoteController.text

                              // this code was copied from the profile_screen

                              // setState(() {
                              //   widget.title = controller.text;
                              //   if (subtitle == "Name") {
                              //     UserCRUD.update(context,
                              //         new_display_name: controller.text);
                              //   } else if (subtitle == "Email") {
                              //     UserCRUD.update(context,
                              //         new_email: controller.text);
                              //   }
                              //   context.signOut();
                              //   Navigator.of(context)
                              //       .pushReplacement(AuthScreen.route);
                              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              //       content: Text(
                              //           "Hey CoFind'er! Please re-login to view your updated information.")));
                              // });
                            },
                            child: Text('SAVE'))
                      ],
                    ),
                  )
                ],
              ),
            ));
  }

  Widget adminView(String institutionName, BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 4, 8, 8),
      width: double.infinity,
      child: Row(children: [
        Expanded(
          child: Text(
            institutionName,
            textAlign: TextAlign.left,
            style: heading,
          ),
        ),
        SizedBox(
          width: 16,
        ),
        TextButton(
            child: Icon(
              Icons.done,
              color: Colors.lightGreen,
            ),
            onPressed: () {
              // logic for opening the service note sheet
              openServiceNoteEditor(context);
              // refreshing the page!
            }),
        SizedBox(
          width: 16,
        ),
        TextButton(
            child: Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () {
              ResourceCRUD.delete(this.resourceID);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Hey volunteer! Successfully deleted the resource.")));
              // and reloading the page
            }),
      ]),
    );
  }

  Widget userView(context, String institutionName) {
    return Container(
      margin: EdgeInsets.all(8),
      width: double.infinity,
      child: Row(children: [
        Expanded(
          child: Text(
            institutionName,
            textAlign: TextAlign.left,
            style: heading,
          ),
        ),
        if (this.isDeletable || this.isAdmin && this.isVerified == 'true')
          TextButton(
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                print(RESOURCE_TYPE_DECODER[this.resourceType]);
                // ResourceCRUD.delete(this.resourceID);
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     content: Text(
                //         "Hey volunteer! Successfully deleted the resource. Hope it has helped someone!")));
                // and reloading the page
              }),
      ]),
    );
  }

  DataCard({
    this.institutionName,
    this.phoneNumber,
    this.alternateNumber,
    this.location,
    this.serviceNote,
    this.city,
    this.isAdmin = false,
    this.resourceType = null,
    this.resourceID,
    this.isDeletable = false,
    this.isVerified = 'true',
  }) {
    print(resourceType);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 464,
      child: Card(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Resource type Chip

              if (isAdmin && isVerified == 'false')
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                  child: Text(
                    RESOURCE_TYPE_DECODER[resourceType],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Palette.lightBlue,
                      borderRadius: BorderRadius.circular(10)),
                ),

              // Institution Name and call button
              if (isAdmin && isVerified == 'false')
                adminView(institutionName, context)
              else
                userView(context, institutionName),

              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          UrlLauncher.launch("tel://" + phoneNumber);
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Phone Number',
                                style: labelStyle,
                              ),
                              Text(
                                phoneNumber,
                                style: linkStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          if (alternateNumber == "" ||
                              alternateNumber == null ||
                              alternateNumber == 'Null') {
                            return;
                          } else {
                            UrlLauncher.launch("tel://" + alternateNumber);
                          }
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Alternate Number',
                                style: labelStyle,
                              ),
                              alternateNumber == "" ||
                                      alternateNumber == null ||
                                      alternateNumber == 'Null'
                                  ? Text('not given')
                                  : Text(
                                      alternateNumber,
                                      style: linkStyle,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'City',
                            style: labelStyle,
                          ),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: city,
                                  style: infoStyle,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Locality',
                            style: labelStyle,
                          ),
                          alternateNumber == ''
                              ? Text('not given')
                              : RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: location,
                                        style: infoStyle,
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Service Note',
                      style: labelStyle,
                    ),
                    Text(
                      serviceNote,
                      style: infoStyle,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
