import 'package:flutter/material.dart';
import '../models/emergency_contact.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class EmergencyContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: ListView.builder(
        itemBuilder: (ctx, i) {
          return EmergencyContactCard(
            name: DUMMY_DATA[i].name,
            number: DUMMY_DATA[i].number,
          );
        },
        itemCount: DUMMY_DATA.length,
      ),
    );
  }
}

class EmergencyContactCard extends StatelessWidget {
  final String name;
  final String number;

  EmergencyContactCard({this.name, this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 464,
      child: Card(
        child: ListTile(
          title: Text(name),
          subtitle: Text(number),
          trailing: IconButton(
            icon: Icon(Icons.call),
            onPressed: () {
              UrlLauncher.launch("tel://" + number);
              print('calling');
            },
          ),
        ),
      ),
    );
  }
}
