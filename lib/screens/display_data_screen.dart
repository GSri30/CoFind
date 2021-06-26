import 'package:flutter/material.dart';
import '../models/resource_model.dart';
import '../widgets/data_card.dart';

class DisplayDataScreen extends StatelessWidget {
  static const routeName = '/display-data';

  @override
  Widget build(BuildContext context) {
    final String route = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
        appBar: AppBar(
          title: Text(route),
        ),
        body: Center(
          child: Column(
            children: [
              DataCard(
                institutionName: DUMMY_DATA[0].institutionName,
                phoneNumber: DUMMY_DATA[0].phoneNumber,
                alternateNumber: DUMMY_DATA[0].alternateNumber,
                location: DUMMY_DATA[0].location,
                serviceNote: DUMMY_DATA[0].serviceNote,
              )
            ],
          ),
        ));
  }
}
