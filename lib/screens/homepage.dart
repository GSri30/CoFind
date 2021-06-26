import 'package:flutter/material.dart';
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
                      label: 'AMBULANCE', icon: Icons.help, w: 100, h: 100),
                  iconCard(
                      label: 'BLOOD',
                      icon: Icons.local_hospital,
                      w: 100,
                      h: 100),
                  iconCard(
                      label: 'HOSPITAL',
                      icon: Icons.bakery_dining,
                      w: 100,
                      h: 100),
                ]),
              ),
            ),
            Center(
              child: FittedBox(
                child: Row(
                  children: [
                    iconCard(
                        label: 'VACCINATION',
                        icon: Icons.grass,
                        w: 216,
                        h: 150),
                    iconCard(
                        label: 'TESTING', icon: Icons.grass, w: 216, h: 150),
                  ],
                ),
              ),
            ),
            Center(
              child: FittedBox(
                child: Row(
                  children: [
                    iconCard(
                        label: 'DOCTOR', icon: Icons.grass, w: 216, h: 150),
                    iconCard(
                        label: 'AWARENESS', icon: Icons.grass, w: 216, h: 150),
                  ],
                ),
              ),
            ),
            Center(
              child: FittedBox(
                child: Row(children: [
                  iconCard(
                      label: 'MEDICATIONS', icon: Icons.grass, w: 100, h: 100),
                  iconCard(
                      label: 'FOOD', icon: Icons.car_rental, w: 100, h: 100),
                  iconCard(
                      label: 'QUARANTINE',
                      icon: Icons.local_hospital,
                      w: 100,
                      h: 100),
                  iconCard(
                      label: 'FUNERAL',
                      icon: Icons.bakery_dining,
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
