import 'package:flutter/material.dart';

class DisclaimerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Theme.of(context).primaryColorLight.withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: -2,
            blurRadius: 15,
            offset: Offset(2, 2), // changes position of shadow
          )
        ],
      ),
      margin: EdgeInsets.all(4),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Text(
          'Data in the listing is verified by volunteers. We do not guarantee of service or stock. If you know any leads for any resources, please help others by adding them using the plus button below.',
          style: TextStyle(
            color: Color(0xff2C98F0),
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
