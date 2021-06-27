import 'package:cofind/screens/crowd_alert_screen.dart';
import 'package:flutter/material.dart';
import '../screens/display_data_screen.dart';

class iconCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final double w;
  final double h;
  final String city;
  final String route;
  final String routeLabel;

  iconCard(
      {this.label,
      this.icon,
      this.w,
      this.h,
      this.city,
      this.route = '',
      this.routeLabel = ''});

  final List<BoxShadow> softShadow = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.1),
      spreadRadius: -2,
      blurRadius: 15,
      offset: Offset(2, 2), // changes position of shadow
    ),
  ];

  Gradient softGradient(ctx) {
    return LinearGradient(
      colors: [
        Colors.white,
        Theme.of(ctx).primaryColorLight.withOpacity(0.4),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      child: InkWell(
        onTap: () {
          if (route == '')
            Navigator.of(context).pushNamed(DisplayDataScreen.routeName,
                arguments: [label, city]);
          else {
            Navigator.of(context).pushNamed(route, arguments: routeLabel);
          }
        },
        borderRadius: BorderRadius.circular(15),
        splashColor: Theme.of(context).primaryColor,
        child: Container(
          width: w,
          height: h,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                icon,
                size: 36,
              ),
              FittedBox(
                child: Text(
                  label,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            gradient: softGradient(context),
            borderRadius: BorderRadius.circular(15),
            boxShadow: softShadow,
          ),
        ),
      ),
    );
  }
}
