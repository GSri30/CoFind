import 'package:flutter/material.dart';
import '../widgets/data_card.dart';
import 'package:cofind/data/ResourcesCRUD.dart';
import 'package:cofind/data/constants.dart';
import 'package:intl/intl.dart';

class VerifyDataScreen extends StatefulWidget {
  static const routeName = '/verify-data';
  @override
  _VerifyDataScreenState createState() => _VerifyDataScreenState();
}

class _VerifyDataScreenState extends State<VerifyDataScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String original_route = ModalRoute.of(context).settings.arguments as String;
    // String route = toBeginningOfSentenceCase(original_route.toLowerCase());

    final String route = 'blood';

    return Scaffold(
        appBar: AppBar(
          title: Text('Verify Data'),
        ),
        body: FutureBuilder(
          future: Resources.once(),
          builder: (context, snapshot) {
            return _listView(snapshot, route);
          },
        ));
  }

  Widget _listView(AsyncSnapshot snapshot, String route) {
    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    } else {
      final filtered_data = ResourceCRUD.get_unverified(snapshot.data);

      if (filtered_data.length == 0) {
        return Container(
          margin: EdgeInsets.all(16),
          child: Text(
            "Sorry, no data to be verified. Please come back again!",
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
              isAdmin: true,
              isVerified: filtered_data[index].isVerified as String,
              resourceType: filtered_data[index].ResourceType,
              resourceID: filtered_data[index].ResourceID,
            );
          },
        ),
      );
    }
  }
}
