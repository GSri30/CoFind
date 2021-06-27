import 'package:flutter/material.dart';
import '../data/EmergencyContactsCRUD.dart';
// import '../models/emergency_contact.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class EmergencyContactScreen extends StatefulWidget {
  String cityValue;
  EmergencyContactScreen({this.cityValue});

  @override
  _EmergencyContactScreenState createState() =>
      _EmergencyContactScreenState(city: cityValue);
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  String city;
  _EmergencyContactScreenState({this.city});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: FutureBuilder(
        future: Contacts.once(),
        builder: (context, snapshot) {
          return _listView(city, snapshot);
        },
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

Widget _listView(String city, AsyncSnapshot snapshot) {
  if (!snapshot.hasData) {
    return Center(child: CircularProgressIndicator());
  } else {
    final filteredData =
        EmergencyContactCRUD.read_specific(city, snapshot.data);

    if (filteredData.length == 0) {
      return Container(
        margin: EdgeInsets.all(16),
        child: Text(
          "Sorry, no verified emergency contacts available. Please come back again!",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      itemBuilder: (ctx, i) {
        return EmergencyContactCard(
          name: filteredData[i].name,
          number: filteredData[i].number,
        );
      },
      itemCount: filteredData.length,
    );
  }
}
