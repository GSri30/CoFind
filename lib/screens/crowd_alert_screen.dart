import 'package:cofind/widgets/crowd_data_card.dart';
import 'package:flutter/material.dart';
import '../widgets/data_card.dart';
import 'package:cofind/data/ResourcesCRUD.dart';
import 'package:cofind/data/constants.dart';
import 'package:intl/intl.dart';

class CrowdData extends StatefulWidget {
  static const routeName = '/crowd-data';
  @override
  _CrowdData createState() => _CrowdData();
}

class _CrowdData extends State<CrowdData> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String original_route = ModalRoute.of(context).settings.arguments as String;
    String route = toBeginningOfSentenceCase(original_route.toLowerCase());
    print(original_route);
    print(route);

    return Scaffold(
        appBar: AppBar(
          title: Text(original_route),
        ),
        body: FutureBuilder(
          future: CrowdRef.once(),
          builder: (context, snapshot) {
            return _listView(snapshot, route);
            // return Container();
          },
        ));
  }

  Widget _listView(AsyncSnapshot snapshot, String route) {
    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    } else {
      final filtered_data = ResourceCRUD.get_crowd_data(snapshot.data);

      if (filtered_data.length == 0) {
        return Container(
          margin: EdgeInsets.all(16),
          child: Text(
            "Sorry, no updates on crowd level currently!",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        );
      }

      return Center(
        child: ListView.builder(
          itemCount: filtered_data.length,
          itemBuilder: (BuildContext context, int index) {
            return CrowdDataCard(
              pincode: filtered_data[index].pincode,
              lastUpdatedAt: filtered_data[index].lastUpdatedAt,
              population: filtered_data[index].population,
            );
          },
        ),
      );
    }
  }
}
