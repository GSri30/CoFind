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

  final isAdmin = false;

  Widget adminView(String institutionName) {
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
        SizedBox(
          width: 16,
        ),
        IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.lightGreen,
            ),
            onPressed: () {}),
        SizedBox(
          width: 24,
        ),
        IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () {}),
      ]),
    );
  }

  Widget userView(String institutionName) {
    return Container(
      margin: EdgeInsets.all(8),
      width: double.infinity,
      child: Text(
        institutionName,
        textAlign: TextAlign.left,
        style: heading,
      ),
    );
  }

  DataCard({
    this.institutionName,
    this.phoneNumber,
    this.alternateNumber,
    this.location,
    this.serviceNote,
    this.city,
  });

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
            children: [
              // Institution Name and call button
              isAdmin ? adminView(institutionName) : userView(institutionName),

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
