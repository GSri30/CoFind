import 'package:flutter/material.dart';
import '../widgets/data_card.dart';
import 'package:cofind/data/ResourcesCRUD.dart';
import 'package:cofind/data/constants.dart';
import 'package:intl/intl.dart';

class DisplayDataScreen extends StatefulWidget {
  static const routeName = '/display-data';
  @override
  _DisplayDataScreenState createState() => _DisplayDataScreenState();
}

class _DisplayDataScreenState extends State<DisplayDataScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments as List<String>;
    String original_route = args[0];
    String city = args[1];
    String route = toBeginningOfSentenceCase(original_route.toLowerCase());

    return Scaffold(
        appBar: AppBar(
          title: Text(original_route),
        ),
        body: FutureBuilder(
          future: Resources.orderByChild("ResourceType")
              .equalTo(RESOURCE_TYPE_CONVERTER[route])
              .once(),
          builder: (context, snapshot) {
            return _listView(snapshot, route, city);
          },
        ));
  }

  Widget _listView(AsyncSnapshot snapshot, String route, String city) {
    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    } else {
      final filtered_data = ResourceCRUD.get_verified_city(snapshot.data, city);

      if (filtered_data.length == 0) {
        return Container(
          margin: EdgeInsets.all(16),
          child: Text(
            "Sorry, no verified '${route}' resources are currently available. Please come back again!",
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
              isVerified: filtered_data[index].isVerified,
            );
          },
        ),
      );
    }
  }
}
