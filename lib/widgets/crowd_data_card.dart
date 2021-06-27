import 'package:cofind/config/palette.dart';
import 'package:cofind/data/ResourcesCRUD.dart';
import 'package:cofind/data/Utils.dart';
import 'package:cofind/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter/gestures.dart';

TextStyle labelStyle = const TextStyle(color: Colors.grey, fontSize: 16.0);
TextStyle infoStyle = const TextStyle(color: Colors.black, fontSize: 16.0);
TextStyle heading = const TextStyle(
    color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500);
TextStyle linkStyle = const TextStyle(color: Colors.blue, fontSize: 16.0);

class CrowdDataCard extends StatelessWidget {
  final String pincode;
  final String population;
  final String lastUpdatedAt;

  CrowdDataCard({
    this.pincode,
    this.population,
    this.lastUpdatedAt,
  });

  @override
  Widget build(BuildContext context) {
    List<String> data = Utils.time_difference(this.lastUpdatedAt);
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                child: Text(
                  "${data[0]} ${data[1]} ${data[2]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                    color: Palette.lightBlue,
                    borderRadius: BorderRadius.circular(10)),
              ),
              ListTile(
                title: Text(
                  pincode,
                  style: heading,
                ),
                trailing: CircularProgressIndicator(
                  backgroundColor: Colors.black12,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      indicatorColor(double.parse(population) / 10)),
                  value: double.parse(population) / 10,
                  strokeWidth: 6,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Color indicatorColor(double percentage) {
  if (percentage < 0.3) {
    return Colors.green;
  } else if (percentage >= 0.3 && percentage < 0.5) {
    return Colors.yellow;
  } else if (percentage >= 0.5) {
    return Colors.red;
  }
}
