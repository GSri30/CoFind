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
                    label: 'Oxygen',
                    icon: Icons.grass,
                    w: 100,
                    h: 100,
                  ),
                  iconCard(
                      label: 'Ambulance',
                      icon: Icons.car_rental,
                      w: 100,
                      h: 100),
                  iconCard(
                      label: 'Hospital',
                      icon: Icons.local_hospital,
                      w: 100,
                      h: 100),
                  iconCard(
                      label: 'Blood',
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
                        label: 'Oxygen', icon: Icons.grass, w: 216, h: 150),
                    iconCard(
                        label: 'Oxygen', icon: Icons.grass, w: 216, h: 150),
                  ],
                ),
              ),
            ),
            Center(
              child: FittedBox(
                child: Row(
                  children: [
                    iconCard(
                        label: 'Oxygen', icon: Icons.grass, w: 216, h: 150),
                    iconCard(
                        label: 'Oxygen', icon: Icons.grass, w: 216, h: 150),
                  ],
                ),
              ),
            ),
            Center(
              child: FittedBox(
                child: Row(children: [
                  iconCard(
                      label: 'Medication', icon: Icons.grass, w: 100, h: 100),
                  iconCard(
                      label: 'Food', icon: Icons.car_rental, w: 100, h: 100),
                  iconCard(
                      label: 'Quarantine',
                      icon: Icons.local_hospital,
                      w: 100,
                      h: 100),
                  iconCard(
                      label: 'Funeral',
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
