import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/icon_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 8, right: 8),
          child: Column(children: [
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
                  ),
                  iconCard(
                    label: 'AMBULANCE',
                    icon: FontAwesomeIcons.ambulance,
                    w: 100,
                    h: 100,
                  ),
                  iconCard(
                      label: 'BLOOD',
                      icon: Icons.local_hospital,
                      w: 100,
                      h: 100),
                  iconCard(
                    label: 'HOSPITAL',
                    icon: FontAwesomeIcons.hospital,
                    w: 100,
                    h: 100,
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
                        h: 150),
                    iconCard(
                      label: 'TESTING',
                      icon: FontAwesomeIcons.vial,
                      w: 216,
                      h: 150,
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
                    ),
                    iconCard(
                      label: 'AWARENESS',
                      icon: FontAwesomeIcons.newspaper,
                      w: 216,
                      h: 150,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: FittedBox(
                child: Row(children: [
                  iconCard(
                    label: 'MEDICATIONS',
                    icon: FontAwesomeIcons.tablets,
                    w: 100,
                    h: 100,
                  ),
                  iconCard(
                    label: 'FOOD',
                    icon: FontAwesomeIcons.utensilSpoon,
                    w: 100,
                    h: 100,
                  ),
                  iconCard(
                      label: 'QUARANTINE',
                      icon: FontAwesomeIcons.houseUser,
                      w: 100,
                      h: 100),
                  iconCard(
                      label: 'FUNERAL',
                      icon: FontAwesomeIcons.skullCrossbones,
                      w: 100,
                      h: 100),
                ]),
              ),
            ),
            SizedBox(
              height: 8,
            ),
          ]),
        ),
      ),
    );
  }
}
