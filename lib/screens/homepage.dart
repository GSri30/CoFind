import 'package:cofind/screens/crowd_alert_screen.dart';
import 'package:cofind/widgets/disclaimer_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/icon_card.dart';

class HomePage extends StatelessWidget {
  String cityValue;
  HomePage({this.cityValue});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        child: Column(children: [
          // Disclaimer box
          DisclaimerCard(),
          SizedBox(
            height: 8,
          ),
          Center(
            child: FittedBox(
              child: Row(children: [
                iconCard(
                  label: 'OXYGEN',
                  icon: Icons.grass,
                  w: 100,
                  h: 100,
                  city: cityValue,
                ),
                iconCard(
                  label: 'AMBULANCE',
                  icon: FontAwesomeIcons.ambulance,
                  w: 100,
                  h: 100,
                  city: cityValue,
                ),
                iconCard(
                  label: 'BLOOD',
                  icon: Icons.local_hospital,
                  w: 100,
                  h: 100,
                  city: cityValue,
                ),
                iconCard(
                  label: 'HOSPITAL',
                  icon: FontAwesomeIcons.hospital,
                  w: 100,
                  h: 100,
                  city: cityValue,
                ),
              ]),
            ),
          ),
          Center(
            child: FittedBox(
              child: Row(
                children: [
                  iconCard(
                    label: 'VACCINATION',
                    icon: FontAwesomeIcons.syringe,
                    w: 216,
                    h: 150,
                    city: cityValue,
                  ),
                  iconCard(
                    label: 'TESTING',
                    icon: FontAwesomeIcons.vial,
                    w: 216,
                    h: 150,
                    city: cityValue,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: FittedBox(
              child: Row(
                children: [
                  iconCard(
                    label: 'DOCTOR',
                    icon: FontAwesomeIcons.userMd,
                    w: 216,
                    h: 150,
                    city: cityValue,
                  ),
                  iconCard(
                    route: CrowdData.routeName,
                    label: 'CROWD LEVEL',
                    icon: FontAwesomeIcons.searchLocation,
                    w: 216,
                    h: 150,
                    city: cityValue,
                    routeLabel: 'CROWD LEVEL',
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: FittedBox(
              child: Row(children: [
                iconCard(
                  label: 'MEDICATION',
                  icon: FontAwesomeIcons.tablets,
                  w: 100,
                  h: 100,
                  city: cityValue,
                ),
                iconCard(
                  label: 'FOOD',
                  icon: FontAwesomeIcons.utensilSpoon,
                  w: 100,
                  h: 100,
                  city: cityValue,
                ),
                iconCard(
                  label: 'QUARANTINE',
                  icon: FontAwesomeIcons.houseUser,
                  w: 100,
                  h: 100,
                  city: cityValue,
                ),
                iconCard(
                  label: 'FUNERAL',
                  icon: FontAwesomeIcons.skullCrossbones,
                  w: 100,
                  h: 100,
                  city: cityValue,
                ),
              ]),
            ),
          ),
          SizedBox(
            height: 8,
          ),
        ]),
      ),
    );
  }
}
